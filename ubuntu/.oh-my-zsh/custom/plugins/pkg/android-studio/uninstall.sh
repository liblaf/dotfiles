#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

version="${1:-"all"}"

function uninstall-android-studio() {
  remove "${HOME}/.local/opt/android-studio/${version}"
  remove "${DESKTOP_FILE_INSTALL_DIR}/android-studio-${version}.desktop"
}

case "${version}" in
  "all")
    remove "${HOME}/.local/opt/android-studio"
    remove "${HOME}/Android"
    remove "${HOME}/.AndroidStudio2.3"
    remove "${HOME}/.android"
    remove ${DESKTOP_FILE_INSTALL_DIR}/android-studio-*.desktop
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
