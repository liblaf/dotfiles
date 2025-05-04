#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if ! grep --fixed-strings --line-regexp --quiet '[archlinuxcn]' /etc/pacman.conf; then
  sudo cp --archive --verbose /etc/pacman.conf /etc/pacman.conf.bak
  cat <<- EOF | sudo tee --append /etc/pacman.conf

[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch
EOF
fi

sudo pacman --sync --refresh --needed --noconfirm archlinuxcn-keyring
sudo pacman-key --lsign-key "farseerfc@archlinux.org"

packages=(
  chezmoi
  git
  sing-box
)
sudo pacman --sync --refresh --needed --noconfirm "${packages[@]}"
