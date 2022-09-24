#!/usr/bin/env zsh

export LESS='-R --use-color -Dd+R$-Du+G'

function color-table() {
  local csi="\x1b["
  local reset="${csi}0m"
  for mode in {0..9}; do
    for foreground in {30..37} 39; do
      for background in {40..47} 49; do
        echo -n "${csi}${mode}m${csi}${foreground}m${csi}${background}m${mode};${foreground};${background}\t${reset}"
      done
      echo
    done
    echo
  done
}
