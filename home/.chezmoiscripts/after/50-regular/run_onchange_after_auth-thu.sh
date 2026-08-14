#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

systemctl --user --now disable goauthing6.service
systemctl --user --now enable goauthing.service
