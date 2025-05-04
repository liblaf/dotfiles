#!/bin/bash
# shellcheck disable=SC2317
set -o errexit
set -o nounset
set -o pipefail

# {{- if not .service.caddy }}
sudo systemctl disable --now caddy.service || true
exit
# {{- end }}

sudo systemctl enable --now caddy.service
