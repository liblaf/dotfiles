#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function check() {
  rclone config dump |
    dasel --read=json "${1}.token" &> /dev/null
}

if check onedrive-business; then
  echo -e "\x1b[1;92mOnedrive Business Already Configured\x1b[0m"
else
  if [[ -z ${BW_SESSION:-""} ]]; then
    echo -e "\x1b[1;91mBitwarden Locked\x1b[0m"
    exit 1
  else
    client_id="$(bw get username Rclone)"
    client_secret="$(bw get password Rclone)"
    notify-send --transient "Config Onedrive Business ..."
    rclone config create onedrive-business onedrive client_id="${client_id}" client_secret="${client_secret}"
  fi
fi

if check onedrive-personal; then
  echo -e "\x1b[1;92mOnedrive Personal Already Configured\x1b[0m"
else
  if [[ -z ${BW_SESSION:-""} ]]; then
    echo -e "\x1b[1;91mBitwarden Locked\x1b[0m"
    exit 1
  else
    client_id="$(bw get username Rclone)"
    client_secret="$(bw get password Rclone)"
    notify-send --transient "Config Onedrive Personal ..."
    rclone config create onedrive-personal onedrive client_id="${client_id}" client_secret="${client_secret}"
  fi
fi
