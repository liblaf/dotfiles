#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

uv run 'scripts/build.py' "$@"
cp --archive --target-directory='home/' --verbose '.chezmoi.toml.tmpl'
