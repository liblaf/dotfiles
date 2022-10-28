#!/usr/bin/bash
set -o errexit
set -o nounset

mkdir --parents "${HOME}/.local/bin"
ln --force --symbolic "${HOME}/Android/Sdk/platform-tools/adb" "${HOME}/.local/bin/adb"
