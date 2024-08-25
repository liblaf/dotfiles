import hashlib
import pathlib
from collections.abc import Sequence

PUBLIC_SERVICES: list[str] = [
    "AList",
    "GPT Academic",
    "Jellyfin",
    "Stirling-PDF",
    "WebDAV",
]
PRIVATE_SERVICES: list[str] = ["sing-box"]


def hashsum(s: str) -> int:
    return int(hashlib.blake2b(s.encode()).hexdigest()[:4], base=16)


local_port_range: list[int] = [
    int(s)
    for s in pathlib.Path("/proc/sys/net/ipv4/ip_local_port_range").read_text().split()
]
print("Local port range:", *local_port_range)
ports: Sequence[int] = range(local_port_range[0], local_port_range[1])
for service in PUBLIC_SERVICES:
    hashcode: int = hashsum(service)
    print(f"{service}: {ports[hashcode % len(ports)]}")
ports: Sequence[int] = range(local_port_range[1], 65536)
for service in PRIVATE_SERVICES:
    hashcode: int = hashsum(service)
    print(f"{service}: {ports[hashcode % len(ports)]}")
