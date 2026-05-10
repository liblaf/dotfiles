#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://pot-app.com/docs/invoke.html>

xh GET 'http://127.0.0.1:60828/translate'
