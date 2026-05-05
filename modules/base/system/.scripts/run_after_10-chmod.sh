#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo chmod 'ug=r,o=' '/etc/sudoers.d/99_liblaf'
