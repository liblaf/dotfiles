#!/bin/bash
# shellcheck disable=SC2317
set -o errexit
set -o nounset
set -o pipefail

# {{- if not .service.mlflow }}
exit
# {{- end }}

cd "$HOME/srv/mlflow"
docker compose up --detach --pull always
