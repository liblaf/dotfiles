import contextlib
import os
import re
import subprocess
import sys
from collections.abc import Generator
from pathlib import Path
from typing import TYPE_CHECKING, Any, cast

import tomllib

if TYPE_CHECKING:
    from _typeshed import StrOrBytesPath

MIRROR_CDN: re.Pattern[str] = re.compile(r"https://(\S+)/packages\b")
MIRROR_INDEX: re.Pattern[str] = re.compile(r"https://(\S+)/simple\b")
UPSTREAM_CDN: str = "https://files.pythonhosted.org/packages"
UPSTREAM_INDEX: str = "https://pypi.org/simple"


def load_config_mirror() -> tuple[str, str]:
    with Path("~/.config/uv/uv.toml").expanduser().open("rb") as fp:
        config: dict[str, Any] = tomllib.load(fp)
    for index in config.get("index", []):
        index: dict[str, Any]
        if not index.get("default", False):
            continue
        url: str = index["url"]
        cdn: str = url.replace("/simple", "/packages")
        return url, cdn
    return UPSTREAM_INDEX, UPSTREAM_CDN


def load_optional_dependencies() -> dict[str, list[str]]:
    with Path("pyproject.toml").open("rb") as fp:
        pyproject: dict[str, Any] = tomllib.load(fp)
    project: dict[str, Any] = cast("dict[str, Any]", pyproject.get("project", {}))
    return project.get("optional-dependencies", {})


def lock_to_mirror(mirror_index: str, mirror_cdn: str) -> None:
    file: Path = Path("uv.lock")
    with _preserve_mtime(file):
        text: str = file.read_text()
        text: str = text.replace(UPSTREAM_INDEX, mirror_index)
        text: str = text.replace(UPSTREAM_CDN, mirror_cdn)
        file.write_text(text)


def lock_to_upstream() -> None:
    file: Path = Path("uv.lock")
    with _preserve_mtime(file):
        text: str = file.read_text()
        text: str = MIRROR_INDEX.sub(UPSTREAM_INDEX, text)
        text: str = MIRROR_CDN.sub(UPSTREAM_CDN, text)
        file.write_text(text)


@contextlib.contextmanager
def _preserve_mtime(file: Path) -> Generator[None]:
    atime_ns: int = file.stat().st_atime_ns
    mtime_ns: int = file.stat().st_mtime_ns
    try:
        yield
    finally:
        os.utime(file, ns=(atime_ns, mtime_ns))


def main() -> None:
    index, cdn = load_config_mirror()
    lock_to_mirror(index, cdn)

    args: list[StrOrBytesPath] = ["uv", "sync"]
    extras: list[str] = os.getenv("UV_SYNC_EXTRA", "").split(",")
    optional_dependencies: dict[str, list[str]] = load_optional_dependencies()
    extras: list[str] = [e for e in extras if e in optional_dependencies]
    for extra in extras:
        args.extend(["--extra", extra])
    args.extend(sys.argv[1:])
    process: subprocess.CompletedProcess[bytes] = subprocess.run(args, check=False)
    lock_to_upstream()
    if process.returncode != 0:
        sys.exit(process.returncode)


if __name__ == "__main__":
    main()
