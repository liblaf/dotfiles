#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

yay --yay --clean --nosave --recursive --unneeded --noconfirm
