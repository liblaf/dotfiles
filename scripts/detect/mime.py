import collections
import json
import os
from pathlib import Path
from typing import Any


def data_file() -> Path:
    data_file: str | None = os.getenv("CHEZMOI_SOURCE_DIR")
    assert data_file is not None
    return Path(data_file) / ".chezmoidata" / "generated" / "mime.json"


def save_data(data: Any) -> None:
    fpath: Path = data_file()
    with fpath.open("w") as fp:
        json.dump(data, fp)


def find_mimeinfo_cache() -> list[Path]:
    xdg_data_dirs: list[Path] = [
        Path(s) for s in os.getenv("XDG_DATA_DIRS", "").split(":")
    ]
    xdg_data_dirs.extend(
        [
            Path.home() / ".local/share",
            Path.home() / ".local/share/flatpak/exports/share",
            Path("/var/lib/flatpak/exports/share/"),
            Path("/usr/local/share/"),
            Path("/usr/share/"),
        ]
    )
    mimeinfo_cache_files: list[Path] = []
    for xdg_data_dir in xdg_data_dirs:
        mimeinfo_cache: Path = xdg_data_dir / "applications/mimeinfo.cache"
        if mimeinfo_cache.is_file():
            mimeinfo_cache_files.append(mimeinfo_cache)
    return mimeinfo_cache_files


def main() -> None:
    mimeinfo_cache_files: list[Path] = find_mimeinfo_cache()
    mimetypes: dict[str, set[str]] = collections.defaultdict(set)
    for mimeinfo_cache in mimeinfo_cache_files:
        with mimeinfo_cache.open("r") as fp:
            for line in fp:
                if line.startswith("#"):
                    continue
                mimetype: str
                sep: str
                mimetype, sep, _ = line.partition("=")
                if sep != "=":
                    continue
                mimetype = mimetype.strip()
                mimetype_type: str
                mimetype_subtype: str
                mimetype_type, sep, mimetype_subtype = mimetype.partition("/")
                mimetypes[mimetype_type].add(mimetype)
                if "." in mimetype_subtype:
                    mimetype_subtype = mimetype_subtype.split(".")[0]
                    mimetypes[f"{mimetype_type}/{mimetype_subtype}"].add(mimetype)
    save_data({"mime": {k: sorted(v) for k, v in mimetypes.items()}})


if __name__ == "__main__":
    main()
