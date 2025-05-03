#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

packages=(
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  noto-fonts-extra
  otf-monaspace-nerd
  ttf-cascadia-code-nerd
  ttf-mona-sans
)
yay --sync --needed --noconfirm "${packages[@]}"

fc-cache --force --verbose
