#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo udevadm control --reload
