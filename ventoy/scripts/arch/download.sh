#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

ARCH_DIR=$1

sha256=$(
  xhs "https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/sha256sums.txt" |
    grep "archlinux-x86_64.iso" |
    awk '{ print $1 }'
)
aria2c --dir="$ARCH_DIR" --check-integrity=true --continue=true --checksum="sha-256=$sha256" --out="archlinux-x86_64.iso" --allow-overwrite=true "https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/archlinux-x86_64.iso"
