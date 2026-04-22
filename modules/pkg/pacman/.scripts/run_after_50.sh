#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl enable --now arch-rate-mirrors@arch4edu.timer
sudo systemctl enable --now arch-rate-mirrors@archlinuxcn.timer
sudo systemctl start pkgstats.timer
systemctl --user enable --now arch-update.timer
