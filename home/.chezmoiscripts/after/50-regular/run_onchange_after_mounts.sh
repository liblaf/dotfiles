#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl --now enable "$(systemd-escape --suffix='automount' --path '/mnt/DATA41/Users/liqin')"
sudo systemctl --now enable "$(systemd-escape --suffix='automount' --path '/mnt/DATA41/Users2/liqin')"

if [[ "$(hostname)" == 'PC07' ]]; then
  sudo systemctl --now enable "$(systemd-escape --suffix='automount' --path '/mnt/PC07sda1')"
  sudo systemctl --now enable xfs_scrub_all.timer
fi
