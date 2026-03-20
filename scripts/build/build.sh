#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
uv run "$SCRIPT_DIR/build.py" "$@"
cp --archive --target-directory='home' --verbose '.chezmoi.toml.tmpl'
