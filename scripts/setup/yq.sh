#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

function ensure() {
  exe="$1"
  shift
  while (($# > 0)); do
    case "$1" in
      --apt=*)
        local apt="${1#*=}"
        shift
        ;;
      --pacman=*)
        local pacman="${1#*=}"
        shift
        ;;
      *)
        echo "Unknown option: $1" >&2
        return 1
        ;;
    esac
  done
  if ! has "$exe"; then
    if has apt; then
      sudo apt update
      sudo apt install -y "$apt"
    elif has pacman; then
      sudo pacman --sync --refresh --needed --noconfirm "$pacman"
    else
      echo "Error: Package manager not supported. Please install \`$exe\` manually." >&2
      return 1
    fi
  fi
}

ensure yq --pacman="yq"
