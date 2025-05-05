import "config.just"

DEVICE := env("DEVICE", "")

ventoy-install: check-device
    sudo ventoy -I "{{ DEVICE }}"
    systemctl --user restart gvfs-udisks2-volume-monitor.service

ventoy-update: check-device
    sudo ventoy -u "{{ DEVICE }}"
