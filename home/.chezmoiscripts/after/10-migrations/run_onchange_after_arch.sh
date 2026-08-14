#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_packages=(
  wps-office-365
  wps-office-365-fonts
)

readarray -t packages_to_remove < <(
  pacman --query --quiet "${legacy_packages[@]}" 2> /dev/null
)

if ((${#packages_to_remove[@]} > 0)); then
  sudo pacman --remove --noconfirm --nosave --recursive "${packages_to_remove[@]}"
fi
