#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# TODO: setup `~/.config/mimeapps.list`

# ref: <https://wiki.archlinux.org/title/XDG_MIME_Applications>
update-mime-database "$HOME/.local/share/mime"
