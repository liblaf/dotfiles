#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$HOME/.cache/dotfiles/grub2-themes"
grep --regexp='\\0033\\0143' --invert-match install.sh |
	sudo bash -s - --screen 4k
