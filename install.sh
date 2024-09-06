#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

workspace=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
eval "$(python tools/ports.py)"
source "$workspace/scripts/detect/intel.sh"
source "$workspace/scripts/detect/nvidia.sh"
source "$workspace/scripts/setup/bitwarden.sh"

rm --force --verbose ~/.config/chezmoi/chezmoi.*
chezmoi init liblaf
chezmoi apply --force "$@"
