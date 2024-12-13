#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

user_shell=$(getent passwd "$USER" | cut --delimiter ':' --fields 7)
if [[ $user_shell != /usr/bin/fish ]]; then
  chsh --shell /usr/bin/fish
fi

function group-add() {
  local group=$1
  if ! groups | grep "$group" > /dev/null; then
    if grep "$group" /etc/group > /dev/null; then
      # https://wiki.archlinux.org/title/Users_and_groups#Group_management
      sudo gpasswd --add "$USER" "$group"
    fi
  fi
}

group-add docker
group-add vboxusers
group-add vcpkg

# https://wiki.archlinux.org/title/Systemd/User#Automatic_start-up_of_systemd_user_instances
loginctl enable-linger "$USER"
