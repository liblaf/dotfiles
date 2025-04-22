import json
import os
import socket
from pathlib import Path
from typing import Any

CENTRAL: set[str] = {
    "10700",
}


SERVER: set[str] = {
    "10700",
    "13900HX",
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
    print(f"Service > {name}: {on}")
    data["service"][slugify(name)] = on
    return data


def main() -> None:
    hostname: str = socket.gethostname()
    data: Any = load_data()
    data["service"] = {}
    data = config_service(data, "Bitwarden Backup", on=hostname in CENTRAL)
    data = config_service(data, "Center", on=hostname in CENTRAL)
    data = config_service(data, "GPT Academic", on=hostname in SERVER)
    data = config_service(data, "MLflow", on=True)
    data = config_service(data, "Stirling PDF", on=hostname in SERVER)
    data = config_service(data, "WebDAV", on=True)
    save_data(data)


if __name__ == "__main__":
    main()
