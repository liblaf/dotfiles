#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

pkg_list=(
  'meshio[all]'
  dvc
  gnome-extensions-cli
  https://github.com/liblaf/ai-commit-cli.git
  https://github.com/liblaf/thu-learn-downloader.git
  py-spy
  toml-sort
)

for pkg in "${pkg_list[@]}"; do
  uv tool install --force "$pkg"
done
uv tool upgrade --all
