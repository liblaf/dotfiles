#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl enable --now fwupd-refresh.timer
