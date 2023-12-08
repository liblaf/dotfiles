#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

pkgs=(
  ai-commit-cli
  conda-lock
  thu-learn-downloader
  toml-sort
  utils-cli
)

mapfile -t pkg_installed < <(pipx list --short | awk '{ print $1 }')
for pkg in "${pkgs[@]}"; do
  if [[ ! ${pkg_installed[*]} =~ $pkg ]]; then
    pipx install --force "$pkg"
  fi
done
pipx upgrade-all --force
