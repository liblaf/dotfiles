#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

if has pacman; then
  sudo pacman --sync --refresh --needed --noconfirm go-yq
else
  exit 1
fi
