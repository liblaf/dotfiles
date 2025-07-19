#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

OUTPUT="$CHEZMOI_SOURCE_DIR/.chezmoidata/generated.yaml"
if [[ -f $OUTPUT ]]; then exit; fi

function gen-data() {
  echo "a.b = c"
}

function main() {
  gen-data |
    yq eval --input-format "props" --output-format "yaml" > "$OUTPUT"
}

main
