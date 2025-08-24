# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "environs",
#     "msgspec[yaml]",
# ]
# ///

import collections
import subprocess
from pathlib import Path

import msgspec
from environs import env


def load(file: Path) -> dict[str, list[str]]:
    text: str
    if file.suffix == ".tmpl":
        process: subprocess.CompletedProcess[str] = subprocess.run(
            [
                env.str("CHEZMOI_EXECUTABLE", default="chezmoi"),
                "execute-template",
                file,
                "--file",
            ],
            stdout=subprocess.PIPE,
            check=True,
            text=True,
        )
        text = process.stdout
    else:
        text = file.read_text()
    data: dict[str, list[str]] = msgspec.yaml.decode(text)
    return data


def main() -> None:
    source_dir: Path = env.path("CHEZMOI_SOURCE_DIR", default=Path("home"))
    packages_dir: Path = source_dir / ".packages"
    packages: dict[str, list[str]] = collections.defaultdict(list)
    for dirpath, _, filenames in packages_dir.walk():
        for filename in filenames:
            file: Path = dirpath / filename
            updates: dict[str, list[str]] = load(file)
            for manager, package_names in updates.items():
                if not package_names:
                    continue
                packages[manager].extend(package_names)
    data_file: Path = source_dir / ".chezmoidata" / "packages.yaml"
    data_file.write_bytes(msgspec.yaml.encode({"packages": packages}))


if __name__ == "__main__":
    main()
