#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
OUTPUT_DIR="$CHEZMOI_SOURCE_DIR/.chezmoidata/gen/"
mkdir --parents --verbose "$OUTPUT_DIR" 1>&2
"$BASH" "$SCRIPT_DIR/detect.sh" > "$OUTPUT_DIR/detect.toml"
"$BASH" "$SCRIPT_DIR/filesystem.sh" > "$OUTPUT_DIR/filesystem.json"
python "$SCRIPT_DIR/services.py" > "$OUTPUT_DIR/services.toml"
