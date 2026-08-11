#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

gnome-extensions install --force "$HOME/.cache/dotfiles/external/codex-meter@slobbe.github.io.zip"

gext enable 'codex-meter@slobbe.github.io'

dconf load / < "$CHEZMOI_SOURCE_DIR/.snippets/codex-meter.dconf"
