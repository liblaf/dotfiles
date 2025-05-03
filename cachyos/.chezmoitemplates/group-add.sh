#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function group-add() {
  local group="${1:-"$GROUP"}"
  local user="${2:-"$USER"}"
  if getent groups "$group"; then
    # ref: <https://wiki.archlinux.org/title/Users_and_groups#Group_management>
    sudo gpasswd --add "$user" "$group"
  else
    echo "group '$group' does not exist"
  fi
}
