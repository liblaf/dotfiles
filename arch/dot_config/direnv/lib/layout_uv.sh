#!/bin/bash
function layout_uv() {
  if [[ -f "uv.lock" ]]; then
    watch_file "uv.lock"
    if [[ ! -f ".venv/bin/activate" ]]; then
      uv sync --all-extras --all-groups
    fi
    # shellcheck disable=SC2016
    sd '^(\s*)?(?P<key>include-system-site-packages)(\s*)?=(\s*)?(?<val>.*)$' '$key = true' .venv/pyvenv.cfg
    # shellcheck disable=SC1091
    source .venv/bin/activate
  fi
}
