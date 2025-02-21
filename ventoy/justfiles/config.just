check-device:
    {{ assert(DEVICE != "", "DEVICE is not set") }}
    {{ assert(path_exists(DEVICE)) == "true", "DEVICE does not exists" }}

check-mountpoint:
    {{ assert(MOUNTPOINT) != "", "MOUNTPOINT is not set" }}
    {{ assert(path_exists(MOUNTPOINT) == "true", "MOUNTPOINT does not exists") }}

check-windows:
    {{ assert(WINDOWS_DOWNLOAD_URL != "", "WINDOWS_DOWNLOAD_URL is not set") }}
    {{ assert(WINDOWS_ISO_SHA256 != "", "WINDOWS_ISO_SHA256 is not set") }}

config:
    bash scripts/config.sh
