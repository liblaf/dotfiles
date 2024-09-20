#!/bin/bash
set -o errexit -o nounset -o pipefail

function parser_definition() {
  setup REST help:usage -- "Usage: $0 [options]... [arguments]..." ''
  msg -- 'Options:'
  param FORMAT -f --format init:=".tar.xz"
  param HASH -h --hash init:="sha256"
  param REMOTE -r --remote init:="$HOME/SeaDrive/My Libraries/archive"
  disp :usage --help
}

eval "$(getoptions parser_definition) exit 1"
SOURCE=$(realpath -- "$1")

pushd -- "$SOURCE"
year=$(date +%Y)
date=$(date +%Y-%m-%d)
name=$(basename -- "$SOURCE")
sumfile=$SOURCE/${HASH}sums.txt
target=$REMOTE/$year/$date-$name
archive=$target/$name$FORMAT
rclone hashsum "$HASH" "$SOURCE" --output-file "$sumfile" --exclude "*sums.txt"
rclone sync --progress "$SOURCE" "$target/$name"
ouch compress "$SOURCE" "$archive"
rclone hashsum "$HASH" "$archive" --output-file "$archive.${HASH}"
popd
