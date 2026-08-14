#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo fwupdmgr update --assume-yes || true
