#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo pacman --remove --noconfirm --nosave --recursive \
  matlab
