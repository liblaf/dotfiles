import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "")
INSTALL := "cp --archive --force --no-target-directory --update --verbose"
SINGBOX_DIR := MOUNTPOINT / "sing-box"

sing-box: check-mountpoint
    @ mkdir --parents --verbose "{{ SINGBOX_DIR }}"
    @ {{ INSTALL }} "{{ require("sing-box") }}" "{{ SINGBOX_DIR / "sing-box" }}"
    @ {{ INSTALL }} "/etc/sing-box/config.json" "{{ SINGBOX_DIR / "config.json" }}"
