#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTS_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPTS_DIR/data.sh"
source "$SCRIPTS_DIR/lib.sh"
source "$SCRIPTS_DIR/packages.sh"

if [[ $CHEZMOI_COMMAND == "execute-template" ]]; then exit; fi

TMPDIR="$CHEZMOI_WORKING_TREE/tmp"
# if [[ -f $OUTPUT ]]; then exit; fi

function main() {
  gen-data
  gen-packages
}

main
