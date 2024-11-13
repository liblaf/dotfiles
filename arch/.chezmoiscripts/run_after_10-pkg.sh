#!/bin/bash
set -o errexit -o nounset -o pipefail

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

pkg_dir="$HOME/.cache/dotfiles/pkg"
strip-comments core "$pkg_dir/core.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments extra "$pkg_dir/extra.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments '' "$pkg_dir/group.list" |
  sudo pacman --sync --groups - |
  awk '{ print $2 }' |
  sudo pacman --sync --needed --noconfirm -
strip-comments archlinuxcn "$pkg_dir/archlinuxcn.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments arch4edu "$pkg_dir/arch4edu.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments aur "$pkg_dir/aur.list" |
  yay --aur --removemake --devel --useask=false --sync --needed --noconfirm -
