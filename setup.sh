#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(realpath --canonicalize-missing "${0}/..")"
nodename="$(uname --nodename)"
echo "${nodename}" > .chezmoiroot
source "${nodename}/.chezmoitemplates/init.sh"

if ! has chezmoi; then
  bin="${HOME}/.local/bin"
  install_script="$(mktemp --suffix=.sh)"
  trap "rm --verbose ${install_script}" EXIT
  wget --output-document="${install_script}" https://get.chezmoi.io
  bash "${install_script}" -b "${bin}"
  alias chezmoi="${bin}/chezmoi"
fi

chezmoi init liblaf --apply
