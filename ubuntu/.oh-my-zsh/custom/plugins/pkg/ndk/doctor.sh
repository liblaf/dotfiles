#!/usr/bin/env bash
set -o errexit
set -o nounset

version="${1:-"r25"}"

case "${version}" in
"r21" | "r21e" | "21" | "21.4" | "21.4.7075529")
  filename="clang-r365631c3.tar.gz"
  filepath="${HOME}/Downloads/${filename}"
  wget --output-document="-" "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/tags/ndk-r21e/${filename}" |
    tee "${filepath}" >"/dev/null"
  pv "${filepath}" |
    tar --extract --skip-old-files --gzip --directory="${HOME}/.local/pkgs/ndk/r21e/toolchains/llvm/prebuilt/linux-x86_64/"
  ;;
*)
  echo "This script does not support NDK version \"${version}\""
  ;;
esac
