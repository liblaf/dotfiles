#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

call brew install gh

call gh auth login
call gh auth setup-git

call gh extension install dlvhdr/gh-dash
