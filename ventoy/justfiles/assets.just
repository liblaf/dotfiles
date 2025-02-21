import "config.just"

MOUNTPOINT := env("MOUNTPOINT", "")
INSTALL := "cp --archive --force --no-target-directory --update --verbose"

assets: check-mountpoint
    chezmoi execute-template < "assets/proxy-on.sh.tmpl" > "{{ MOUNTPOINT }}/proxy-on.sh"
