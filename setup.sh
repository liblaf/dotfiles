#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(realpath --canonicalize-missing "${0}/..")"
source "$(cat .chezmoiroot)/.chezmoitemplates/init.sh"

BIN="${HOME}/.local/bin"

run sudo apt install curl
run bash -c "$(curl -fsLS get.chezmoi.io)" -- -b "${BIN}"
run "${BIN}/chezmoi" apply --source "$(pwd)"
