#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo cp --archive --backup --force --no-preserve="ownership" --verbose "$HOME/.cache/dotfiles/root/"* "/"
