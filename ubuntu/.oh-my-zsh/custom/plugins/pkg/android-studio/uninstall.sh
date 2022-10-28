#!/usr/bin/bash
set -o errexit
set -o nounset

source "${PKG_HOME}/utility.sh"

version="${1:-"all"}"

function uninstall-android-studio() {
  rm --force --recursive "${HOME}/.local/opt/android-studio/${version}/"
  rm --force "${DESKTOP_FILE_INSTALL_DIR}/android-studio-${version}.desktop"
}

case "${version}" in
"all")
  rm --force --recursive "${HOME}/.local/opt/android-studio/"
  rm --force --recursive "${HOME}/Android/"
  rm --force --recursive "${HOME}/.AndroidStudio2.3/"
  rm --force --recursive "${HOME}/.android/"
  rm --force --recursive ${DESKTOP_FILE_INSTALL_DIR}/android-studio-*.desktop
  ;;
"2021" | "2021.3" | "2021.3.1" | "2021.3.1.16")
  version="2021.3.1.16"
  uninstall-android-studio
  ;;
"2" | "2.3" | "2.3.3" | "2.3.3.0")
  version="2.3.3.0"
  uninstall-android-studio
  ;;
"2.3.2" | "2.3.2.0")
  version="2.3.2.0"
  uninstall-android-studio
  ;;
*)
  echo "This script does not support Android Studio version \"${version}\""
  ;;
esac
