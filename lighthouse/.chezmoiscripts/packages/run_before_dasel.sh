#!/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

mkdir --parents --verbose "${HOME}/.local/bin"
wget --output-document="${HOME}/.local/bin/dasel" https://github.com/TomWright/dasel/releases/latest/download/dasel_linux_amd64
chmod u=rwx,go=rx "${HOME}/.local/bin/dasel"
