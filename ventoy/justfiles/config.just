check-config:
    {{ assert(path_exists(MOUNTPOINT) == "true", "MOUNTPOINT does not exists") }}

config:
    bash scripts/config.sh
