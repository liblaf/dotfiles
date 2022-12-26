#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source scripts/init.sh

eval "${@}"
