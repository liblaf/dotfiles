#!/usr/bin/env bash
set -o errexit
set -o nounset

version="${1:-"all"}"

case "${version}" in
"all")
  rm --force --recursive "${HOME}/.local/pkgs/android-studio/"
  rm --force --recursive "${HOME}/Android/"
  ;;
"2" | "2.3" | "2.3.3")
  rm --force --recursive "${HOME}/.local/pkgs/android-studio/2.3.3/"
  ;;
"2.3.2")
  rm --force --recursive "${HOME}/.local/pkgs/android-studio/2.3.2/"
  ;;
*)
  echo "This script does not support Android Studio version \"${version}\""
  ;;
esac
