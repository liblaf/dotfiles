#!/bin/bash

function yay-install() {
  local install
  readarray -t install < <(
    comm -13 --check-order \
      <(yay --query --quiet | sort --dictionary-order --unique) \
      <(printf "%s\n" "$@" | sort --dictionary-order --unique)
  )
  if ((${#install[@]} == 0)); then return; fi
  yay --sync --noconfirm --needed "${install[@]}"
}

function yay-remove() {
  local remove
  readarray -t remove < <(
    comm -12 --check-order \
      <(yay --query --quiet | sort --dictionary-order --unique) \
      <(printf "%s\n" "$@" | sort --dictionary-order --unique)
  )
  if ((${#remove[@]} == 0)); then return; fi
  yay --remove --noconfirm --nosave --recursive "${remove[@]}"
}
