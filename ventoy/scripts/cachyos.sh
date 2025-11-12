#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/config.sh"

function prepare-cachyos() {
  local version='250713'

  prompt-mountpoint
  local cachyos_dir="$MOUNTPOINT/cachyos"

  local download_url="https://mirrors.cernet.edu.cn/cachyos/ISO/desktop/$version"
  local iso_filename="cachyos-desktop-linux-$version.iso"

  mkdir --parents --verbose "$cachyos_dir"

  xhs --output "$cachyos_dir/$iso_filename.sha256" \
    --download "$download_url/$iso_filename.sha256"

  sha256=$(
    awk -v iso_filename="$iso_filename" '$2 == iso_filename { print $1 }' \
      "$cachyos_dir/$iso_filename.sha256"
  )

  aria2c --dir="$cachyos_dir" --check-integrity=true --continue=true \
    --checksum="sha-256=$sha256" --out="$iso_filename" --user-agent="curl" \
    --allow-overwrite=true "$download_url/$iso_filename"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  prepare-cachyos
fi
