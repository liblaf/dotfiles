#!/usr/bin/env bash
set -o errexit
set -o nounset

cd "$(dirname "${0}")/argon-grub-theme"
git submodule update --init --remote --depth 1 --recursive
sudo bash install.sh --install --background Dusk --resolution 4k --fontsize 32 --help-label
