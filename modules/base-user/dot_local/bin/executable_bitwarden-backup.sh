#!/bin/bash
# shellcheck disable=SC2154
set -o errexit
set -o nounset
set -o pipefail

# @option    --session $BW_SESSION
# @option    --session-file $BW_SESSION_FILE
# @option -d --dir="~/net/SeaDrive/My Libraries/archive/bitwarden/auto" $BW_BACKUP_DIR
# @meta version 0.0.0
# @meta author liblaf
# @meta require-tools bw
function main() {
  BW_SESSION="$(_get_session)"
  export BW_SESSION
  argc_dir=${argc_dir/#'~'/"$HOME"}
  echo "dir : $argc_dir"
  bw --nointeraction unlock --check
  bw --nointeraction sync
  latest_file=$(
    find "$argc_dir" -name "*.json" -type f |
      sort |
      tail --lines=1
  )
  time=$(date +"%Y-%m-%dT%H%M%S")
  tmp_file="/tmp/bitwarden-export.json"
  bw --nointeraction export --output "$tmp_file" --format json
  if diff --brief -- "$latest_file" "$tmp_file"; then
    echo "No changes detected"
    rm --force -- "$tmp_file"
  else
    mv --verbose -- "$tmp_file" "$argc_dir/bitwarden-export-$time.json"
  fi
}

function _get_session() {
  if [[ -n ${argc_session-} ]]; then
    echo "$argc_session"
  elif [[ -r ${argc_session_file-} ]]; then
    cat "$argc_session_file"
  elif [[ -n ${BW_SESSION-} ]]; then
    echo "$BW_SESSION"
  else
    echo "BW_SESSION not set" >&2
    exit 1
  fi
}

eval "$(argc --argc-eval "$0" "$@")"
