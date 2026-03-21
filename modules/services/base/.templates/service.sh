#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function service-user-add() {
  local login="$1"
  local uid="$2"
  local comment="$3"
  sudo groupadd --gid '{{ .services.gid }}' --users "$USER" 'srv' || true
  sudo useradd --comment "$comment" --groups 'srv' --no-create-home \
    --shell /usr/bin/nologin --uid "$uid" "$login" || true
}
