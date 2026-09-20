#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly type="$1"
shift

case "$type" in
  'port')
    # ref: <file:///proc/sys/net/ipv4/ip_local_port_range>
    shuf --input-range='61000-65535' --head-count=1 "$@"
    ;;
  'uid')
    # ref: <file:///etc/login.defs>
    shuf --input-range='1000-60000' --head-count=1 "$@"
    ;;
  'gid')
    # ref: <file:///etc/login.defs>
    shuf --input-range='1000-60000' --head-count=1 "$@"
    ;;
  *)
    echo "Unknown type: $type" >&2
    exit 1
    ;;
esac
