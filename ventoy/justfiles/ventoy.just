import "config.just"

DEVICE := env("DEVICE", "")

ventoy-install: check-device
    sudo ventoy -I "{{ DEVICE }}"

ventoy-update: check-device
    sudo ventoy -u "{{ DEVICE }}"
