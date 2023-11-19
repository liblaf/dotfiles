#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

workspace=$(realpath $(dirname $0))
source "$workspace/scripts/detect/intel.sh"
source "$workspace/scripts/detect/nvidia.sh"
source "$workspace/scripts/setup/bitwarden.sh"

rm --force --recursive --verbose "$HOME/.config/chezmoi"
chezmoi init liblaf
chezmoi apply --force "$@"

bash "$workspace/post-install.sh"
