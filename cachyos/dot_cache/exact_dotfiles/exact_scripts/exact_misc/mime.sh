#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: https://wiki.archlinux.org/title/XDG_MIME_Applications
update-mime-database "$HOME/.local/share/mime"
