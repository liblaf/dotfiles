#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

function ensure() {
  pkg=$1
  exe=$2
  if ! has "$exe"; then
    echo "$pkg is not installed"
    if has pacman; then
      sudo pacman --sync --refresh --needed --noconfirm "$pkg"
    else
      exit 1
    fi
  fi
}

ensure "bitwarden-cli" "bw"
ensure "jq" "jq"
ensure "rbw" "rbw"

if [[ ! -f "$HOME/.config/rbw/config.json" ]]; then
  rbw config set email "no-reply.liblaf@outlook.com"
fi
rbw login
rbw sync
