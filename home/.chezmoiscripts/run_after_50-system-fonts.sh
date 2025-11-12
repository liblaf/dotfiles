#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo ln --force --symbolic --verbose --target-directory='/etc/fonts/conf.d' \
  '/usr/share/fontconfig/conf.avail/75-twemoji.conf'
fc-cache --force
