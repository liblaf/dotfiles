#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly source="$HOME/.cache/dotfiles/root"

sudo cp --no-dereference --recursive --target-directory='/' --verbose "$source/."

package_files=()
while IFS= read -r -d '' target; do
  if pacman --query --owns "/$target" --quiet &> /dev/null; then
    package_files+=("/$target")
  fi
done < <(find "$source" -mindepth 1 -printf '%P\0')

if ((${#package_files[@]})); then
  sudo pacrepairfile --uid --gid --mode "${package_files[@]}"
fi
