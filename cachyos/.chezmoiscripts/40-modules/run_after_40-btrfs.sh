#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

fstype="$(findmnt --noheadings --output FSTYPE /)"
if [[ $fstype != "btrfs" ]]; then exit 0; fi

# ref: <https://wiki.archlinux.org/title/Snapper#Wrapping_pacman_transactions_in_snapshots>
packages=(
  btrfs-assistant
  btrfs-desktop-notification
  cachyos-snapper-support
  grub-btrfs
  grub-btrfs-support
  snap-pac
  snap-pac-grub
  snapper
)
yay --sync --needed --noconfirm "${packages[@]}"

# ref: <https://wiki.archlinux.org/title/Btrfs#Start_with_a_service_or_timer>
sudo systemctl enable --now "btrfs-scrub@$(systemd-escape --path /).timer"

# setup snapper
# see also: <cachyos/dot_cache/exact_dotfiles/exact_root/exact_etc/exact_snapper/exact_configs/private_root>
sudo systemctl enable --now snapper-backup.timer
sudo systemctl enable --now snapper-boot.timer
sudo systemctl enable --now snapper-cleanup.timer
sudo systemctl enable --now snapper-timeline.timer
