#!/bin/bash

function has() {
  type "$@" &> /dev/null
}

if ! has bw; then
  echo "Bitwarden is not installed"
  if has pacman; then
    sudo pacman --sync --sysupgrade --refresh --needed --noconfirm bitwarden-cli
  else
    exit 1
  fi
fi

if ! bw login --check; then
  bw login
  bw login --check
fi

bw sync

if ! bw unlock --check; then
  export BW_SESSION=$(bw unlock --raw)
  bw unlock --check
fi

mkdir --parents --verbose "$HOME/.config/environment.d"
temp=$(mktemp)
trap "rm --force --verbose $temp" EXIT
echo "BW_SESSION=\"$BW_SESSION\"" > $temp
install --backup -D --mode="u=rw,go=r" --no-target-directory --verbose \
  $temp \
  "$HOME/.config/environment.d/bitwarden.conf"
