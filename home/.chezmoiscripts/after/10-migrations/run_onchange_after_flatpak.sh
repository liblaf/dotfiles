#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_packages=(
  cn.wps.wps_365
  com.github.tchx84.Flatseal
  moe.tsuna.tsukimi
  org.flameshot.Flameshot
  org.paraview.ParaView
)

readarray -t packages_to_uninstall < <(
  comm -1 -2 \
    <(printf '%s\n' "${legacy_packages[@]}" | sort) \
    <(flatpak list --app --columns='application' | sort)
)

if ((${#packages_to_uninstall[@]} > 0)); then
  sudo flatpak uninstall --delete-data --assumeyes "${packages_to_uninstall[@]}"
fi
