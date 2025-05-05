import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "")
ARCH_DIR := MOUNTPOINT / "arch"
ARCH_DOWNLOAD_URL := "https://mirrors.cernet.edu.cn/archlinux/iso/latest/"

arch: check-mountpoint
    #!/bin/bash
    mkdir --parents --verbose -- "{{ ARCH_DIR }}"
    xhs --output "{{ ARCH_DIR }}/sha256sums.txt" --download "{{ ARCH_DOWNLOAD_URL }}/sha256sums.txt"
    sha256=$(awk '$2 == "archlinux-x86_64.iso" { print $1 }' "{{ ARCH_DIR }}/sha256sums.txt")
    aria2c --dir="{{ ARCH_DIR }}" --check-integrity=true --continue=true --checksum="sha-256=$sha256" --out="archlinux-x86_64.iso" --allow-overwrite=true "{{ ARCH_DOWNLOAD_URL }}/archlinux-x86_64.iso"
