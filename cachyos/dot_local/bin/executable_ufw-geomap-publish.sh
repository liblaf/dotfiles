#!/usr/bin/env -S usage bash
#USAGE flag "-m --message <MESSAGE>" help="commit message" default="chore: update UFW GeoMap"
#USAGE flag "-r --repo <REPO>" help="URL of the repository you are pushing to" default="https://github.com/liblaf/ufw-geomap-pages.git"
# shellcheck shell=bash
set -o errexit
set -o nounset
set -o pipefail

: "${usage_message:?}"
: "${usage_repo:?}"

XDG_STATE_HOME="${XDG_STATE_HOME:-"$HOME/.local/state"}"
state_dir="$XDG_STATE_HOME/liblaf/kiwi/ufw-geomap"
dist_dir="$state_dir/dist"

mapfile -t log_files < <(find "$state_dir/log" -name "*.log.jsonl" || true)
kiwi ufw-geomap --output-html="$dist_dir/index.html" "${log_files[@]}"

CACHE_DIR="$(mktemp --directory)"
export CACHE_DIR # ref: <https://github.com/tschaub/gh-pages/issues/354#issuecomment-879929437>
trap 'rm --recursive --force "$CACHE_DIR"' EXIT
gh-pages --dist "$dist_dir" --message "$usage_message" --nojekyll --repo "$usage_repo" --no-history
