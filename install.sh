#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

mkdir --parents --verbose './home/'
chezmoi init --apply
