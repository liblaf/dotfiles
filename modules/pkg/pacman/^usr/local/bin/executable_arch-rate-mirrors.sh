#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function main() {
  local -r repo="$1"

  local -r country_code="$(
    NO_PROXY='*' xhs GET 'https://api.ip.sb/geoip' |
      jq --raw-output '.country_code'
  )"
  # ref: <https://github.com/CachyOS/CachyOS-PKGBUILDS/blob/master/cachyos-rate-mirrors/cachyos-rate-mirrors>
  if [[ -n $country_code ]]; then
    export RATE_MIRRORS_ENTRY_COUNTRY="$country_code"
    if [[ $country_code == "CN" ]]; then
      export RATE_MIRRORS_COUNTRY_NEIGHBORS_PER_COUNTRY=0
      export RATE_MIRRORS_COUNTRY_TEST_MIRRORS_PER_COUNTRY=50
    fi
  fi

  # rate mirrors
  local -r RATE_MIRRORS_SAVE="$(mktemp)"
  export RATE_MIRRORS_SAVE
  export RATE_MIRRORS_ALLOW_ROOT=true
  python '/usr/local/lib/rate-mirrors-wrapper.py' "$repo"

  # install mirrorlist
  case "$repo" in
    'arch') local -r mirrorlist="/etc/pacman.d/mirrorlist" ;;
    *) local -r mirrorlist="/etc/pacman.d/$repo-mirrorlist" ;;
  esac
  sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' \
    --verbose "$RATE_MIRRORS_SAVE" "$mirrorlist"
  case "$repo" in
    'cachyos') _post_cachyos ;;
  esac
  rm --force "$RATE_MIRRORS_SAVE"
}

function _post_cachyos() {
  local -r tmpfile_v3="$(mktemp)"
  # shellcheck disable=SC2016
  sed 's|/$arch/|/$arch_v3/|g' "$RATE_MIRRORS_SAVE" > "$tmpfile_v3"
  sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
    "$tmpfile_v3" '/etc/pacman.d/cachyos-v3-mirrorlist'
  rm --force "$tmpfile_v3"
  local -r tmpfile_v4="$(mktemp)"
  # shellcheck disable=SC2016
  sed 's|/$arch/|/$arch_v4/|g' "$RATE_MIRRORS_SAVE" > "$tmpfile_v4"
  sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
    "$tmpfile_v4" '/etc/pacman.d/cachyos-v4-mirrorlist'
  rm --force "$tmpfile_v4"
}

main "$@"
