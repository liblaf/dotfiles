import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "/NON-EXISTENT")
INSTALL := "cp --archive --force --no-target-directory --update --verbose"

assets: check-config
    chezmoi execute-template < "assets/proxy-on.sh.tmpl" > "{{ MOUNTPOINT / "proxy-on.sh" }}"
