#!/bin/bash
# vim: syntax=sh
set -o errexit
set -o nounset
set -o pipefail

export PATH="${HOME}/.local/bin:${PATH}"
uv tool install --force gnome-extensions-cli

extensions_to_install=(
  BingWallpaper@ineffable-gmail.com
  display-brightness-ddcutil@themightydeity.github.com
  power-profile-switcher@eliapasquali.github.io
  unblank@sun.wxg@gmail.com
)
gext install "${extensions_to_install[@]}"
extensions_to_enable=(
  # pre-installed
  apps-menu@gnome-shell-extensions.gcampax.github.com
  drive-menu@gnome-shell-extensions.gcampax.github.com
  places-menu@gnome-shell-extensions.gcampax.github.com
  screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com

  # system
  appindicatorsupport@rgcjonas.gmail.com
  dash-to-dock@micxgx.gmail.com
  Vitals@CoreCoding.com

  # user
  "${extensions_to_install[@]}"
)
gext enable "${extensions_to_enable[@]}"

dconf load / < "$HOME/.cache/dotfiles/assets/dconf.ini"
