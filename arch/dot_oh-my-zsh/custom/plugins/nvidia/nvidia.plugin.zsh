#!/usr/bin/zsh

if lspci | grep --ignore-case nvidia > /dev/null; then
  if pacman --query nvidia-vaapi-driver > /dev/null; then
    export LIBVA_DRIVER_NAME=nvidia
  fi
fi
