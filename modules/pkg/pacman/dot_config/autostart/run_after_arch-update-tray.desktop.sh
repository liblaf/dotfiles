#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force 'arch-update-tray.desktop'
systemctl --user disable --now arch-update-tray.service
arch-update --tray --enable
