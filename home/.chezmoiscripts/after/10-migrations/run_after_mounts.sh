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
  sudo systemctl disable --now "$automount_unit" 2> /dev/null || true
  sudo systemctl stop "$mount_unit" 2> /dev/null || true
  sudo rm --force --verbose \
    "/etc/systemd/system/$automount_unit" \
    "/etc/systemd/system/$mount_unit"
  sudo rmdir --ignore-fail-on-non-empty --verbose "$where" 2> /dev/null || true
done

# Retired CIFS and SeaDrive credentials/configuration.
sudo rm --force --verbose \
  '/etc/cifs/credentials/DATA41.cred' \
  '/etc/credentials/DATA41.credentials'
rm --force --verbose "$HOME/.config/seadrive/seadrive.conf"
rmdir --ignore-fail-on-non-empty --verbose "$HOME/.config/seadrive" 2> /dev/null || true
