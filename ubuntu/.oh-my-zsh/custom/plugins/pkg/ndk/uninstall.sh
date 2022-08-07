#!/usr/bin/env bash
set -o errexit
set -o nounset

version="${1:-"all"}"

case "${version}" in
"all")
  rm --force --recursive "${HOME}/.local/pkgs/ndk/"
  ;;
"r21" | "r21e" | "21" | "21.4" | "21.4.7075529")
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r21e/"
  ;;
"r14" | "r14b")
  rm --force --recursive "${HOME}/.local/pkgs/ndk/r14b/"
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
