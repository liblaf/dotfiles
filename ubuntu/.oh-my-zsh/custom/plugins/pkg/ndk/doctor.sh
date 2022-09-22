#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

function get-version() {
  case "${1}" in
  "r25b" | "25" | "25.1" | "25.1.8937393")
    ndk_version="25.1.8937393"
    ndk_tag="r25b"
    ;;
  "r24" | "24" | "24.0" | "24.0.8215888")
    ndk_version="24.0.8215888"
    ndk_tag="r24"
    ;;
  "r23c" | "23" | "23.2" | "23.2.8568313")
    ndk_version="23.2.8568313"
    ndk_tag="r23c"
    ;;
  "r22b" | "22" | "22.1" | "22.1.7171670")
    ndk_version="22.1.7171670"
    ndk_tag="r22b"
    ;;
  "r21e" | "21" | "21.4" | "21.4.7075529")
    ndk_version="21.4.7075529"
    ndk_tag="r21e"
    ;;
  *)
    echo "This script does not support NDK version \"${1}\""
    ;;
  esac
  echo "NDK Version   : ${ndk_version}"
  echo "NDK Tag       : ${ndk_tag}"
  ANDROID_NDK="${HOME}/Android/Sdk/ndk/${ndk_version}"
  LLVM_HOME="${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64"
}

function install-prebuilt() {
  get-version "${1}"
  local clang_version="$(sed --quiet '2p' "${LLVM_HOME}/AndroidVersion.txt" | awk '{ print $3 }')"
  echo "Clang Tag     : ${clang_version}"
  local filename="clang-${clang_version}.tar.gz"
  local filepath="${HOME}/Downloads/${filename}"
  download "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/ndk-${ndk_tag}/${filename}" "${filepath}"
  extract "${filepath}" "${LLVM_HOME}"
}

function copy-prebuilt() {
  get-version "${1}"
  local SOURCE_LLVM_HOME="${LLVM_HOME}"
  get-version "${2}"
  local DEST_LLVM_HOME="${LLVM_HOME}"
  rm --force --recursive "${DEST_LLVM_HOME}"
  cp --recursive "${SOURCE_LLVM_HOME}" "${DEST_LLVM_HOME}"
}

if [[ -n "${1}" ]]; then
  sub_command="${1}"
  shift 1
else
  sub_command="install-prebuilt"
fi

case "${sub_command}" in
"install-prebuilt")
  install-prebuilt "${@}"
  ;;
"copy-prebuilt")
  copy-prebuilt "${@}"
  ;;
*)
  echo "Unknown sub-command \"${sub_command}\""
  ;;
esac
