#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

version="${1:-"2021"}"

function install-android-studio() {
  filepath="${HOME}/Downloads/${filename}"
  download "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${version}/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/.local/pkgs/android-studio/"
  rm --force --recursive "${HOME}/.local/pkgs/android-studio/${version}/"
  mv "${HOME}/.local/pkgs/android-studio/android-studio/" "${HOME}/.local/pkgs/android-studio/${version}/"
  export DESKTOP_FILE_INSTALL_DIR="${HOME}/.local/share/applications"
  mkdir --parents "${DESKTOP_FILE_INSTALL_DIR}"
  local desktop_entry="${DESKTOP_FILE_INSTALL_DIR}/android-studio-${version}.desktop"
  cat >"${desktop_entry}" <<-EOF
[Desktop Entry]
Type=Application
Name=Android Studio ${version}
Exec=${HOME}/.local/pkgs/android-studio/${version}/bin/studio.sh
Icon=${HOME}/.local/pkgs/android-studio/${version}/bin/studio.png
Terminal=false
EOF
  desktop-file-install --dir "${DESKTOP_FILE_INSTALL_DIR}" "${desktop_entry}"
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
