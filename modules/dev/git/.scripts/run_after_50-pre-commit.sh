#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

template_dir="$(git config init.templateDir)"
template_dir="${template_dir/#'~/'/"$HOME/"}"
pre-commit init-templatedir "$template_dir"
