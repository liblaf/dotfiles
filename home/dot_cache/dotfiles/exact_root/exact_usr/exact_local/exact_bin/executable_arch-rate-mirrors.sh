#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function main() {
  local -r repo="$1"

  local -r no_proxy='*'
  local -r NO_PROXY='*'
  export no_proxy NO_PROXY

  # Use jsDelivr (instead of raw.githubusercontent.com) for better reliability.
  case "$repo" in
    'arch4edu')
      export RATE_MIRRORS_MIRROR_LIST_FILE='https://cdn.jsdelivr.net/gh/arch4edu/mirrorlist/mirrorlist.arch4edu'
      ;;
    'archlinuxcn')
      export RATE_MIRRORS_MIRROR_LIST_FILE='https://cdn.jsdelivr.net/gh/archlinuxcn/mirrorlist-repo/archlinuxcn-mirrorlist'
      ;;
  esac

  local -r country="$(
    curl --silent 'https://geoip.kde.org/v1/ubiquity' |
      sed --quiet 's|.*<CountryCode>\(.*\)</CountryCode>.*|\1|p'
  )"
  # ref: <https://github.com/CachyOS/CachyOS-PKGBUILDS/blob/master/cachyos-rate-mirrors/cachyos-rate-mirrors>
  if [[ -n $country ]]; then
    export RATE_MIRRORS_ENTRY_COUNTRY="$country"
    if [[ $country == "CN" ]]; then
      export RATE_MIRRORS_COUNTRY_NEIGHBORS_PER_COUNTRY=0
      export RATE_MIRRORS_COUNTRY_TEST_MIRRORS_PER_COUNTRY=50
    fi
  fi

  # Run rate-mirrors and write the ranked result to a temporary file.
  local -r RATE_MIRRORS_SAVE="$(mktemp)"
  export RATE_MIRRORS_SAVE
  export RATE_MIRRORS_ALLOW_ROOT=true
  rate-mirrors "$repo"

  # Install the generated mirrorlist to pacman's expected path.
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
