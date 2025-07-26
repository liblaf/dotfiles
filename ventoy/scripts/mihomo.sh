#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
VENTOY_DIR="$(realpath -- "$SCRIPT_DIR/..")"
source "$SCRIPT_DIR/config.sh"

function prepare-mihomo() {
  prompt-mountpoint
  local mihomo_dir="$MOUNTPOINT/mihomo"

  mkdir --parents --verbose "$mihomo_dir"

  cp --archive '/etc/clash-meta/config.yaml' "$mihomo_dir/config.yaml"
  cp --archive "$(type -P clash-meta)" "$mihomo_dir/clash-meta"
  chezmoi execute-template "$VENTOY_DIR/assets/proxy-on.sh.tmpl" --file \
    --output "$mihomo_dir/proxy-on.sh"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  prepare-mihomo
fi
