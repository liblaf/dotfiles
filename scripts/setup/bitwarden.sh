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

EMAIL=no-reply.liblaf@outlook.com
email_now=$(rbw config show | jq --raw-output ".email")
if [[ $email_now != "$EMAIL" ]]; then
  rbw config set email no-reply.liblaf@outlook.com
fi
rbw login
rbw sync
