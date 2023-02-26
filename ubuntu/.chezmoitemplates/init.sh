#!/bin/bash

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

function run() {
  if exists gum; then
    local prefix="$(gum style --background=14 --padding="0 1" RUN)"
    local message="$(gum style --foreground=14 "${*}")"
    gum join --horizontal "${prefix}" " " "${message}"
  fi
  "${@}"
}
