#!/bin/bash
# shellcheck disable=SC2317
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl disable --now caddy.service || true

# {{- if not .service.caddy }}
docker compose down
exit
# {{- end }}

docker volume create "caddy-data"
docker compose up --detach --pull always
