#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function main() {
  local -r repo="$1"
  local -r RATE_MIRRORS_SAVE="$(mktemp)"
  local -r RATE_MIRRORS_ALLOW_ROOT=true
  export RATE_MIRRORS_SAVE RATE_MIRRORS_ALLOW_ROOT
  rate-mirrors "$@"
  sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
    "$RATE_MIRRORS_SAVE" "/etc/pacman.d/$repo-mirrorlist"
  rm --force "$RATE_MIRRORS_SAVE"
}

main "$@"
