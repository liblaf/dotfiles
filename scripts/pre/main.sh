#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTDIR="$(dirname -- "${BASH_SOURCE[0]}")"
mkdir --parents --verbose "$CHEZMOI_SOURCE_DIR/.chezmoidata/generated/"
python "$SCRIPTDIR/services.py" > "$CHEZMOI_SOURCE_DIR/.chezmoidata/generated/services.toml"
