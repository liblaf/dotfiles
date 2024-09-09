#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function strip-comments() {
  repo=$1
  file=$2
  if [[ -z $repo ]]; then
    sed --expression='s/\s*#.*$//' --expression='/^$/d' "$file"
  else
    sed --expression='s/\s*#.*$//' --expression='/^$/d' --expression="s|^|$repo/|" "$file"
  fi
}

# https://mirrors.tuna.tsinghua.edu.cn/help/archlinuxcn/
sudo pacman-key --lsign-key farseerfc@archlinux.org
sudo pacman --sync --needed --noconfirm archlinuxcn/archlinuxcn-keyring
# https://mirrors.tuna.tsinghua.edu.cn/help/arch4edu/
sudo pacman-key --recv-keys 7931B6D628C8D3BA
sudo pacman-key --finger 7931B6D628C8D3BA
sudo pacman-key --lsign-key 7931B6D628C8D3BA

sudo pacman --sync --sysupgrade --refresh --noconfirm

strip-comments core "$HOME/.local/chezmoi/pkg/core.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments extra "$HOME/.local/chezmoi/pkg/extra.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments '' "$HOME/.local/chezmoi/pkg/group.list" |
  sudo pacman --sync --groups - |
  awk '{ print $2 }' |
  sudo pacman --sync --needed --noconfirm -
strip-comments archlinuxcn "$HOME/.local/chezmoi/pkg/archlinuxcn.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments arch4edu "$HOME/.local/chezmoi/pkg/arch4edu.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments aur "$HOME/.local/chezmoi/pkg/aur.list" |
  yay --aur --removemake --devel --useask=false --sync --needed --noconfirm -
