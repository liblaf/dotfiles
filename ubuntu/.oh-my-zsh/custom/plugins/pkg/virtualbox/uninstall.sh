#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

sudo apt purge --auto-remove virtualbox-6.1
