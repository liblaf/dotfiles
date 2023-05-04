#!/usr/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

sudo snap refresh

sudo snap install --classic certbot
sudo snap install --classic chezmoi
