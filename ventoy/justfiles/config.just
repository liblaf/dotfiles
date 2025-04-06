check-device:
    {{ assert(DEVICE != "", "DEVICE is not set. Please run `scripts/config.sh` first.") }}
    {{ assert(path_exists(DEVICE) == "true", "DEVICE does not exists. Please run `scripts/config.sh` first.") }}

check-mountpoint:
    {{ assert(MOUNTPOINT != "", "MOUNTPOINT is not set. Please run `scripts/config.sh` first.") }}
    {{ assert(path_exists(MOUNTPOINT) == "true", "MOUNTPOINT does not exists. Please run `scripts/config.sh` first.") }}

check-windows:
    {{ assert(WINDOWS_DOWNLOAD_URL != "", "WINDOWS_DOWNLOAD_URL is not set. Please run `scripts/config.sh` first.") }}
    {{ assert(WINDOWS_ISO_SHA256 != "", "WINDOWS_ISO_SHA256 is not set. Please run `scripts/config.sh` first.") }}

config:
    bash scripts/config.sh
