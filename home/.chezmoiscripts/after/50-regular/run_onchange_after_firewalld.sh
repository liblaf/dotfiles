#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl --now enable firewalld.service

if type ufw &> /dev/null; then
  sudo systemctl --now disable ufw.service
  sudo ufw disable
fi
