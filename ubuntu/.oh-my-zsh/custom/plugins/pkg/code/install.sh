#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "$(realpath "${0}")")")/utils.sh"
filename="code.deb"
filepath="${HOME}/Downloads/${filename}"
download "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" "${filepath}"
sudo apt install "${filepath}"
