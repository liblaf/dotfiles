#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# TODO: change to SeaDrive
remote=${remote:-"business:/archive"}
source=$(realpath -- "$1")

pushd -- "$source"
year=$(date +%Y)
date=$(date +%Y-%m-%d)
name=$(basename -- "$source")
target=$remote/$year/$date-$name
command rm --force -- "$source/b2sums.txt"
find "$source" -type f -printf "%P\n" |
  sort |
  xargs --delimiter="\n" --max-args="1" --no-run-if-empty -- b2sum > "$source/b2sums.txt"
task_id=$(pueue add --working-directory "$source" --print-task-id -- rclone sync --progress "$source" "$target")
pueue add --after "$task_id" -- rclone check "$source" "$target"
popd
