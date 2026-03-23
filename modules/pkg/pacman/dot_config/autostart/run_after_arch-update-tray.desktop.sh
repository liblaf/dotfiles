#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force 'arch-update-tray.desktop'
arch-update --tray --enable
