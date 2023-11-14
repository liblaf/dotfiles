#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function check() {
  rclone config dump |
    dasel --read=json "$1.token" &>/dev/null
}

if check business; then
  echo "$(tput bold)$(tput setaf 10)Onedrive Business already configured$(tput sgr0)"
else
  bw unlock --check
  client_id=$(bw get username "Rclone Business")
  client_secret=$(bw get password "Rclone Business")
  notify-send --transient "Config Onedrive Business ..."
  rclone config create business onedrive client_id=$client_id client_secret=$client_secret
fi

if check personal; then
  echo "$(tput bold)$(tput setaf 10)Onedrive Personal already configured$(tput sgr0)"
else
  bw unlock --check
  client_id=$(bw get username "Rclone Personal")
  client_secret=$(bw get password "Rclone Personal")
  notify-send --transient "Config Onedrive Personal ..."
  rclone config create personal onedrive client_id=$client_id client_secret=$client_secret
fi
