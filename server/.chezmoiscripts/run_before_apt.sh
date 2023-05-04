#!/usr/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

sudo apt update
sudo apt full-upgrade

packages=(
  curl
  jq
  nginx
)

sudo apt install "${packages[@]}"
