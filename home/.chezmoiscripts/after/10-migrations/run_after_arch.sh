#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_packages=()

installed_packages=()
for package in "${legacy_packages[@]}"; do
  if pacman --query --quiet "$package" &> /dev/null; then
    installed_packages+=("$package")
  fi
done

if ((${#installed_packages[@]} > 0)); then
  sudo pacman --remove --noconfirm --nosave --recursive "${installed_packages[@]}"
fi
