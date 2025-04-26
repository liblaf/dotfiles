#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo cp --archive --force --no-preserve="ownership" --verbose "$HOME/.cache/dotfiles/root/"* "/"
sudo chmod "u=rwx,g=rx,o=" /var/lib/caddy
sudo chown "caddy" /var/lib/caddy/envfile
