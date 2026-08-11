#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

function umount() {
  local -r what="$1"
  if [[ ! -e $what ]]; then
    return
  fi
  sudo systemctl --now disable "$(systemd-escape --suffix='automount' --path "$what")"
  sudo rm --force --verbose "/etc/systemd/system/$(systemd-escape --suffix='automount' --path "$what")"
  sudo rm --force --verbose "/etc/systemd/system/$(systemd-escape --suffix='mount' --path "$what")"
  sudo rmdir --verbose "$what"
}

umount "$HOME/DATA41"
umount "$HOME/GJM-AList"
umount "$HOME/seafile"
