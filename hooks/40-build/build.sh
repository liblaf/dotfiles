#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
PROFILE="${1:-cachyos}"
uv run "$SCRIPT_DIR/build.py" \
  --modules "$CHEZMOI_WORKING_TREE/modules/" \
  --output "$CHEZMOI_SOURCE_DIR" \
  --profile "$CHEZMOI_WORKING_TREE/profiles/$PROFILE.yaml"
cp --archive --target-directory="$CHEZMOI_SOURCE_DIR" --verbose \
  "$CHEZMOI_WORKING_TREE/.chezmoi.toml.tmpl" 1>&2
