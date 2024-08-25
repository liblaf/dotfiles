#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

~/.local/bin/cf dns install
