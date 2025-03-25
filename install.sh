#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

workspace=$(realpath -- "$(dirname -- "${BASH_SOURCE[0]}")")

chezmoi_config="$HOME/.config/chezmoi/"
rm --force --verbose "$chezmoi_config"/chezmoi.*
if [[ -d ~/.local/share/chezmoi/ ]]; then
  mkdir --parents --verbose "$chezmoi_config"
  chezmoi execute-template < "$workspace/.chezmoi.toml.tmpl" > "$chezmoi_config/chezmoi.toml"
else
  chezmoi init liblaf
fi

chezmoi apply "$@"
