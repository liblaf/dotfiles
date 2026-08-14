#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

codex plugin marketplace upgrade
