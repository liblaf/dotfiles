#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

systemctl --user enable --now journalctl-desktop-notification.service
