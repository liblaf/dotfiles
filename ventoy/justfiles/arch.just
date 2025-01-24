import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "/NON-EXISTENT")
ARCH_DIR := MOUNTPOINT / "arch"

arch: check-config
    bash "scripts/arch/download.sh" "{{ ARCH_DIR }}"
