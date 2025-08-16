#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

function install-packages() {
  local to_install=()
  if ! has rbw; then to_install+=("rbw"); fi
  if ! has uv; then to_install+=("uv"); fi
  if ! has yq; then to_install+=("go-yq"); fi
  if ((${#to_install[@]} > 0)); then
    sudo pacman --sync --noconfirm --needed "${to_install[@]}"
  fi
}

install-packages
