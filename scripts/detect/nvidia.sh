#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# https://wiki.archlinux.org/title/NVIDIA#Installation
data=$(lspci -vmm -d ::03xx)
vendor=$(echo "$data" | awk -F '\t' '$1 == "Vendor:" { print $2 }')
if [[ $vendor == "NVIDIA Corporation" ]]; then
  device=$(echo "$data" | awk -F '\t' '$1 == "Device:" { print $2 }')
  codename=$(echo "$device" | awk '{ print $1 }')
  echo "Hardware > NVIDIA Device: $device"
  yq --inplace '.hardware.nvidia.exists = true' "$DATA_FILE"
  case "$codename" in
    # Maxwell (NV110/GMXXX) through Ada Lovelace (NV190/ADXXX)
    GM* | GP* | GV*)
      echo "Hardware > NVIDIA Driver: proprietary"
      yq --inplace '.hardware.nvidia.driver = "proprietary"' "$DATA_FILE"
      ;;
    # Turing (NV160/TUXXX) and newer
    *)
      echo "Hardware > NVIDIA Driver: open"
      yq --inplace '.hardware.nvidia.driver = "open"' "$DATA_FILE"
      ;;
  esac
  if echo "$device" | grep --ignore-case mobile > /dev/null; then
    echo "Hardware > NVIDIA Mobile: true"
    yq --inplace '.hardware.nvidia.mobile = true' "$DATA_FILE"
  else
    echo "Hardware > NVIDIA Mobile: false"
    yq --inplace '.hardware.nvidia.mobile = false' "$DATA_FILE"
  fi
else
  echo "Hardware > NVIDIA: false"
  yq --inplace ".hardware.nvidia.exists = false" "$DATA_FILE"
  yq --inplace '.hardware.nvidia.driver = null' "$DATA_FILE"
  yq --inplace '.hardware.nvidia.mobile = false' "$DATA_FILE"
fi
