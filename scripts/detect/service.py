import json
import os
import socket
import sys
from pathlib import Path
from typing import Any

CORE: set[str] = {
    "13900HX",
    "PC05",
}


EXTRA: set[str] = {
    "10700",
    "13900HX",
    "PC05",
    "PC06",
}


def data_file() -> Path:
    data_file: str | None = os.getenv("CHEZMOI_SOURCE_DIR")
    assert data_file is not None
    return Path(data_file) / ".chezmoidata" / "generated" / "service.json"


def load_data() -> Any:
    fpath: Path = data_file()
    if fpath.is_file():
        with fpath.open("r") as fp:
            return json.load(fp)
    else:
        return {}


def save_data(data: Any) -> Any:
    fpath: Path = data_file()
    with fpath.open("w") as fp:
        return json.dump(data, fp)


def slugify(name: str) -> str:
    return name.lower().replace(" ", "_").replace("-", "_")


def config_service(data: Any, name: str, *, on: bool) -> Any:
    print(f"Service > {name}: {on}", file=sys.stderr)
    data["service"][slugify(name)] = on
    return data


def main() -> None:
    hostname: str = socket.gethostname()
    core: bool = hostname in CORE
    extra: bool = (hostname in CORE) or (hostname in EXTRA)
    data: Any = load_data()
    data["service"] = {}

    # stateful services
    data = config_service(data, "Bing Wallpaper Backup", on=False)
    data = config_service(data, "Bitwarden Backup", on=False)
    data = config_service(data, "MLflow", on=core)
    data = config_service(data, "UFW Collector", on=core)
    data = config_service(data, "WebDAV", on=core)

    # stateless services
    data = config_service(data, "Caddy", on=extra)
    data = config_service(data, "GPT Academic", on=extra)
    data = config_service(data, "MinerU", on=extra)
    data = config_service(data, "Stirling PDF", on=extra)

    # always on
    data = config_service(data, "Restic", on=True)

    save_data(data)


if __name__ == "__main__":
    main()
