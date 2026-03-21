#!/bin/bash

function yay() {
  if type -f yay &> /dev/null; then
    command yay "$@"
  elif type -f pacman &> /dev/null; then
    sudo pacman "$@"
  fi
}

function yay-install() {
  local packages
  readarray -t packages < <(
    comm -13 --check-order \
      <(yay --query --quiet | sort --dictionary-order --unique) \
      <(printf "%s\n" "$@" | sort --dictionary-order --unique)
  )
  if ((${#packages[@]} == 0)); then return; fi
  yay --sync --noconfirm --needed "${packages[@]}"
}

function yay-remove() {
  local packages
  readarray -t packages < <(
    comm -12 --check-order \
      <(yay --query --quiet | sort --dictionary-order --unique) \
      <(printf "%s\n" "$@" | sort --dictionary-order --unique)
  )
  if ((${#packages[@]} == 0)); then return; fi
  yay --remove --noconfirm --nosave --recursive "${packages[@]}"
}
