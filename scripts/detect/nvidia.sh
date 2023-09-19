#!/bin/bash

if lspci | grep --ignore-case nvidia > /dev/null; then
  export NVIDIA_INSTALL=true
  if lspci | grep --ignore-case nvidia | grep --ignore-case mobile > /dev/null; then
    export NVIDIA_MOBILE=true
  fi
fi
