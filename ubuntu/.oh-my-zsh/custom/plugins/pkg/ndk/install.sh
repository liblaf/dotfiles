#!/usr/bin/env bash
set -o errexit
set -o nounset

version="${1:-"r25"}"

case "${version}" in
"r21" | "r21e" | "21" | "21.4" | "21.4.7075529")
  filename="android-ndk-r21e-linux-x86_64.zip"
  mkdir --parents "${HOME}/Downloads/"
  filepath="${HOME}/Downloads/${filename}"
  wget --output-document="-" "https://dl.google.com/android/repository/${filename}" |
    tee "${filepath}" >"/dev/null"
  mkdir --parents "${HOME}/.local/pkgs/ndk/"
  7zz x "${filepath}" -o"${HOME}/.local/pkgs/ndk/"
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r21e"
  mv "${HOME}/.local/pkgs/ndk/android-ndk-r21e" "${HOME}/.local/pkgs/ndk/r21e"
  ;;
"r14" | "r14b")
  filename="android-ndk-r14b-linux-x86_64.zip"
  mkdir --parents "${HOME}/Downloads/"
  filepath="${HOME}/Downloads/${filename}"
  wget --output-document="-" "https://dl.google.com/android/repository/${filename}" |
    tee "${filepath}" >"/dev/null"
  mkdir --parents "${HOME}/.local/pkgs/ndk/"
  7zz x "${filepath}" -o"${HOME}/.local/pkgs/ndk/"
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r14b"
  mv "${HOME}/.local/pkgs/ndk/android-ndk-r14b" "${HOME}/.local/pkgs/ndk/r14b"
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
