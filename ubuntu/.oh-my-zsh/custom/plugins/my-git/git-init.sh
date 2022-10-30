#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function call() {
  rich --print "[bold bright_blue]+ ${*}"
  "${@}"
}

name="${1}"

call gh repo create "${name}" --clone --public --template template
call cd "${name}"
call pre-commit install --install-hooks
call bash "scripts/template.sh"
