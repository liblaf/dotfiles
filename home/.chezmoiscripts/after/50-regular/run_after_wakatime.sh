#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

codex plugin marketplace add 'wakatime/codex-cli-wakatime'
codex plugin add --marketplace 'wakatime' 'codex-cli-wakatime'
