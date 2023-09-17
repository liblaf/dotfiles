#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function check() {
  rclone config dump |
    dasel --read=json "$1.token" &> /dev/null
}

if check business; then
  echo -e "\x1b[1;92mOnedrive Business already configured\x1b[0m"
else
  if [[ -z ${BW_SESSION-} ]]; then
    echo -e "\x1b[1;91mBitwarden Locked\x1b[0m"
    exit 1
  else
    client_id=$(bw get username "Rclone Business")
    client_secret=$(bw get password "Rclone Business")
    notify-send --transient "Config Onedrive Business ..."
    rclone config create business onedrive client_id=$client_id client_secret=$client_secret
  fi
fi

if check personal; then
  echo -e "\x1b[1;92mOnedrive Personal already configured\x1b[0m"
else
  if [[ -z ${BW_SESSION-} ]]; then
    echo -e "\x1b[1;91mBitwarden Locked\x1b[0m"
    exit 1
  else
    client_id=$(bw get username "Rclone Personal")
    client_secret=$(bw get password "Rclone Personal")
    notify-send --transient "Config Onedrive Personal ..."
    rclone config create personal onedrive client_id=$client_id client_secret=$client_secret
  fi
fi
