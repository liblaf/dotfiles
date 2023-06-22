#!/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

packages=(
  jq
)

sudo apt update
sudo apt install --yes "${packages[@]}"
