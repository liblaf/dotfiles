import hashlib
import pathlib
from collections.abc import Sequence

SERVICES: list[str] = ["AList", "GPT Academic", "Jellyfin", "Stirling-PDF"]
PRIVATE_SERVICES: list[str] = ["sing-box"]
local_port_range: list[int] = [
    int(s)
    for s in pathlib.Path("/proc/sys/net/ipv4/ip_local_port_range").read_text().split()
]
print("Local port range:", *local_port_range)
ports: Sequence[int] = range(local_port_range[0], local_port_range[1])
for service in SERVICES:
    hashcode = int(hashlib.blake2b(service.encode()).hexdigest()[:4], base=16)
    print(f"{service}: {ports[hashcode % len(ports)]}")
ports: Sequence[int] = range(local_port_range[1], 65536)
for service in PRIVATE_SERVICES:
    hashcode = int(hashlib.blake2b(service.encode()).hexdigest()[:4], base=16)
    print(f"{service}: {ports[hashcode % len(ports)]}")
