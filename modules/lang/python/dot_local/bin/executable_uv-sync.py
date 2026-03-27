#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "nvidia-ml-py>=13",
# ]
# ///

from __future__ import annotations

import contextlib
import os
import re
import subprocess
import sys
from collections.abc import Generator
from pathlib import Path
from typing import TYPE_CHECKING, Any

import pynvml
import tomllib

if TYPE_CHECKING:
    from _typeshed import StrOrBytesPath

MIRROR_CDN: re.Pattern[str] = re.compile(r"https://(\S+)/packages\b")
MIRROR_INDEX: re.Pattern[str] = re.compile(r"https://(\S+)/simple\b")
UPSTREAM_CDN: str = "https://files.pythonhosted.org/packages"
UPSTREAM_INDEX: str = "https://pypi.org/simple"


class LockFile:
    file: Path = Path("uv.lock")
    mirror_cdn: str = UPSTREAM_CDN
    mirror_index: str = UPSTREAM_INDEX

    def __init__(self) -> None:
        self._load_mirror()

    def to_mirror(self) -> None:
        if not self.file.exists():
            return
        with self._preserve_time():
            text: str = self.file.read_text()
            text: str = text.replace(UPSTREAM_INDEX, self.mirror_index)
            text: str = text.replace(UPSTREAM_CDN, self.mirror_cdn)
            self.file.write_text(text)

    def to_upstream(self) -> None:
        if not self.file.exists():
            return
        with self._preserve_time():
            text: str = self.file.read_text()
            text: str = MIRROR_INDEX.sub(UPSTREAM_INDEX, text)
            text: str = MIRROR_CDN.sub(UPSTREAM_CDN, text)
            self.file.write_text(text)

    def _load_mirror(self) -> None:
        config_file: Path = Path("~/.config/uv/uv.toml").expanduser()
        if not config_file.exists():
            return
        with config_file.open("rb") as fp:
            config: dict[str, Any] = tomllib.load(fp)
        for index in config.get("index", []):
            index: dict[str, Any]
            if not index.get("default", False):
                continue
            url: str = index["url"]
            cdn: str = url.replace("/simple", "/packages")
            self.mirror_cdn = cdn
            self.mirror_index = url
            break

    @contextlib.contextmanager
    def _preserve_time(self) -> Generator[None]:
        atime_ns: int = self.file.stat().st_atime_ns
        mtime_ns: int = self.file.stat().st_mtime_ns
        try:
            yield
        finally:
            os.utime(self.file, ns=(atime_ns, mtime_ns))


def load_cuda_version() -> int:
    try:
        pynvml.nvmlInit()
        version: int = pynvml.nvmlSystemGetCudaDriverVersion_v2()
        pynvml.nvmlShutdown()
    except pynvml.NVMLError:
        return 0
    return version


def load_extras() -> list[str]:
    extras: list[str] = []
    cuda_version: int = load_cuda_version()
    # ref: <https://pytorch.org/get-started/locally/>
    if cuda_version >= 13000:
        extras.extend(["cu130", "cuda13"])
    elif cuda_version >= 12800:
        extras.extend(["cu128", "cuda12"])
    elif cuda_version >= 12600:
        extras.extend(["cu126", "cuda12"])
    elif cuda_version >= 12000:
        extras.extend(["cuda12"])
    return extras


def load_optional_dependencies() -> dict[str, list[str]]:
    file: Path = Path("pyproject.toml")
    if not file.exists():
        return {}
    with file.open("rb") as fp:
        pyproject: dict[str, Any] = tomllib.load(fp)
    project: dict[str, Any] = pyproject.get("project", {})
    return project.get("optional-dependencies", {})


def make_args() -> list[StrOrBytesPath]:
    optional_dependencies: dict[str, list[str]] = load_optional_dependencies()
    extras: list[str] = [e for e in load_extras() if e in optional_dependencies]
    args: list[StrOrBytesPath] = ["uv", "sync"]
    for extra in extras:
        args.extend(["--extra", extra])
    args.extend(sys.argv[1:])
    return args


def make_env() -> dict[str, str]:
    env: dict[str, str] = os.environ.copy()
    env.pop("VIRTUAL_ENV", None)
    return env


def main() -> None:
    lockfile: LockFile = LockFile()
    lockfile.to_mirror()
    args: list[StrOrBytesPath] = make_args()
    env: dict[str, str] = make_env()
    process: subprocess.CompletedProcess[bytes] = subprocess.run(
        args, env=env, check=False
    )
    lockfile.to_upstream()
    sys.exit(process.returncode)


if __name__ == "__main__":
    main()
