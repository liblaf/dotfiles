#!/bin/bash
set -o errexit -o nounset -o pipefail

sudo systemctl daemon-reload
systemctl --user daemon-reload
