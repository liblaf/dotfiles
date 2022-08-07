#!/usr/bin/env bash

if [[ -x "$(command -v most)" ]]; then
  export PAGER="$(command -v most)"
fi
