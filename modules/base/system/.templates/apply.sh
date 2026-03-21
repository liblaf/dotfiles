#!/bin/bash

function apply-root() {
  function prepend_exact() {
    awk -F'/' '{
			for (i = 1; i < NF; i++) {
				printf "/exact_%s", $i
			}
			printf "/%s\n", $NF
		}' <<< "$1"
  }

  local source="$1"
  local target="$2"
  local source_abs
  source_abs="$(prepend_exact "$source")"
  source_abs="$CHEZMOI_SOURCE_DIR/dot_cache/exact_dotfiles/exact_root/$source_abs"
  if [[ $source == *.tmpl ]]; then
    tmpfile="$(mktemp)"
    "$CHEZMOI_EXECUTABLE" execute-template "$source_abs" --file --output "$tmpfile"
    sudo install -D --mode='u=rw,go=r' --no-target-directory "$tmpfile" "$target"
    echo "'^$source' (template) -> '$target'" 1>&2
    rm --force "$tmpfile"
  else
    sudo cp --archive --force --no-preserve='ownership' "$source_abs" "$target"
    echo "'^$source' -> '$target'" 1>&2
  fi
}

function apply-home() {
  local source="$1"
  local target="$2"
  local source_abs="$CHEZMOI_SOURCE_DIR/$source"
  if [[ $source == *.tmpl ]]; then
    "$CHEZMOI_EXECUTABLE" execute-template "$source_abs" --file --output "$target"
    echo "'$source' (template) -> '$target'" 1>&2
  else
    cp --archive --force "$source_abs" "$target"
    echo "'$source' -> '$target'" 1>&2
  fi
}
