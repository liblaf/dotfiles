#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://wiki.archlinux.org/title/Systemd/User#Automatic_start-up_of_systemd_user_instances>
loginctl enable-linger "$USER"
