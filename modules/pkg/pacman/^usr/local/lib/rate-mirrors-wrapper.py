import argparse
import enum
import os
import re
import subprocess
import urllib.request
from http.client import HTTPResponse
from typing import cast


class Target(enum.StrEnum):
    mirrorlist: str
    path_to_test: str
    path_to_return: str
    ARCH4EDU = enum.auto()
    ARCHLINUXCN = enum.auto()
    CACHYOS = enum.auto()


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


class Args(argparse.ArgumentParser):
    target: Target


def parse_args() -> Args:
    parser = Args()
    parser.add_argument("target", type=Target, choices=Target)
    return parser.parse_args(namespace=Args())


def main() -> None:
    args: Args = parse_args()
    with cast(
        "HTTPResponse",
        urllib.request.urlopen(args.target.mirrorlist),
    ) as response:
        text: str = response.read().decode()
        servers: list[str] = re.findall(r"Server\s*=\s*(?P<server>.+)", text)
        servers: list[str] = [
            server.removesuffix(args.target.path_to_return) for server in servers
        ]
        env: dict[str, str] = {
            key: value
            for key, value in os.environ.items()
            if not key.endswith(("_proxy", "_PROXY"))
        }
        env["RATE_MIRRORS_PATH_TO_TEST"] = args.target.path_to_test
        env["RATE_MIRRORS_PATH_TO_RETURN"] = args.target.path_to_return
        env["RATE_MIRRORS_OUTPUT_PREFIX"] = "Server = "
        subprocess.run(
            ["rate-mirrors", "stdin"],
            env=env,
            check=True,
            input="\n".join(servers),
            text=True,
        )


if __name__ == "__main__":
    main()
