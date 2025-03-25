#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

BW_SESSION_FILE="${BW_SESSION_FILE:-"$HOME/.config/credstore/BW_SESSION"}"

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

ensure bw --pacman="bitwarden-cli"
ensure rbw --pacman="rbw"

if [[ -z ${BW_SESSION-} ]]; then
  if [[ -r $BW_SESSION_FILE ]]; then
    BW_SESSION=$(< "$BW_SESSION_FILE")
    export BW_SESSION
  fi
fi
if ! bw login --check; then
  BW_SESSION=$(bw login --raw)
  export BW_SESSION
fi
if ! bw unlock --check; then
  BW_SESSION=$(bw --raw unlock)
  export BW_SESSION
  bw unlock --check
fi
mkdir --parents --verbose "$(dirname -- "$BW_SESSION_FILE")"
echo "$BW_SESSION" > "$BW_SESSION_FILE"

if [[ ! -f "$HOME/.config/rbw/config.json" ]]; then
  rbw config set email "no-reply.liblaf@outlook.com"
  rbw config set lock_timeout 604800
fi
rbw login
rbw sync
