#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function prompt-device() {
  if [[ -n ${DEVICE-} ]]; then
    return
  fi
  readarray -t device_options < <(
    lsblk --json |
      yq eval '.blockdevices[] | select(.type == "disk") | .name'
  )
  device_options=("${device_options[@]/#/'/dev/'}")
  DEVICE="$(gum choose "${device_options[@]}" --header 'Choose DEVICE')"
}

function prompt-mountpoint() {
  if [[ -n ${MOUNTPOINT-} ]]; then
    return
  fi
  readarray -t mountpoint_options < <(
    lsblk --json | yq eval '.blockdevices[].children[].mountpoints[]'
  )
  MOUNTPOINT="$(gum choose "${mountpoint_options[@]}" --header 'Choose MOUNTPOINT')"
}
