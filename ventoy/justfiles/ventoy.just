import "config.just"

DEVICE := env("DEVICE", "/NON-EXISTENT")

ventoy-install: check-config
    sudo ventoy -I "{{ DEVICE }}"

ventoy-update: check-config
    sudo ventoy -u "{{ DEVICE }}"
