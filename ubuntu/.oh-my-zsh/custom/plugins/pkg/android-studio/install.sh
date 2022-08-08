#!/usr/bin/env bash
set -o errexit
set -o nounset

version="${1:-"2021"}"

case "${version}" in
"2" | "2.3" | "2.3.3")
  filename="android-studio-ide-162.4069837-linux.zip"
  mkdir --parents "${HOME}/Downloads/"
  filepath="${HOME}/Downloads/${filename}"
  # wget --output-document="-" "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2.3.3.0/${filename}" |
  #   tee "${filepath}" >"/dev/null"
  mkdir --parents "${HOME}/.local/pkgs/android-studio/"
  7zz x "${filepath}" -o"${HOME}/.local/pkgs/android-studio/"
  rm --force --recursive "${HOME}/.local/pkgs/android-studio/2.3.3/"
  mv "${HOME}/.local/pkgs/android-studio/android-studio/" "${HOME}/.local/pkgs/android-studio/2.3.3/"
  ;;
"2.3.2")
  filename="android-studio-ide-162.3934792-linux.zip"
  mkdir --parents "${HOME}/Downloads/"
  filepath="${HOME}/Downloads/${filename}"
  wget --output-document="-" "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2.3.2.0/${filename}" |
    tee "${filepath}" >"/dev/null"
  mkdir --parents "${HOME}/.local/pkgs/android-studio/"
  7zz x "${filepath}" -o"${HOME}/.local/pkgs/android-studio/"
  rm --force --recursive "${HOME}/.local/pkgs/android-studio/2.3.2/"
  mv "${HOME}/.local/pkgs/android-studio/android-studio/" "${HOME}/.local/pkgs/android-studio/2.3.2/"
  ;;
*)
  echo "This script does not support Android Studio version \"${version}\""
  ;;
esac
