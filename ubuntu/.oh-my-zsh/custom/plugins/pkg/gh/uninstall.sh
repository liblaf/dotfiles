#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

call brew uninstall gh

call git config --global --unset-all "credential.https://github.com.helper"
call git config --global --unset-all "credential.https://gist.github.com.helper"
