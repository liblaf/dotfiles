#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

template_dir="$(git config init.templateDir)"
prek util init-template-dir --hook-type pre-commit "$template_dir"
