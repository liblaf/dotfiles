#!/bin/bash
# shellcheck disable=SC1091
set -o errexit
set -o nounset
set -o pipefail

SCRIPTDIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPTDIR/config.sh"
source "$SCRIPTDIR/arch.sh"
source "$SCRIPTDIR/cachyos.sh"
source "$SCRIPTDIR/mihomo.sh"

function main() {
  prepare-arch
  prepare-cachyos
  prepare-mihomo
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  main
fi
