#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readarray -t device_options < <(
  lsblk --json |
    yq eval '.blockdevices[] | select(.type == "disk" and .rm) | .name'
)
device_options=("${device_options[@]/#/"/dev/"}")
DISK=$(gum choose "${device_options[@]}" --header "Choose DISK")
printf "Ventoy Disk: %s\n" "$DISK"

readarray -t mountpoint_options < <(
  df --output="target" --type="exfat" |
    tail --lines="+2"
)
MOUNTPOINT=$(gum choose "${mountpoint_options[@]}" --header "Choose MOUNTPOINT")
printf "Ventoy Mountpoint: %s\n" "$MOUNTPOINT"

xdg-open "https://www.microsoft.com/en-us/software-download/windows11"
WINDOWS_DOWNLOAD_URL=$(gum input --placeholder="Windows Download Link" --char-limit=1000)
printf "Windows Download Link: %s\n" "$WINDOWS_DOWNLOAD_URL"

WINDOWS_ISO_SHA256=$(gum input --placeholder="Windows ISO SHA256")
printf "Windows ISO SHA256: %s\n" "$WINDOWS_ISO_SHA256"

cat <<- EOF > ".env"
DISK="$DISK"
MOUNTPOINT="$MOUNTPOINT"
WINDOWS_DOWNLOAD_URL="$WINDOWS_DOWNLOAD_URL"
WINDOWS_ISO_SHA256="$WINDOWS_ISO_SHA256"
EOF
