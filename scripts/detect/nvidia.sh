#!/bin/bash

# https://wiki.archlinux.org/title/NVIDIA#Installation
device=$(
  lspci -d ::03xx | grep --ignore-case nvidia
  true
)
if [[ -n $device ]]; then
  export NVIDIA=true
  case "$device" in
    *GP102*) export NVIDIA_DRIVER=proprietary ;;
    *) export NVIDIA_DRIVER=open ;;
  esac
  if echo "$device" | grep --ignore-case mobile > /dev/null; then
    export NVIDIA_MOBILE=true
  fi
fi
