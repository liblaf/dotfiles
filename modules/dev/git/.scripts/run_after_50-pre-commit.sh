#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

COMPLETE=fish prek > "$HOME/.local/share/fish/vendor_completions.d/prek.fish"

template_dir="$(git config init.templateDir)"
prek init-template-dir --hook-type pre-commit "$template_dir"
