#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

version="${1:-"r25"}"

case "${version}" in
"r25" | "25.0.8775105")
  filename="clang-r450784d.tar.gz"
  filepath="${HOME}/Downloads/${filename}"
  download "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/ndk-r25/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/.local/pkgs/ndk/r25/toolchains/llvm/prebuilt/linux-x86_64/"
  ;;
"r21" | "r21e" | "21" | "21.4" | "21.4.7075529")
  filename="clang-r365631c3.tar.gz"
  filepath="${HOME}/Downloads/${filename}"
  download "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/ndk-r21e/${filename}" "${filepath}"
  extract "${filepath}" "${HOME}/.local/pkgs/ndk/r21e/toolchains/llvm/prebuilt/linux-x86_64/"
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
