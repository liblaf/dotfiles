import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "/NON-EXISTENT")
WINDOWS_DOWNLOAD_URL := env("WINDOWS_DOWNLOAD_URL", "")
WINDOWS_ISO_SHA256 := env("WINDOWS_ISO_SHA256", "")
WINDOWS_DIR := MOUNTPOINT / "windows"

windows: check-mountpoint check-windows
    @ mkdir --parents --verbose "{{ WINDOWS_DIR }}"
    @ aria2c --dir="{{ WINDOWS_DIR }}" --check-integrity=true --continue=true --checksum="sha-256={{ WINDOWS_ISO_SHA256 }}" --allow-overwrite=true "{{ WINDOWS_DOWNLOAD_URL }}"
