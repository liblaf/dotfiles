#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Node.js would stuck if proxy is on
export no_proxy="{{ .no_proxy }}"
export NO_PROXY="$no_proxy"

pkg_list=(
  @biomejs/biome
  @liblaf/sub-converter
  commitizen
  cspell
  prettier
  repomix
  speedscope
  vercel
)

bun add --global "${pkg_list[@]}"
bun update --global --latest
