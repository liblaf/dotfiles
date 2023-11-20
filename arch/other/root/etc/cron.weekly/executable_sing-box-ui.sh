#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --recursive /var/lib/sing-box/ui
systemctl restart sing-box.service
