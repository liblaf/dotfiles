#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

brew uninstall gh

git config --global --unset-all "credential.https://github.com.helper"
git config --global --unset-all "credential.https://gist.github.com.helper"
