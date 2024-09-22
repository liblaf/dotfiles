#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

root=$HOME/.cache/dotfiles/root/
readarray -t root_files < <(find "$root" -type f -printf "%P\n")
tmpdir=$(mktemp --directory)
trap 'rm --force --recursive "$tmpdir"' EXIT
for file in "${root_files[@]}"; do
  source=$root/$file
  target=/$file
  case "$target" in
    /etc/sudoers.d/*) mode="ug=r,o=" ;;
    *) mode="u=rw,go=r" ;;
  esac
  sudo install -D --mode="$mode" --no-target-directory --verbose "$source" "$target"
done
