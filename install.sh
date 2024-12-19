#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

workspace=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
eval "$(python "$workspace/scripts/ports.py")"
source "$workspace/scripts/detect/intel.sh"
source "$workspace/scripts/detect/nvidia.sh"
source "$workspace/scripts/setup/bitwarden.sh"

rm --force --verbose ~/.config/chezmoi/chezmoi.*
if [[ -d ~/.local/share/chezmoi ]]; then
  chezmoi init liblaf
else
  chezmoi execute-template < "$workspace/.chezmoi.toml.tmpl" > ~/.config/chezmoi/chezmoi.toml
fi
chezmoi apply "$@"
