#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_tools=(
  dvc
)

declare -A installed_tools=()
while read -r tool; do
  installed_tools["$tool"]=true
done < <(
  uv tool list |
    awk '!/^-/ { print $1 }'
)

tools_to_uninstall=()
for tool in "${legacy_tools[@]}"; do
  if [[ -n ${installed_tools["$tool"]:-} ]]; then
    tools_to_uninstall+=("$tool")
  fi
done

if ((${#tools_to_uninstall[@]} > 0)); then
  uv tool uninstall "${tools_to_uninstall[@]}"
fi
