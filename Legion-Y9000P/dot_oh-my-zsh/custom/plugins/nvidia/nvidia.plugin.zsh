#!/usr/bin/zsh

if pacman --query nvidia-vaapi-driver &> /dev/null; then
  export LIBVA_DRIVER_NAME=nvidia
fi
