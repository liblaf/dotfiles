#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname -- "$0")"

mkdir --parents --verbose basic-auth
mkdir --parents --verbose mlartifacts
mkdir --parents --verbose mlruns
