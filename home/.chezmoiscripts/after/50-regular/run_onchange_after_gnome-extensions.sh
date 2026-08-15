#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

readonly extensions_to_install=(
  BingWallpaper@ineffable-gmail.com
  display-brightness-ddcutil@themightydeity.github.com
)
gext install "${extensions_to_install[@]}"

readonly extensions_to_enable=(
  # pre-installed
  drive-menu@gnome-shell-extensions.gcampax.github.com
  screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com

  # system
  appindicatorsupport@rgcjonas.gmail.com
  copyous@boerdereinar.dev
  dash-to-dock@micxgx.gmail.com
  Vitals@CoreCoding.com

  "${extensions_to_install[@]}"
)
gext enable "${extensions_to_enable[@]}"
