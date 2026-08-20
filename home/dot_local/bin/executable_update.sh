#!/bin/bash
# @flag -y --yes
set -o errexit
set -o nounset
set -o pipefail

function main() {
  readarray -d '' -t scripts < <(
    find "$HOME/.local/share/dotfiles/update.d/" -type f -print0 |
      sort --zero-terminated
  )
  local -r format="$(tput bold)$(tput setaf 2)==>$(tput sgr0) $(tput bold)%s$(tput sgr0)\n"
  export argc_yes
  for script in "${scripts[@]}"; do
    # shellcheck disable=SC2059
    printf "$format" "$script"
    "$script"
  done
}

eval "$(argc --argc-eval "$0" "$@")"
