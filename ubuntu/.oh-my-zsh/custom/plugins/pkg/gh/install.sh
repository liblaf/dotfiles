#!/usr/bin/env bash
set -o errexit
set -o nounset

brew install gh

gh auth login
gh auth setup-git
