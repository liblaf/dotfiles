#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function main() {
  local -r repo="$1"
  local -r RATE_MIRRORS_SAVE="$(mktemp)"
  local -r RATE_MIRRORS_ALLOW_ROOT=true
  export RATE_MIRRORS_SAVE RATE_MIRRORS_ALLOW_ROOT
  python '/usr/local/lib/rate-mirrors-wrapper.py' "$repo"
  local -r mirrorlist="/etc/pacman.d/$repo-mirrorlist"
  sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
    "$RATE_MIRRORS_SAVE" "$mirrorlist"
  if [[ $repo == 'cachyos' ]]; then
    local -r TMPFILE_V3="$(mktemp)"
    # shellcheck disable=SC2016
    sed 's|/$arch/|/$arch_v3/|g' "$RATE_MIRRORS_SAVE" > "$TMPFILE_V3"
    sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
      "$TMPFILE_V3" '/etc/pacman.d/cachyos-v3-mirrorlist'
    rm --force "$TMPFILE_V3"
    local -r TMPFILE_V4="$(mktemp)"
    # shellcheck disable=SC2016
    sed 's|/$arch/|/$arch_v4/|g' "$RATE_MIRRORS_SAVE" > "$TMPFILE_V4"
    sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
      "$TMPFILE_V4" '/etc/pacman.d/cachyos-v4-mirrorlist'
    rm --force "$TMPFILE_V4"
  fi
  rm --force "$RATE_MIRRORS_SAVE"
}

main "$@"
