#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

systemctl --user --now enable pueued.service
