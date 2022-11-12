#!/usr/bin/zsh
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.zsh"

version="${1:-"2021"}"

function install-android-studio() {
  local filepath="${HOME}/Downloads/${filename}"
  download "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${version}/${filename}" "${filepath}"
  ext "${filepath}" "${HOME}/.local/opt"
  replace ${HOME}/.local/opt/android-studio-*/android-studio "${HOME}/.local/opt/android-studio/${version}"
  rm --force --recursive ${HOME}/.local/opt/android-studio-*
  local Name="Android Studio ${version}"
  local Exec="${HOME}/.local/opt/android-studio/${version}/bin/studio.sh"
  local Icon="${HOME}/.local/opt/android-studio/${version}/bin/studio.png"
  make-desktop-entry "android-studio-${version}"
  info 'Add `adb` to path: `pkg doctor android-studio`'
}

case "${version}" in
  "2021" | "2021.3" | "2021.3.1" | "2021.3.1.16")
    version="2021.3.1.16"
    filename="android-studio-2021.3.1.16-linux.tar.gz"
    install-android-studio
    ;;
  "2" | "2.3" | "2.3.3" | "2.3.3.0")
    version="2.3.3.0"
    filename="android-studio-ide-162.4069837-linux.zip"
    install-android-studio
    ;;
  "2.3.2" | "2.3.2.0")
    version="2.3.2.0"
    filename="android-studio-ide-162.3934792-linux.zip"
    install-android-studio
    ;;
  *)
    echo "This script does not support Android Studio version \"${version}\""
    ;;
esac
