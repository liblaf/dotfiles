#!/usr/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

packages=(
  curl
  jq
  nginx
)

sudo apt update
sudo apt install --yes "${packages[@]}"
