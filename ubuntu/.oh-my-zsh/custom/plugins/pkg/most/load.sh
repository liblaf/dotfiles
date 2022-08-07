#!/usr/bin/env bash

if [[ -x "$(command -v most)" ]]; then
  export PAGER="$(command -v most)"
else
  echo "\"most\" not found"
fi
