#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

fstype="$(findmnt --noheadings --output FSTYPE /)"
if [[ $fstype != "btrfs" ]]; then exit; fi

# ref: <https://wiki.archlinux.org/title/Btrfs#Start_with_a_service_or_timer>
scrub_path=$(systemd-escape --path /)
sudo systemctl enable --now "btrfs-scrub@$scrub_path.timer"

# setup snapper
sudo systemctl enable --now snapper-backup.timer
sudo systemctl enable --now snapper-boot.timer
sudo systemctl enable --now snapper-cleanup.timer
sudo systemctl enable --now snapper-timeline.timer
