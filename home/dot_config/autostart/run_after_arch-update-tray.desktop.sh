#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force --verbose 'arch-update-tray.desktop'
cachy-update --tray --enable || true
