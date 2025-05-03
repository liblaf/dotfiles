#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

fstype="$(findmnt --noheadings --output FSTYPE /)"
if [[ $fstype != "btrfs" ]]; then exit 0; fi

packages=(
  btrfs-assistant
  btrfs-desktop-notification
  cachyos-snapper-support
  grub-btrfs-support
  snap-pac
  snapper
)
yay --sync --needed --noconfirm "${packages[@]}"

sudo systemctl enable "btrfs-scrub@$(systemd-escape --path /).timer"
