#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

packages=(
  fwupd
)
yay --sync --needed --noconfirm "${packages[@]}"

sudo systemctl enable --now fwupd-refresh.timer
sudo systemctl enable --now fwupd.service
