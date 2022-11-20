#!/usr/bin/bash

if [ -f "${HOME}/.local/opt/conda/etc/profile.d/conda.sh" ]; then
  source "${HOME}/.local/opt/conda/etc/profile.d/conda.sh"
  conda activate base
fi
