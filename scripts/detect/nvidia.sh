#!/bin/bash

# https://wiki.archlinux.org/title/NVIDIA#Installation
if lspci -d ::03xx | grep --ignore-case nvidia > /dev/null; then
  export NVIDIA=true
  if lspci -d ::03xx | grep --ignore-case nvidia | grep --ignore-case mobile > /dev/null; then
    export NVIDIA_MOBILE=true
  fi
fi
