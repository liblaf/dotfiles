#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export no_proxy="localhost,127.0.0.0/8,::1,.npmmirror.com"
export NO_PROXY="$no_proxy"

pkg_list=(
  @biomejs/biome
  commitizen
  cspell
  prettier
  repomix
  speedscope
  vercel
)

pnpm add --global "${pkg_list[@]}"
pnpm update --latest --global
