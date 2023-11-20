#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm /var/lib/sing-box/geosite.db
systemctl restart sing-box.service
