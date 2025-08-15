#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl enable --now sshd.service
# ref: <https://wiki.archlinux.org/title/GNOME/Keyring#Setup_gcr>
systemctl --user enable --now gcr-ssh-agent.socket
