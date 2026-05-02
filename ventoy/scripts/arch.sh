#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTDIR="$(dirname -- "${BASH_SOURCE[0]}")"
# shellcheck disable=SC1091
source "$SCRIPTDIR/config.sh"

function prepare-arch() {
  local download_url='https://mirrors.cernet.edu.cn/archlinux/iso/latest'

  prompt-mountpoint
  local iso_dir="$MOUNTPOINT/ISO/"

  mkdir --parents --verbose "$iso_dir"

  xhs --output "$iso_dir/archlinux-x86_64.iso.sha256" --download \
    "$download_url/sha256sums.txt"

  sha256=$(
    awk '$2 == "archlinux-x86_64.iso" { print $1 }' "$iso_dir/archlinux-x86_64.iso.sha256"
  )

  aria2c --dir="$iso_dir" --check-integrity=true --continue=true \
    --checksum="sha-256=$sha256" --out="archlinux-x86_64.iso" \
    --allow-overwrite=true "$download_url/archlinux-x86_64.iso"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  prepare-arch
fi
