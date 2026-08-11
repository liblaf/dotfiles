#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

to_enable=(
  # pre-installed
  drive-menu@gnome-shell-extensions.gcampax.github.com
  screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com

  # system
  appindicatorsupport@rgcjonas.gmail.com
  BingWallpaper@ineffable-gmail.com
  copyous@boerdereinar.dev
  dash-to-dock@micxgx.gmail.com
  display-brightness-ddcutil@themightydeity.github.com
  Vitals@CoreCoding.com
)
gext enable "${to_enable[@]}"
