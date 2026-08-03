#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ! -f 'arch-update-tray.desktop' ]]; then
  cachy-update --tray --enable
fi
