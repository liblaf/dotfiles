#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force --recursive -- \
  "$HOME/.cache/dotfiles/root" \
  "home"
