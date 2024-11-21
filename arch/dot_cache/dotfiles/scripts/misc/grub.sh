#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$HOME/.cache/dotfiles/assets/grub2-themes"
sudo ./install.sh --screen 4k
