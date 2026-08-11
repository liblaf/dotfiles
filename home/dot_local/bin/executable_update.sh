#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readarray -t scripts < <(
  find "$HOME/.local/share/dotfiles/update.d/" -type f -print0 |
    sort --zero-terminated
)

for script in "${scripts[@]}"; do
  printf '%s%s==>%s %s\n' "$(tput bold)" "$(tput setaf 2)" "$(tput sgr0)" "$script"
  "$script"
done
