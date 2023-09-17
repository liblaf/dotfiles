#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

workspace=$(realpath $(dirname $0))
source "$workspace/scripts/setup/bitwarden.sh"

rm --force --recursive --verbose "$HOME/.config/chezmoi"
chezmoi init liblaf
chezmoi apply --force

bash "$workspace/post-install.sh"
