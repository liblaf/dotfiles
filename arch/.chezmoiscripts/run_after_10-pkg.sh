#!/bin/bash
set -o errexit -o nounset -o pipefail

PKG_DIR="$HOME/.cache/dotfiles/pkg"

function strip-comments() {
  repo=$1
  file=$2
  if [[ -z $repo ]]; then
    sed --expression='s/\s*#.*$//' --expression='/^$/d' "$file"
  else
    sed --expression='s/\s*#.*$//' --expression='/^$/d' --expression="s|^|$repo/|" "$file"
  fi
}

sudo pacman --sync --sysupgrade --refresh --noconfirm

# https://mirrors.tuna.tsinghua.edu.cn/help/archlinuxcn/
sudo pacman-key --lsign-key farseerfc@archlinux.org
sudo pacman --sync --needed --noconfirm archlinuxcn/archlinuxcn-keyring
# https://mirrors.tuna.tsinghua.edu.cn/help/arch4edu/
sudo pacman-key --recv-keys 7931B6D628C8D3BA
sudo pacman-key --finger 7931B6D628C8D3BA
sudo pacman-key --lsign-key 7931B6D628C8D3BA
# https://github.com/Jguer/yay
sudo pacman --sync --needed --noconfirm archlinuxcn/yay

readarray -t remove_list < "$PKG_DIR/remove.list"
pkgs_to_remove=()
for pkg in "${remove_list[@]}"; do
  if pacman --query --quiet "$pkg"; then
    pkgs_to_remove+=("$pkg")
  fi
done
if [[ ${#pkgs_to_remove[@]} -gt 0 ]]; then
  sudo pacman --remove --nosave --recursive --unneeded --noconfirm "${pkgs_to_remove[@]}"
fi

strip-comments core "$PKG_DIR/core.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments extra "$PKG_DIR/extra.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments "" "$PKG_DIR/group.list" |
  sudo pacman --sync --groups - |
  awk '{ print $2 }' |
  sudo pacman --sync --needed --noconfirm -
strip-comments archlinuxcn "$PKG_DIR/archlinuxcn.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments arch4edu "$PKG_DIR/arch4edu.list" |
  sudo pacman --sync --needed --noconfirm -
strip-comments aur "$PKG_DIR/aur.list" |
  yay --aur --devel --useask=false --sync --needed --noconfirm -
