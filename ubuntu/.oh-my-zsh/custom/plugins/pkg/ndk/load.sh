#!/usr/bin/env bash

version="${1:-"r25"}"

source "${ZSH_CUSTOM:-"${ZSH:-"${HOME}/.oh-my-zsh"}/custom"}/plugins/compress/compress.plugin.zsh"

case "${version}" in
"r21" | "r21e" | "21" | "21.4" | "21.4.7075529")
  if [ -d "${HOME}/.local/pkgs/ndk/r21e" ]; then
    export ANDROID_NDK="${HOME}/.local/pkgs/ndk/r21e"
  else
    echo "NDK ${version} not found"
  fi
  ;;
"r14" | "r14b")
  if [ -d "${HOME}/.local/pkgs/ndk/r14b" ]; then
    export ANDROID_NDK="${HOME}/.local/pkgs/ndk/r14b"
  else
    echo "NDK ${version} not found"
  fi
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
