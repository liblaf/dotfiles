import functools
import hashlib
from pathlib import Path
from typing import NamedTuple


@functools.cache
def local_port_range() -> tuple[int, int]:
    ports: list[int] = [
        int(s)
        for s in Path("/proc/sys/net/ipv4/ip_local_port_range").read_text().split()
    ]
    assert len(ports) == 2
    return ports[0], ports[1]


class Service(NamedTuple):
    name: str
    public: bool = False

    @property
    def slug(self) -> str:
        return self.name.lower().replace(" ", "_").replace("-", "_")

    @property
    def port(self) -> int:
        hashsum: int = int(hashlib.blake2b(self.name.encode()).hexdigest()[:4], base=16)
        low: int
        high: int
        low, high = local_port_range()
        available_ports: range = range(low, high) if self.public else range(high, 65536)
        return available_ports[hashsum % len(available_ports)]


SERVICES: list[Service] = [
    # Service("GPT Academic"),
    # Service("MLflow"),
    # Service("Stirling-PDF"),
    Service("DVC"),
    Service("HTTP"),
    Service("HTTPS", public=True),
    Service("Proxy"),
    Service("Restic"),
    Service("SSH", public=True),
    Service("WebDAV"),
]


def main() -> None:
    for s in SERVICES:
        print(f"{s.slug} = {s.port}")


if __name__ == "__main__":
    main()
