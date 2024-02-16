#!/usr/bin/python3
import asyncio
import json
from asyncio import subprocess
from typing import Any, TypedDict

PKGS: list[str] = [
    "conda-lock",
    "git+https://github.com/liblaf/thu-learn-downloader.git",
    "https://github.com/liblaf/ai-commit-cli/releases/download/dev/ai_commit_cli.tar.gz",
    "https://github.com/liblaf/claps/releases/download/dev/claps.tar.gz",
    "poetry",
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


async def main() -> None:
    proc: subprocess.Process = await asyncio.create_subprocess_exec(
        "pipx",
        "list",
        "--json",
        stdin=subprocess.DEVNULL,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
    )
    assert proc.stdout
    installed: Data = json.loads(await proc.stdout.read())
    package_or_urls: list[str] = [
        venv["metadata"]["main_package"]["package_or_url"]
        for venv in installed["venvs"].values()
    ]
    pkgs_new: set[str] = {pkg for pkg in PKGS if pkg not in package_or_urls}
    pkgs_dev: set[str] = {pkg for pkg in PKGS if "/" in pkg}
    proc = await asyncio.create_subprocess_exec(
        "pipx", "install", "--force", *(pkgs_new | pkgs_dev), stdin=subprocess.DEVNULL
    )
    returncode: int = await proc.wait()
    assert returncode == 0
    if "poetry" in pkgs_new:
        proc = await asyncio.create_subprocess_exec(
            "poetry",
            "inject",
            "--force",
            "poetry",
            "poetry-plugin-pypi-mirror",
            stdin=subprocess.DEVNULL,
        )
        returncode = await proc.wait()
        assert returncode == 0
    proc = await asyncio.create_subprocess_exec(
        "pipx", "upgrade-all", "--include-injected", "--force", stdin=subprocess.DEVNULL
    )
    returncode: int = await proc.wait()
    assert returncode == 0


if __name__ == "__main__":
    asyncio.run(main())
