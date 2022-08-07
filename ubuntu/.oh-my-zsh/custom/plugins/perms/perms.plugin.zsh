#!/usr/bin/env bash

function reset-perms() {
  if [[ -n "${1}" && -d "${1}" ]]; then
    local prefix="${1}"
  else
    local prefix="$(pwd)"
  fi
  echo "Resetting perms under \"${prefix}\" ..."
  find "${prefix}" -type d |
    xargs --max-args=1 --max-procs=0 chmod u=rwx,go=rx
  find "${prefix}" -type f |
    xargs --max-args=1 --max-procs=0 chmod ug=rw,o=r
}
