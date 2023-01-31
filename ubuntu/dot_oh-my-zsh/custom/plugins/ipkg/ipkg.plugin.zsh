#!/usr/bin/zsh

function ipkg() {
  local sha1="$(sha1sum <<< "${*}" | awk '{ print $1 }')"
  local cache_path="${IPKG_CACHE_DIR:-"${HOME}/.cache/ipkg"}/${sha1}"
  if [[ -f ${cache_path} ]]; then
    local cache_hit=true
  fi
  if [[ ${cache_hit:-"false"} != "true" ]]; then
    command ipkg "${@}"
  fi
  if [[ -f ${cache_path} ]]; then
    source "${cache_path}"
  fi
}

for pkg in "${ipkg_loads[@]}"; do
  ipkg load "${pkg}"
done
