#!/usr/bin/env zsh

function reset-perms() {
  if [[ -n "${1}" && -d "${1}" ]]; then
    local prefix="${1}"
  else
    local prefix="$(pwd)"
  fi
  local default_d_perms="$(umask -S)"
  local default_perms="$(echo "${default_d_perms}" | tr --delete 'x')"
  echo "Resetting perms under \"${prefix}\" to ${default_perms} ..."
  find "${prefix}" -type d |
    xargs --max-args=1 --max-procs=0 --no-run-if-empty chmod "${default_d_perms}"
  find "${prefix}" -type f |
    xargs --max-args=1 --max-procs=0 --no-run-if-empty chmod "${default_perms}"
}
