#!/bin/bash
# shellcheck disable=SC2154
set -o errexit
set -o nounset
set -o pipefail

# @arg source="." <PATH>
# @option -f --format=".tar.xz"
# @option -h --hash="sha256"
# @option -r --remote="~/SeaDrive/My Libraries/archive"
# @meta version 0.0.0
# @meta author liblaf
# @meta require-tools ouch,rclone
function main() {
  argc_source=$(realpath -- "$argc_source")
  echo "source: $argc_source"
  echo "format: $argc_format"
  echo "  hash: $argc_hash"
  argc_remote=${argc_remote/#'~'/"$HOME"}
  echo "remote: $argc_remote"
  year=$(date +%Y)
  date=$(date +%Y-%m-%d)
  name=$(basename -- "$argc_source")
  cache=$HOME/.cache/rclone-archive
  remote=$argc_remote/$year/$date-$name
  sumfile_local=$cache/$date-$name/${argc_hash}sums.txt
  tar_local=$cache/$date-$name/$name$argc_format
  tar_remote=$remote/$name$argc_format
  mkdir --parents --verbose "$cache/$date-$name"
  rclone hashsum "$argc_hash" "$argc_source" --output-file "$sumfile_local" --exclude "*sums.txt"
  ouch compress "$argc_source" "$tar_local"
  rclone hashsum "$argc_hash" "$tar_local" --output-file "$tar_local.${argc_hash}"
  rclone copyto --progress "$sumfile_local" "$remote/$name/${argc_hash}sums.txt"
  rclone sync --progress "$argc_source" "$remote/$name"
  rclone copyto --progress "$tar_local.${argc_hash}" "$tar_remote.${argc_hash}"
  rclone copyto --progress "$tar_local" "$tar_remote"
}

eval "$(argc --argc-eval "$0" "$@")"
