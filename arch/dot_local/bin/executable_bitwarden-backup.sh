#!/bin/bash
# shellcheck disable=SC2154
set -o errexit
set -o nounset
set -o pipefail

# @option -d --dir="~/SeaDrive/My Libraries/archive/bitwarden"
# @meta version 0.0.0
# @meta author liblaf
function main() {
  argc_dir=${argc_dir/#'~'/"$HOME"}
  echo "output : $argc_dir"
  latest_file=$(
    find "$argc_dir" -name "*.json" -type f |
      sort |
      tail --lines=1
  )
  time=$(date +"%Y-%m-%dT%H%M%S")
  tmp_file="/tmp/bitwarden-export.json"
  bw --nointeraction export --output "$tmp_file" --format json
  if diff -- "$latest_file" "$tmp_file"; then
    echo "No changes detected"
    rm --force -- "$tmp_file"
  else
    mv --verbose -- "$tmp_file" "$argc_dir/bitwarden-export-$time.json"
  fi
}

eval "$(argc --argc-eval "$0" "$@")"
