#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function main() {
  local file names count
  file="$(realpath --canonicalize-existing --no-symlinks -- "$1")"
  local -r name="${file/#"$HOME/"/'~/'}"
  names="$(rbw search --folder 'Dotfiles' -- "$name")"
  count="$(grep --fixed-strings --line-regexp --count --regexp="$name" <<< "$names")" ||
    [[ $? -eq 1 ]]

  case $count in
    0) rbw add --folder 'Dotfiles' --secure-note --no-edit --notes-file "$file" -- "$name" ;;
    1) rbw edit --folder 'Dotfiles' --notes-file "$file" -- "$name" ;;
    *)
      printf "couldn't find entry for '%s': multiple entries found\n" "$name" >&2
      return 1
      ;;
  esac
}

main "$@"
