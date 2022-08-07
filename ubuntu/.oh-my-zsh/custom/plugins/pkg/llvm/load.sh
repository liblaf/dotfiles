#!/usr/bin/bash

if [[ -d "$(llvm-config --libdir)" ]]; then
  export LD_LIBRARY_PATH="$(llvm-config --libdir):"
fi
