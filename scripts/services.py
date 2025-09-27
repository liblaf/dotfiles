import enum
import functools
import hashlib
import re
import socket
from collections.abc import Container, Sequence

# /proc/sys/net/ipv4/ip_local_port_range
PORT_RANGE: Sequence[int] = range(32768, 60999)
# /etc/login.defs
UID_RANGE: Sequence[int] = range(10000, 60000)


class Field(enum.StrEnum):
    ENABLE = enum.auto()
    PORT = enum.auto()
    UID = enum.auto()


class Sentinel(enum.Enum):
    DISABLED = enum.auto()
    MISSING = enum.auto()


class Service:
    name: str
    enable: bool | None

    def __init__(
        self,
        name: str,
        *,
        enable: bool | Container[str] = False,
        port: bool = False,
        uid: bool = False,
    ) -> None:
        self.name = name
        if enable is True:
            self.enable = enable
        elif enable is False:
            self.enable = None
        else:
            self.enable = socket.gethostname() in enable

        if port is False:
            self.port = None
        if uid is False:
            self.uid = None

    @property
    def hashnum(self) -> int:
        digest: bytes = hashlib.blake2b(self.name.encode()).digest()
        return int.from_bytes(digest)

    @property
    def slug(self) -> str:
        return re.sub(r"[- ]+", "_", self.name.lower())

    @functools.cached_property
    def port(self) -> int | None:
        return PORT_RANGE[self.hashnum % len(PORT_RANGE)]

    @functools.cached_property
    def uid(self) -> int | None:
        return UID_RANGE[self.hashnum % len(UID_RANGE)]

    def print_properties(self) -> None:
        if self.enable is not None:
            print(f"{self.slug}.enable = {'true' if self.enable else 'false'}")
        if self.port is not None:
            print(f"{self.slug}.port = {self.port}")
        if self.uid is not None:
            print(f"{self.slug}.uid = {self.uid}")


SERVICES: list[Service] = [
    Service("Caddy", enable=True),
    Service("DVC", enable={"PC06"}, port=True),
    Service("HTTP", port=True),
    Service("HTTPS", port=True),
    Service("Jellyfin", enable={"PC06"}, uid=True),
    Service("Mihomo", enable={"PC06"}),
    Service("OpenList", enable={"PC06"}, uid=True),
    Service("Proxy", port=True),
    Service("qBittorrent WebUI", port=True),
    Service("qBittorrent", enable={"PC06"}, port=True, uid=True),
    Service("Restic", enable=True),
    Service("SSH", enable=True, port=True),
]


def main() -> None:
    for s in SERVICES:
        s.print_properties()
    s = Service("Service", uid=True)
    print(f"gid = {s.uid}")


if __name__ == "__main__":
    main()
