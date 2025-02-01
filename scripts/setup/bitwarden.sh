#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

function ensure() {
  exe=$1
  pkgs=("${@:2}")
  if ! has "$exe"; then
    echo "$exe is not installed"
    if has pacman; then
      sudo pacman --sync --refresh --needed --noconfirm "${pkgs[@]}"
    else
      exit 1
    fi
  fi
}

ensure bw bitwarden-cli
ensure jq
ensure rbw

if ! bw login --check; then
  bw login
fi
if ! bw unlock --check; then
  BW_SESSION=$(bw --raw unlock)
  export BW_SESSION
  bw unlock --check
fi
mkdir --parents --verbose "$HOME/.config/environment.d"
echo "BW_SESSION=$BW_SESSION" > "$HOME/.config/environment.d/bitwarden.conf"

if [[ ! -f "$HOME/.config/rbw/config.json" ]]; then
  rbw config set email "no-reply.liblaf@outlook.com"
  rbw config set lock_timeout 604800
fi
rbw login
rbw sync
