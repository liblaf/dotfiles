#!/bin/bash

# https://wiki.archlinux.org/title/NVIDIA#Installation
data=$(lspci -vmm -d ::03xx)
vendor=$(echo "$data" | awk -F '\t' '$1 == "Vendor:" { print $2 }')
if [[ $vendor == "NVIDIA Corporation" ]]; then
  device=$(echo "$data" | awk -F '\t' '$1 == "Device:" { print $2 }')
  codename=$(echo "$device" | awk '{ print $1 }')
  echo "Hardware > NVIDIA Device: $device"
  export NVIDIA=true
  case "$codename" in
    # Maxwell (NV110/GMXXX) through Ada Lovelace (NV190/ADXXX)
    GM* | GP* | GV*)
      echo "Hardware > NVIDIA Driver: proprietary"
      export NVIDIA_DRIVER=proprietary
      ;;
    # Turing (NV160/TUXXX) and newer
    *)
      echo "Hardware > NVIDIA Driver: open"
      export NVIDIA_DRIVER=open
      ;;
  esac
  if echo "$device" | grep --ignore-case mobile > /dev/null; then
    export NVIDIA_MOBILE=true
  fi
  echo "Hardware > NVIDIA Mobile: ${NVIDIA_MOBILE:-"false"}"
else
  echo "Hardware > NVIDIA: false"
fi
