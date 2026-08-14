#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl --now enable bluetooth.service
sudo systemctl --now enable earlyoom.service
sudo systemctl --now enable logrotate.timer
