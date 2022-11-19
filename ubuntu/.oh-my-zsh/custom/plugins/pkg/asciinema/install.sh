#!/usr/bin/sh
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

brew install asciinema

agg_version="${agg_version:-"v1.3.0"}"
filename="agg"
filepath="${HOME}/.local/bin/${filename}"
download "https://github.com/asciinema/agg/releases/download/${agg_version}/agg-x86_64-unknown-linux-gnu" "${filepath}"
chmod +x "${filepath}"
