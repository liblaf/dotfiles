#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

if [[ "$(hostname)" != "PC07" ]]; then exit; fi

sudo systemctl enable --now "$(systemd-escape --suffix='automount' --path '/mnt/PC07sda1')"
sudo systemctl enable --now xfs_scrub_all.timer
