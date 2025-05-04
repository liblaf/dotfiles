#!/bin/bash
# shellcheck disable=SC2016
set -o errexit
set -o nounset
set -o pipefail

echo 'Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch' | sudo tee /etc/pacman.d/mirrorlist
echo 'Server = https://mirrors.cernet.edu.cn/cachyos/repo/$arch/$repo' | sudo tee /etc/pacman.d/cachyos-mirrorlist
echo 'Server = https://mirrors.cernet.edu.cn/cachyos/repo/$arch_v3/$repo' | sudo tee /etc/pacman.d/cachyos-v3-mirrorlist
echo 'Server = https://mirrors.cernet.edu.cn/cachyos/repo/$arch_v4/$repo' | sudo tee /etc/pacman.d/cachyos-v4-mirrorlist
sudo pacman --sync --refresh
