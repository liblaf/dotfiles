#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ $CHEZMOI_COMMAND == "execute-template" ]]; then exit; fi

SCRIPTS_DIR="$(dirname -- "${BASH_SOURCE[0]}")"

"$BASH" -- "$SCRIPTS_DIR/gen-data.sh"
"$BASH" -- "$SCRIPTS_DIR/install-packages.sh"
"$BASH" -- "$SCRIPTS_DIR/setup-bitwarden.sh"
uv run -- "$SCRIPTS_DIR/gen-packages.py"
