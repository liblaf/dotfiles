#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# https://wiki.archlinux.org/title/NVIDIA#Installation
data=$(lspci -vmm -d ::03xx)
vendor=$(echo "$data" | yq '.Vendor')
if [[ $vendor == "NVIDIA Corporation" ]]; then
  echo '.hardware.nvidia.exists = true'
  device=$(echo "$data" | yq '.Device')
  codename=$(echo "$device" | awk '{ print $1 }')
  echo ".hardware.nvidia.codename = \"$codename\""
  case "$codename" in
    # Maxwell (NV110/GMXXX) through Ada Lovelace (NV190/ADXXX)
    GM* | GP* | GV*) echo '.hardware.nvidia.driver = "proprietary"' ;;
    # Turing (NV160/TUXXX) and newer
    *) echo '.hardware.nvidia.driver = "open"' ;;
  esac
  if echo "$device" | grep --ignore-case --quiet "mobile"; then
    echo '.hardware.nvidia.mobile = true'
  else
    echo '.hardware.nvidia.mobile = false'
  fi
else
  echo '.hardware.nvidia.exists = false'
  echo '.hardware.nvidia.codename = null'
  echo '.hardware.nvidia.driver = null'
  echo '.hardware.nvidia.mobile = false'
fi
