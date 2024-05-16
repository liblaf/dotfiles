#!/usr/bin/python3
import json
import subprocess
from typing import Any, TypedDict

PKGS: list[str] = [
    "git+https://github.com/liblaf/ai-commit-cli.git",
    "git+https://github.com/liblaf/thu-learn-downloader.git",
    "toml-sort",
    "toolong",
]


class MainPackage(TypedDict):
    package: str
    package_or_url: str


class Metadata(TypedDict):
    main_package: Any


class VEnv(TypedDict):
    metadata: Metadata


class Data(TypedDict):
    venvs: dict[str, VEnv]


def main() -> None:
    proc: subprocess.CompletedProcess[str] = subprocess.run(
        ["pipx", "list", "--json"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        check=True,
        text=True,
    )
    installed: Data = json.loads(proc.stdout)
    package_or_urls: list[str] = [
        venv["metadata"]["main_package"]["package_or_url"]
        for venv in installed["venvs"].values()
    ]
    pkgs_new: set[str] = {pkg for pkg in PKGS if pkg not in package_or_urls}
    pkgs_dev: set[str] = {pkg for pkg in PKGS if "/" in pkg}
    proc = subprocess.run(
        ["pipx", "install", "--force", *(pkgs_new | pkgs_dev)], check=True, text=True
    )
    if "poetry" in pkgs_new:
        proc = subprocess.run(
            [
                "pipx",
                "inject",
                "--force",
                "poetry",
                "poetry-plugin-export",
                "poetry-plugin-pypi-mirror",
            ],
            check=True,
            text=True,
        )
    proc = subprocess.run(
        ["pipx", "upgrade-all", "--include-injected", "--force"], check=True, text=True
    )


if __name__ == "__main__":
    main()
