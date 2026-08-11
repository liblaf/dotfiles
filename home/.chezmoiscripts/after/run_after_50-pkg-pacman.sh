#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl --now disable cachyos-rate-mirrors.timer
sudo systemctl --now enable arch-rate-mirrors@arch.timer
sudo systemctl --now enable arch-rate-mirrors@arch4edu.timer
sudo systemctl --now enable arch-rate-mirrors@archlinuxcn.timer
sudo systemctl --now enable arch-rate-mirrors@cachyos.timer
sudo systemctl start pkgstats.timer
systemctl --user --now enable arch-update.timer
