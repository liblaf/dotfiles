#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/config.sh"

function prepare-arch() {
  local download_url='https://mirrors.cernet.edu.cn/archlinux/iso/latest'

  prompt-mountpoint
  local arch_dir="$MOUNTPOINT/arch"

  mkdir --parents --verbose "$arch_dir"

  xhs --output "$arch_dir/sha256sums.txt" --download \
    "$download_url/sha256sums.txt"

  sha256=$(
    awk '$2 == "archlinux-x86_64.iso" { print $1 }' "$arch_dir/sha256sums.txt"
  )

  aria2c --dir="$arch_dir" --check-integrity=true --continue=true \
    --checksum="sha-256=$sha256" --out="archlinux-x86_64.iso" \
    --allow-overwrite=true "$download_url/archlinux-x86_64.iso"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  prepare-arch
fi
