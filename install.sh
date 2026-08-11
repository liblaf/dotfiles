#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTDIR="$(dirname -- "${BASH_SOURCE[0]}")"
bash "$SCRIPTDIR/scripts/pre/main.sh"
chezmoi init --apply
