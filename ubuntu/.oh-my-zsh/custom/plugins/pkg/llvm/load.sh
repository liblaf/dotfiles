#!/usr/bin/bash

if command -v llvm-config > /dev/null 2>&1; then
  if [[ -d "$(llvm-config --libdir)" ]]; then
    export LD_LIBRARY_PATH="$(llvm-config --libdir):"
  fi
fi
