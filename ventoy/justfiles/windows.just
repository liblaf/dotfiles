import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "/NON-EXISTENT")
WINDOWS_DOWNLOAD_URL := env("WINDOWS_DOWNLOAD_URL", "https://non-existent.com")
WINDOWS_ISO_SHA256 := env("WINDOWS_ISO_SHA256", "NON-EXISTENT")
WINDOWS_DIR := MOUNTPOINT / "windows"

windows: check-config
    @ mkdir --parents --verbose "{{ WINDOWS_DIR }}"
    @ aria2c --dir="{{ WINDOWS_DIR }}" --check-integrity=true --continue=true --checksum="sha-256={{ WINDOWS_ISO_SHA256 }}" --allow-overwrite=true "{{ WINDOWS_DOWNLOAD_URL }}"
