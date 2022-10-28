#!/usr/bin/bash
set -o errexit
set -o nounset

rm --force --recursive "${HOME}/.local/share/fonts"
fc-cache --force --verbose
