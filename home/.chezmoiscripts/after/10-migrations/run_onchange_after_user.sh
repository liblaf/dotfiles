#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force --verbose \
  "$HOME/.cache/dotfiles/external/dconf.ini" \
  "$HOME/.cache/dotfiles/external/otrust.txt" \
  "$HOME/.config/fish/completions/mihomo-pull.fish" \
  "$HOME/.config/fish/completions/pretty-toml.fish" \
  "$HOME/.config/fish/conf.d/direnv.fish" \
  "$HOME/.config/fish/functions/paru.fish" \
  "$HOME/.local/share/fish/vendor_completions.d/prek.fish"

rm --force --recursive --verbose \
  "$HOME/.config/direnv" \
  "$HOME/.config/dvc" \
  "$HOME/.config/opencode" \
  "$HOME/.config/repomix" \
  "$HOME/.share"
