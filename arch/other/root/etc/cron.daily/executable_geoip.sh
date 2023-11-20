#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm /var/lib/sing-box/geoip.db
systemctl restart sing-box.service
