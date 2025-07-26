#!/bin/bash

function gen-packages() {
  local output="$TMPDIR/packages.yaml"
  mkdir --parents "$(dirname -- "$output")"
  cp --archive "$CHEZMOI_WORKING_TREE/assets/packages.yaml" "$output"
  for file in "$CHEZMOI_SOURCE_DIR"/.packages/*; do
    case "$file" in
      *.yaml) ;;
      *.yaml.tmpl)
        template "$file" --file --output "$TMPDIR/packages.module.yaml"
        file="$TMPDIR/packages.module.yaml"
        ;;
    esac
    yq eval ". *+ (load(\"$file\") | (.. | select(. == null)) |= [])" "$output" --inplace
  done
  yq eval '{ "packages": . }' "$output" --inplace
  mkdir --parents "$CHEZMOI_SOURCE_DIR/.chezmoidata"
  cp --archive "$output" "$CHEZMOI_SOURCE_DIR/.chezmoidata/packages.yaml"
}
