#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# prevent recursion
if [[ -n ${DOTFILES_SKIP_READ_SOURCE_STATE_PRE:-} ]]; then exit; fi
export DOTFILES_SKIP_READ_SOURCE_STATE_PRE=1

if [[ $CHEZMOI_COMMAND == "execute-template" ]]; then exit; fi
if [[ -d $CHEZMOI_SOURCE_DIR ]]; then exit; fi

PROFILE="${PROFILE:-"cachyos"}"
SCRIPTS_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
"$BASH" -- "$SCRIPTS_DIR/10-install-packages.sh"
"$BASH" -- "$SCRIPTS_DIR/20-setup-bitwarden.sh"
rm --force --recursive "$CHEZMOI_SOURCE_DIR"
"$BASH" -- "$SCRIPTS_DIR/30-gen-data/main.sh"
"$BASH" -- "$SCRIPTS_DIR/40-build/build.sh"
