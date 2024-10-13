#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# TODO: remove this workaround
for name in $(env | grep --ignore-case "_proxy" | awk -F = '{ print $1 }'); do
	unset "$name"
done

pkg_list=(
	@biomejs/biome
	commitizen
	cspell
	speedscope
)

bun add --global "${pkg_list[@]}"
bun update --global --latest
