#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(realpath --canonicalize-missing "${0}/..")"
echo "$(uname --nodename)" > .chezmoiroot
source "$(cat .chezmoiroot)/.chezmoitemplates/init.sh"

BIN="${HOME}/.local/bin"

bash -c "$(curl -fsLS get.chezmoi.io)" -- -b "${BIN}"
"${BIN}/chezmoi" init liblaf --apply

echo None > .chezmoiignore
