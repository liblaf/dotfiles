#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_packages=(
  dotenv-vault
)

readarray -t packages_to_remove < <(
  comm -1 -2 \
    <(printf '%s\n' "${legacy_packages[@]}" | sort) \
    <(
      (bun pm ls --global || true) |
        awk '
        {
          gsub(/\x1b\[[0-9;]*m/, "")  # strip ANSI codes
        }
        /[├└]── / {
          line = $2
          sub(/@[^@]+$/, "", line)  # remove trailing @version
          print line
        }' | sort
    )
)

for pkg in "${legacy_packages[@]}"; do
  if [[ " ${packages_to_remove[*]} " == *" $pkg "* ]]; then
    bun remove --global "$pkg"
  fi
done
