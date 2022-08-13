#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

version="${1:-"r25"}"

case "${version}" in
"r25" | "25.0.8775105")
  filename="android-ndk-r25-linux.zip"
  filepath="${HOME}/Downloads/${filename}"
  download "https://dl.google.com/android/repository/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/.local/pkgs/ndk/"
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r25"
  mv "${HOME}/.local/pkgs/ndk/android-ndk-r25" "${HOME}/.local/pkgs/ndk/r25"
  ;;
"r21" | "r21e" | "21" | "21.4" | "21.4.7075529")
  filename="android-ndk-r21e-linux-x86_64.zip"
  filepath="${HOME}/Downloads/${filename}"
  download "https://dl.google.com/android/repository/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/.local/pkgs/ndk/"
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r21e"
  mv "${HOME}/.local/pkgs/ndk/android-ndk-r21e" "${HOME}/.local/pkgs/ndk/r21e"
  ;;
"r14" | "r14b")
  filename="android-ndk-r14b-linux-x86_64.zip"
  filepath="${HOME}/Downloads/${filename}"
  download "https://dl.google.com/android/repository/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/.local/pkgs/ndk/"
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r14b"
  mv "${HOME}/.local/pkgs/ndk/android-ndk-r14b" "${HOME}/.local/pkgs/ndk/r14b"
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
