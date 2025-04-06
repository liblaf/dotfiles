#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export no_proxy="localhost,127.0.0.0/8,::1,.npmmirror.com"
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
