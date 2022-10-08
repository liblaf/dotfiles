#!/usr/bin/env bash
# https://github.com/romkatv/powerlevel10k#fonts
set -o errexit
set -o nounset

rm --force --recursive "${HOME}/.local/share/fonts/"
fc-cache --force --verbose
