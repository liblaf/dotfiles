#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

user_shell=$(getent passwd "$USER" | awk --field-separator=":" '{ print $NF }')
if [[ $user_shell != /usr/bin/fish ]]; then
  chsh --shell /usr/bin/fish
fi

function group-add() {
  local group=$1
  if ! groups | grep "$group" > /dev/null; then
    if grep "$group" /etc/group > /dev/null; then
      sudo gpasswd --add "$USER" "$group"
    fi
  fi
}

group-add docker
group-add vcpkg

loginctl enable-linger "$USER"
