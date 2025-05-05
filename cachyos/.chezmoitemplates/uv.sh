#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export PATH="$HOME/.local/bin:$PATH"

function uv() {
  flock --timeout 30 /tmp/dotfiles-uv.lock uv "$@"
}
