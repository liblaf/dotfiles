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
    env: str
    public: bool

    @property
    def port(self) -> int:
        hashsum: int = int(hashlib.blake2b(self.name.encode()).hexdigest()[:4], base=16)
        low: int
        high: int
        low, high = local_port_range()
        available_ports: range = range(low, high) if self.public else range(high, 65536)
        return available_ports[hashsum % len(available_ports)]


SERVICES: list[Service] = [
    Service("GPT Academic", "GPT_ACADEMIC", public=True),
    Service("HTTP", "HTTP", public=False),
    Service("HTTPS", "HTTPS", public=True),
    Service("sing-box", "PROXY", public=False),
    Service("SSH", "SSH", public=True),
    Service("Stirling-PDF", "STIRLING_PDF", public=True),
    Service("WebDAV", "WEBDAV", public=False),
]


for s in SERVICES:
    print(f"export PORT_{s.env}={s.port}")
