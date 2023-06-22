#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(realpath --canonicalize-missing "${0}/..")"
echo "$(hostname)" > .chezmoiroot
source "$(cat .chezmoiroot)/.chezmoitemplates/init.sh"

BIN="${HOME}/.local/bin"

run bash -c "$(curl -fsLS get.chezmoi.io)" -- -b "${BIN}"
run "${BIN}/chezmoi" init liblaf --apply
