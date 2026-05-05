#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo chmod 'u=rwx,go=rx' '/usr/local/bin/arch-rate-mirrors.sh'
