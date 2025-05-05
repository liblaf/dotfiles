#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

sudo pacman --sync --refresh --noconfirm
# ref: <https://help.mirrors.cernet.edu.cn/archlinuxcn/>
sudo pacman-key --lsign-key farseerfc@archlinux.org
sudo pacman --sync --needed --noconfirm archlinuxcn-keyring
# ref: <https://help.mirrors.cernet.edu.cn/arch4edu/>
sudo pacman-key --recv-keys 7931B6D628C8D3BA
sudo pacman-key --finger 7931B6D628C8D3BA
sudo pacman-key --lsign-key 7931B6D628C8D3BA

sudo pacman --sync --refresh --noconfirm --sysupgrade
sudo pacman --sync --needed --noconfirm yay
