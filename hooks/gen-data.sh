#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function data-chassis() {
  local chassis virt
  chassis="$(hostnamectl chassis)"
  virt="$(systemd-detect-virt || true)"
  echo "chassis = \"$chassis\""
  # echo "domain = \"$(hostnamectl).ddns.liblaf.me\""
  echo "virt = \"$virt\""
}

function data-filesystem() {
  local fstype source
  fstype="$(findmnt --noheadings --output FSTYPE /)"
  source="$(findmnt --noheadings --output SOURCE /)"
  echo "fs.fstype = \"$fstype\""
  echo "fs.source = \"$source\""
}

function data-hardware-intel() {
  if grep --ignore-case intel /proc/cpuinfo > /dev/null; then
    echo "hardware.intel.exists = true"
  else
    echo "hardware.intel.exists = false"
  fi
}

function data-hardware-nvidia() {
  # ref: <https://wiki.archlinux.org/title/NVIDIA#Installation>
  data=$(lspci -vmm -d ::03xx)
  vendor=$(yq '.Vendor' <<< "$data")
  if [[ $vendor == "NVIDIA Corporation" ]]; then
    echo "hardware.nvidia.exists = true"
    device=$(yq '.Device' <<< "$data")
    codename=$(awk '{ print $1 }' <<< "$device")
    echo "hardware.nvidia.codename = \"$codename\""
    case "$codename" in
      # Maxwell (NV110/GMXXX) through Ada Lovelace (NV190/ADXXX)
      GM* | GP* | GV*) echo 'hardware.nvidia.driver = "proprietary"' ;;
      # Turing (NV160/TUXXX) and newer
      *) echo 'hardware.nvidia.driver = "open"' ;;
    esac
    if grep --ignore-case mobile <<< "$device" > /dev/null; then
      echo "hardware.nvidia.mobile = true"
    else
      echo "hardware.nvidia.mobile = false"
    fi
  else
    echo "hardware.nvidia.exists = false"
    echo "hardware.nvidia.codename = null"
    echo "hardware.nvidia.driver = null"
    echo "hardware.nvidia.mobile = false"
  fi
}

function gen-data() {
  (
    data-chassis
    data-filesystem
    data-hardware-intel
    data-hardware-nvidia
  ) |
    # ref: <https://mikefarah.gitbook.io/yq/usage/properties#decode-properties-numbers>
    yq eval '(.. | select(tag == "!!str")) |= from_yaml' \
      --input-format props \
      --output-format yaml \
      > "$CHEZMOI_SOURCE_DIR/.chezmoidata/generated.yaml"
  yq "$CHEZMOI_SOURCE_DIR/.chezmoidata/generated.yaml"
}

gen-data "$@"
