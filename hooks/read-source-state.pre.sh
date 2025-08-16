#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ $CHEZMOI_COMMAND == "execute-template" ]]; then exit; fi

SCRIPTS_DIR="$(dirname -- "${BASH_SOURCE[0]}")"

"$BASH" -- "$SCRIPTS_DIR/gen-data.sh"
uv run -- "$SCRIPTS_DIR/gen-packages.py"
