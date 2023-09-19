#!/usr/bin/zsh

if lspci | grep NVIDIA &> /dev/null; then
  export LIBVA_DRIVER_NAME=nvidia
fi
