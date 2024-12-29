#!/bin/bash
function layout_pixi() {
  if [[ -f "pixi.lock" ]]; then
    watch_file "pixi.lock"
    eval "$(pixi shell-hook)"
  fi
}
