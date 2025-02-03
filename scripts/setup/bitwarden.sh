#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

if has pacman; then
  sudo pacman --sync --refresh --needed --noconfirm bitwarden-cli jq rbw
else
  exit 1
fi

if ! bw login --check; then
  BW_SESSION=$(bw login --raw)
  export BW_SESSION
fi
if ! bw unlock --check; then
  BW_SESSION=$(bw --raw unlock)
  export BW_SESSION
  bw unlock --check
fi
mkdir --parents --verbose "$HOME/.config/environment.d"
printf "BW_SESSION=%q\n" "$BW_SESSION" > "$HOME/.config/environment.d/bitwarden.conf"

if [[ ! -f "$HOME/.config/rbw/config.json" ]]; then
  rbw config set email "no-reply.liblaf@outlook.com"
  rbw config set lock_timeout 604800
fi
rbw login
rbw sync
