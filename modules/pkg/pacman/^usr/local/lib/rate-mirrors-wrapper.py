import argparse
import enum
import functools
import os
import re
import subprocess
import urllib.parse
import urllib.request
from http.client import HTTPResponse
from typing import Self, cast

EXCLUDE_MIRRORS: set[str] = {"mirror.nju.edu.cn"}


def _excluded(server: str) -> bool:
    split: urllib.parse.SplitResult = urllib.parse.urlsplit(server)
    return split.hostname in EXCLUDE_MIRRORS


class Target(enum.StrEnum):
    mirrorlist: str
    path_to_test: str
    path_to_return: str
    ARCH = enum.auto()
    ARCH4EDU = enum.auto()
    ARCHLINUXCN = enum.auto()
    CACHYOS = enum.auto()

    @functools.cached_property
    def servers(self) -> list[str]:
        with cast(
            "HTTPResponse",
            urllib.request.urlopen(self.mirrorlist),
        ) as response:
            text: str = response.read().decode()
        servers: list[str] = re.findall(r"Server\s*=\s*(?P<server>.+)", text)
        servers: list[str] = [
            server.removesuffix(self.path_to_return)
            for server in servers
            if not _excluded(server)
        ]
        return servers

    def rate_mirrors(self) -> None:
        environ: dict[str, str] = {
            key: value
            for key, value in os.environ.items()
            if not key.endswith(("_proxy", "_PROXY"))
        }
        match self:
            case Target.ARCH:
                subprocess.run(["rate-mirrors", "arch"], env=environ, check=True)
            case _:
                environ |= {
                    "RATE_MIRRORS_PATH_TO_TEST": self.path_to_test,
                    "RATE_MIRRORS_PATH_TO_RETURN": self.path_to_return,
                    "RATE_MIRRORS_OUTPUT_PREFIX": "Server = ",
                }
                subprocess.run(
                    ["rate-mirrors", "stdin"],
                    env=environ,
                    check=True,
                    input="\n".join(self.servers),
                    text=True,
                )


Target.ARCH4EDU.mirrorlist = (
    "https://cdn.jsdelivr.net/gh/arch4edu/mirrorlist/mirrorlist.arch4edu"
)
Target.ARCH4EDU.path_to_test = "x86_64/arch4edu.files"
Target.ARCH4EDU.path_to_return = "$arch"
Target.ARCHLINUXCN.mirrorlist = (
    "https://cdn.jsdelivr.net/gh/archlinuxcn/mirrorlist-repo/archlinuxcn-mirrorlist"
)
Target.ARCHLINUXCN.path_to_test = "x86_64/archlinuxcn.files"
Target.ARCHLINUXCN.path_to_return = "$arch"
Target.CACHYOS.mirrorlist = "https://cdn.jsdelivr.net/gh/CachyOS/CachyOS-PKGBUILDS/cachyos-mirrorlist/cachyos-mirrorlist"
Target.CACHYOS.path_to_test = "x86_64/cachyos/cachyos.files"
Target.CACHYOS.path_to_return = "$arch/$repo"


class Args(argparse.Namespace):
    target: Target

    @classmethod
    def parse_args(cls) -> Self:
        parser = argparse.ArgumentParser()
        parser.add_argument("target", type=Target, choices=Target)
        return parser.parse_args(namespace=cls())


def main() -> None:
    args: Args = Args.parse_args()
    args.target.rate_mirrors()


if __name__ == "__main__":
    main()
