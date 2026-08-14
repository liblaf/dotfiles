#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

fstype="$(
  findmnt --json '/' |
    jq --raw-output '.filesystems[0].fstype'
)"
if [[ $fstype != "btrfs" ]]; then exit; fi

# ref: <https://github.com/CachyOS/CachyOS-PKGBUILDS/blob/master/cachyos-snapper-support/snapper-template-root-cachyos>
sudo snapper set-config TIMELINE_CREATE='yes'

# ref: <https://wiki.archlinux.org/title/Btrfs#Start_with_a_service_or_timer>
sudo systemctl --now enable "$(systemd-escape --template='btrfs-scrub@.timer' --path '/')"

# snapper
sudo systemctl --now enable snapper-backup.timer
sudo systemctl --now enable snapper-boot.timer
sudo systemctl --now enable snapper-cleanup.timer
sudo systemctl --now enable snapper-timeline.timer
