#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readarray -t device_options < <(
  lsblk --json |
    yq eval '.blockdevices[] | select(.type == "disk") | .name'
)
device_options=("${device_options[@]/#/"/dev/"}")
DEVICE=$(gum choose "${device_options[@]}" --header "Choose DEVICE")
printf "Ventoy Disk: %s\n" "$DEVICE"

readarray -t mountpoint_options < <(
  lsblk --json | yq eval '.blockdevices[].children[].mountpoints[]'
)
MOUNTPOINT=$(gum choose "${mountpoint_options[@]}" --header "Choose MOUNTPOINT")
printf "Ventoy Mountpoint: %s\n" "$MOUNTPOINT"

xdg-open "https://www.microsoft.com/en-us/software-download/windows11"
WINDOWS_DOWNLOAD_URL=$(gum input --placeholder="Windows Download Link" --char-limit=1000)
printf "Windows Download Link: %s\n" "$WINDOWS_DOWNLOAD_URL"

WINDOWS_ISO_SHA256=$(gum input --placeholder="Windows ISO SHA256")
printf "Windows ISO SHA256: %s\n" "$WINDOWS_ISO_SHA256"

cat <<- EOF > ".env"
DEVICE="$DEVICE"
MOUNTPOINT="$MOUNTPOINT"
WINDOWS_DOWNLOAD_URL="$WINDOWS_DOWNLOAD_URL"
WINDOWS_ISO_SHA256="$WINDOWS_ISO_SHA256"
EOF
