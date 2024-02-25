#!/bin/bash

function has() {
  type "$@" &> /dev/null
}

if ! has bw; then
  echo "Bitwarden is not installed"
  if has pacman; then
    sudo pacman --sync --refresh --needed --noconfirm bitwarden-cli
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
  BW_SESSION=$(bw unlock --raw)
  export BW_SESSION
  bw unlock --check
fi

mkdir --parents --verbose "$HOME/.config/environment.d"
bw_session_file=$(mktemp)
trap 'rm --force --verbose $bw_session_file' EXIT
echo "BW_SESSION=$BW_SESSION" > "$bw_session_file"
install --backup -D --mode="u=rw,go=r" --no-target-directory --verbose \
  "$bw_session_file" "$HOME/.config/environment.d/bitwarden.conf"
