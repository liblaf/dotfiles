#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo chmod --verbose "u=rw,g=r,o=" /etc/ufw/*.rules
sudo ufw --force reset
sudo find /etc/ufw -regextype gnu-awk -regex ".*.[[:digit:]]{8}_[[:digit:]]{6}" -delete
sudo ufw default deny
sudo ufw allow from 172.16.0.0/12
sudo ufw allow 32768:60999/tcp
sudo ufw allow 32768:60999/udp
sudo ufw --force enable
sudo systemctl enable --now ufw.service
