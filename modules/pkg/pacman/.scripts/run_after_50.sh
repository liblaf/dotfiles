#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl start pkgstats.timer
systemctl --user enable --now arch-update-tray.service
systemctl --user enable --now arch-update.timer
