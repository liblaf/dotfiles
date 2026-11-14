#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTDIR="$(dirname -- "${BASH_SOURCE[0]}")"
VENTOY_DIR="$(realpath -- "$SCRIPTDIR/..")"
# shellcheck disable=SC1091
source "$SCRIPTDIR/config.sh"

function prepare-mihomo() {
  prompt-mountpoint
  local mihomo_dir="$MOUNTPOINT/mihomo"

  mkdir --parents --verbose "$mihomo_dir"

  cp --archive '/etc/mihomo/config.yaml' "$mihomo_dir/config.yaml"
  cp --archive "$(type -P mihomo)" "$mihomo_dir/mihomo"
  cp --archive "$VENTOY_DIR/assets/proxy-on.fish" "$mihomo_dir/proxy-on.fish"
  cp --archive "$VENTOY_DIR/assets/proxy-on.sh" "$mihomo_dir/proxy-on.sh"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  prepare-mihomo
fi
