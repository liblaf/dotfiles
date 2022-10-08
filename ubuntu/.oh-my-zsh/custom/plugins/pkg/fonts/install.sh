#!/usr/bin/env bash
# https://github.com/romkatv/powerlevel10k#fonts
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

for style in "Regular" "Bold" "Italic" "Bold Italic"; do
  filename="MesloLGS NF ${style}.ttf"
  echo "${filename}"
  filepath="${HOME}/.local/share/fonts/${filename}"
  url="https://github.com/romkatv/powerlevel10k-media/raw/master/${filename}"
  download "${url}" "${filepath}"
done
fc-cache --force --verbose
