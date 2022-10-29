#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force --recursive "${HOME}/.local/share/fonts"
fc-cache --force --verbose
