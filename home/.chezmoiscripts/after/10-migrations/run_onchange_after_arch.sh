#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_packages=(
  cloudflared
  codexbar-cli-bin
  gnome-shell-extension-bing-wallpaper
  gnome-shell-extension-display-brightness-ddcutil-git
  gnome-shell-extension-power-profile-switcher-git
  unbound
)

readarray -t packages_to_remove < <(
  pacman --query --quiet "${legacy_packages[@]}" 2> /dev/null
)

if ((${#packages_to_remove[@]} > 0)); then
  sudo pacman --remove --noconfirm --nosave --recursive "${packages_to_remove[@]}"
fi
