#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if ! type flatpak &> /dev/null; then
  exit
fi

flatpak update --assumeyes
