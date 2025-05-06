#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

sudo pacman-key --init

# ref: <https://help.mirrors.cernet.edu.cn/archlinuxcn/>
sudo pacman-key --lsign-key farseerfc@archlinux.org
# ref: <https://help.mirrors.cernet.edu.cn/arch4edu/>
sudo pacman-key --recv-keys 7931B6D628C8D3BA
sudo pacman-key --finger 7931B6D628C8D3BA
sudo pacman-key --lsign-key 7931B6D628C8D3BA

packages=(
  archlinuxcn-keyring
  yay
)
sudo pacman --sync --noconfirm --needed --sysupgrade --refresh "${packages[@]}"
