#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

pkgs=(
  conda-lock
  git+https://github.com/liblaf/ai-commit-cli
  git+https://github.com/liblaf/thu-learn-downloader
  poetry
  toml-sort
  utils-cli
)

mapfile -t pkg_installed < <(pipx list --short | awk '{ print $1 }')
for pkg in "${pkgs[@]}"; do
  if [[ ! ${pkg_installed[*]} =~ ${pkg##*/} ]]; then
    pipx install --force "$pkg"
  fi
done
pipx inject poetry poetry-plugin-pypi-mirror
pipx upgrade-all --force
