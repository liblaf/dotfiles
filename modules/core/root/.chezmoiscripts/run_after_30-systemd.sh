#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now earlyoom.service
sudo systemctl enable --now logrotate.timer
