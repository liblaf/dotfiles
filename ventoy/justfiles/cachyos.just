import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "")
CACHYOS_DIR := MOUNTPOINT / "cachyos"
CACHYOS_VERSION := env("CACHYOS_VERSION", "250422")
CACHYOS_DOWNLOAD_BASE_URL := "https://mirrors.cernet.edu.cn/cachyos/ISO/desktop/" + CACHYOS_VERSION
FILENAME := "cachyos-desktop-linux-" + CACHYOS_VERSION + ".iso"
CACHYOS_ISO_URL := CACHYOS_DOWNLOAD_BASE_URL / FILENAME
CACHYOS_SHA256_URL := CACHYOS_ISO_URL + ".sha256"

cachyos: check-mountpoint
    #!/bin/bash
    mkdir --parents --verbose -- "{{ CACHYOS_DIR }}"
    xhs --output "{{ CACHYOS_DIR }}/{{ FILENAME }}.sha256" --download "{{ CACHYOS_SHA256_URL }}"
    sha256=$(awk '$2 == "{{ FILENAME }}" { print $1 }' "{{ CACHYOS_DIR }}/{{ FILENAME }}.sha256")
    aria2c --dir="{{ CACHYOS_DIR }}" --check-integrity=true --continue=true --checksum="sha-256=$sha256" --out="{{ FILENAME }}" --user-agent="curl" --allow-overwrite=true "{{ CACHYOS_ISO_URL }}"
