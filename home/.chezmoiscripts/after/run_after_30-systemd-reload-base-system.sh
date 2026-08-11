#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl daemon-reload
systemctl --user daemon-reload
