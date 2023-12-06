#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo chmod --verbose "u=rw,g=r,o=" /etc/ufw/*.rules
sudo ufw --force reset
sudo find /etc/ufw -regextype gnu-awk -regex ".*.[[:digit:]]{8}_[[:digit:]]{6}" -delete
sudo ufw default deny
sudo ufw allow 32768:65535/tcp
sudo ufw --force enable
