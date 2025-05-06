#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://thu.services/services/#networkmanager>
# This workaround is no longer needed.
# nmcli connection modify "Tsinghua-Secure" 802-1x.phase1-auth-flags tls-1-0-enable
