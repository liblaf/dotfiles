#!/bin/bash

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
ensure "rbw" "rbw"

rbw config set email no-reply.liblaf@outlook.com
rbw login
rbw sync
