#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/arch.sh"
source "$SCRIPT_DIR/cachyos.sh"
source "$SCRIPT_DIR/mihomo.sh"

function main() {
  prepare-arch
  prepare-cachyos
  prepare-mihomo
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  main
fi
