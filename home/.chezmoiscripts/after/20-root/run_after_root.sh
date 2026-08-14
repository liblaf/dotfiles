#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo cp --no-dereference --recursive --target-directory='/' --verbose "$HOME/.cache/dotfiles/root/."
