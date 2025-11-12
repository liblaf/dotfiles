#!/bin/bash

function paru() {
  if type -f paru &> /dev/null; then
    command paru "$@"
  elif type -f pacman &> /dev/null; then
    sudo pacman "$@"
  fi
}

function paru-install() {
  local packages
  readarray -t packages < <(
    comm -13 --check-order \
      <(paru --query --quiet | sort --dictionary-order --unique) \
      <(printf "%s\n" "$@" | sort --dictionary-order --unique)
  )
  if ((${#packages[@]} == 0)); then return; fi
  paru --sync --noconfirm --needed "${packages[@]}"
}

function paru-remove() {
  paru --remove --noconfirm --nosave --recursive "$@"
}
