#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function main() {
  local -r repo="$1"
  local -r RATE_MIRRORS_SAVE="$(mktemp)"
  local -r RATE_MIRRORS_ALLOW_ROOT=true
  export RATE_MIRRORS_SAVE RATE_MIRRORS_ALLOW_ROOT
  # TODO: rate-mirrors downloads the upstream mirror list from GitHub, which may
  # be unreachable behind the GFW. Setting `$https_proxy` forces all requests
  # (including mirror probes) through the proxy, but we only need GitHub traffic
  # proxied. We need a better solution.
  rate-mirrors "$@"
  sudo install --backup='simple' --mode='u=rw,go=r' --suffix='-backup' --verbose \
    "$RATE_MIRRORS_SAVE" "/etc/pacman.d/$repo-mirrorlist"
  rm --force "$RATE_MIRRORS_SAVE"
}

main "$@"
