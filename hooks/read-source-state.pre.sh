#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# prevent recursion
if [[ -n ${DOTFILES_SKIP_READ_SOURCE_STATE_PRE:-} ]]; then exit; fi
export DOTFILES_SKIP_READ_SOURCE_STATE_PRE=1
if [[ $CHEZMOI_COMMAND == "execute-template" ]]; then exit; fi

function validate() {
  local newest_source
  newest_source="$(
    set +o pipefail # head closes the pipe early, so we need to disable pipefail here
    find "$CHEZMOI_WORKING_TREE"/{hooks,modules,profiles}/ -type f -printf '%T@\t%p\n' |
      sort --numeric-sort --reverse |
      head --lines=1 |
      cut --fields=2-
  )"
  [[ "$CHEZMOI_SOURCE_DIR/.touch" -nt $newest_source ]]
}

if validate; then exit; fi
rm --force --recursive "$CHEZMOI_SOURCE_DIR" >&2
mkdir --parents --verbose "$CHEZMOI_SOURCE_DIR" >&2
touch "$CHEZMOI_SOURCE_DIR/.touch"

PROFILE="${PROFILE:-"cachyos"}"
SCRIPTS_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
"$BASH" -- "$SCRIPTS_DIR/10-bootstrap.sh"
"$BASH" -- "$SCRIPTS_DIR/20-setup-bitwarden.sh"
"$BASH" -- "$SCRIPTS_DIR/30-gen-data/main.sh"
"$BASH" -- "$SCRIPTS_DIR/40-build/build.sh"
