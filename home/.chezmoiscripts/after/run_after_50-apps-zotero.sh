#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ! -f "$HOME/.zotero/zotero/profiles.ini" ]]; then exit; fi

profile_name="$(yq '.Profile0.Path' "$HOME/.zotero/zotero/profiles.ini")"
readonly profile_name
readonly profile_path="$HOME/.zotero/zotero/$profile_name"

mkdir --parents --verbose "$profile_path/extensions/"
cp --archive --no-target-directory --update --verbose \
  "$HOME/.cache/dotfiles/external/zotero-addons.xpi" \
  "$profile_path/extensions/zoteroAddons@ytshen.com.xpi"
