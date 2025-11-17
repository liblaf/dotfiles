#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ANSI Select Graphic Rendition (SGR)
RESET=$'\e[0m'
FAINT=$'\e[2m'
BOLD_BRIGHT_YELLOW=$'\e[1;93m'

function is-binary() {
  local file="$1"
  local size
  size="$(stat --format='%s' -- "$file")"
  if ((size == 0)); then
    return 1
  fi
  local encoding
  encoding="$(file --brief --mime-encoding -- "$file")"
  if [[ $encoding == 'binary' ]]; then
    return 0
  else
    return 1
  fi
}

function is-generated() {
  local file="$1"
  if [[ $file =~ template/** ]]; then
    return 1
  elif [[ $file == *.lock || $file == "go.sum" || $file == ".cspell.json" ]]; then
    return 0
  elif head --lines="5" -- "$file" | grep --quiet "@generated"; then
    return 0
  else
    return 1
  fi
}

function is-large() {
  local file="$1"
  local size
  size="$(stat --format='%s' -- "$file")"
  if ((size > 1048576)); then # 1 MiB
    return 0
  else
    return 1
  fi
}

function is-git-lfs() {
  local path="$1"
  # TODO: check git-lfs attributes
  return 1
}

function diff-meta() {
  local lang="$1"
  echo "${BOLD_BRIGHT_YELLOW}${path}${RESET}${FAINT} --- ${lang}${RESET}"
  if [[ $path != "$new_file" ]]; then
    echo "${FAINT}Renamed from ${path} to ${new_file}${RESET}"
  fi
  if [[ $old_mode != "$new_mode" ]]; then
    echo "${FAINT}File permissions changed from ${old_mode} to ${new_mode}.${RESET}"
  fi
}

function diff-binary() {
  diff-meta 'Binary'
  if [[ $old_hex != "$new_hex" ]]; then
    echo "Binary contents changed."
  else
    echo "No changes."
  fi
}

function diff-generated() {
  diff-meta 'Generated'
  if [[ $old_hex != "$new_hex" ]]; then
    echo "Generated contents changed."
  else
    echo "No changes."
  fi
}

function diff-large() {
  diff-meta 'Large'
  if [[ $old_hex != "$new_hex" ]]; then
    echo "Large contents changed."
  else
    echo "No changes."
  fi
}

function diff-internal() {
  git --no-pager diff --no-ext-diff --no-index "$old_file" "$new_file" || true
}

# ref: <https://git-scm.com/docs/git#Documentation/git.txt-codeGITEXTERNALDIFFcode>
path="$1"
old_file="$2"
old_hex="$3"
old_mode="$4"
new_file="$5"
new_hex="$6"
new_mode="$7"

if is-binary "$old_file" || is-binary "$new_file"; then
  diff-binary
elif is-generated "$new_file"; then
  diff-generated
elif is-large "$old_file" || is-large "$new_file"; then
  diff-large
elif is-git-lfs "$old_file" || is-git-lfs "$new_file"; then
  diff-binary
else
  exec difft "$@"
fi
