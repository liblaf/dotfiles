#!/bin/bash
set -o errexit -o nounset -o pipefail

~/.local/bin/cf dns install
