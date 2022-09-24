#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

echo "Do not use this script to install NDK."
echo "Use SDK Manager in Android Studio instead."

version="${1}"

function install-ndk() {
  filepath="${HOME}/Downloads/${filename}"
  ANDROID_NDK="${ANDROID_NDK:-"${HOME}/Android/Sdk/ndk/${version}"}"
  download "https://dl.google.com/android/repository/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/Android/Sdk/ndk/"
  rm --force --recursive "${ANDROID_NDK}"
  mv ${HOME}/Android/Sdk/ndk/android-ndk-* "${ANDROID_NDK}"
}

case "${version}" in
"r25b" | "25" | "25.1" | "25.1.8937393")
  version="25.1.8937393"
  filename="android-ndk-r25b-linux.zip"
  install-ndk
  ;;
"r21e" | "21" | "21.4" | "21.4.7075529")
  version="21.4.7075529"
  filename="android-ndk-r21e-linux-x86_64.zip"
  install-ndk
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
