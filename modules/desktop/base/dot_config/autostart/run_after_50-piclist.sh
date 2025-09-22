#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cp --archive --force --target-directory='.' '/usr/share/applications/piclist.desktop'
