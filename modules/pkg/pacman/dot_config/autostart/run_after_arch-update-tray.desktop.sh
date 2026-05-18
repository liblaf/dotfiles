#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force 'arch-update-tray.desktop'
systemctl --global disable arch-update-tray.service
systemctl --user --now disable arch-update-tray.service
arch-update --tray --enable
