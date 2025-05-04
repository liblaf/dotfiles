#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

function ensure() {
  OPTIONS="$(getopt --long "pacman:" --name "ensure" --options "" -- "$@")"
  eval set -- "$OPTIONS"
  while true; do
    case "$1" in
      --pacman)
        local pacman="$2"
        shift 2
        ;;
      --)
        shift
        break
        ;;
      *)
        echo "Unknown option: $1" >&2
        exit 1
        ;;
    esac
  done
  local exe="$1"
  shift
  if has "$exe"; then
    echo "\`$exe\` is already installed." >&2
  else
    if has pacman; then
      sudo pacman --sync --refresh --needed --noconfirm "$pacman"
    else
      echo "Error: Package manager not supported. Please install \`$pacman\` manually." >&2
      return 1
    fi
  fi
}

ensure rbw --pacman="rbw"
ensure yq --pacman="go-yq"
