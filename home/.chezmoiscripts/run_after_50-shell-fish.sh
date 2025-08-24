#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

user_shell="$(getent passwd "$USER" |
  cut --delimiter ':' --fields 7)"
if [[ $user_shell != /usr/bin/fish ]]; then
  chsh --shell /usr/bin/fish
fi
