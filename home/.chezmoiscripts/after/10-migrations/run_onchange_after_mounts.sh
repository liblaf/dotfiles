#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_mounts=(
  '/mnt/DATA41-forgejo'
  '/mnt/DATA41'
  '/mnt/pc06-sda1'
  '/mnt/PC06sda1'
  '/mnt/seafile'
  '/mnt/tsinghua'
  "$HOME/DATA41"
  "$HOME/GJM-AList"
  "$HOME/seafile"
)

for where in "${legacy_mounts[@]}"; do
  automount_unit="$(systemd-escape --suffix='automount' --path "$where")"
  mount_unit="$(systemd-escape --suffix='mount' --path "$where")"
  sudo systemctl --now disable "$automount_unit" 2> /dev/null || true
  sudo systemctl stop "$mount_unit" 2> /dev/null || true
  sudo rm --force --verbose \
    "/etc/systemd/system/$automount_unit" \
    "/etc/systemd/system/$mount_unit"
  if [[ -d $where ]]; then sudo rmdir --verbose "$where"; fi
done

sudo rm --force --verbose \
  '/etc/cifs/credentials/DATA41.cred' \
  '/etc/credentials/DATA41.credentials'
rm --force --verbose "$HOME/.config/seadrive/seadrive.conf"
if [[ -d "$HOME/.config/seadrive" ]]; then rmdir --verbose "$HOME/.config/seadrive"; fi
