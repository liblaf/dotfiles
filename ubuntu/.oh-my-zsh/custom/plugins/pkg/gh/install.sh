#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

brew install gh

gh auth login
gh auth setup-git

gh extension install dlvhdr/gh-dash
