#!/usr/bin/env bash

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

function color-makefile() {
  cat <<-EOF | tee --append Makefile >"/dev/null"
ERROR   := \$(shell tput bold)\$(shell tput setaf 1)
SUCCESS := \$(shell tput bold)\$(shell tput setaf 2)
WARNING := \$(shell tput bold)\$(shell tput setaf 3)
INFO    := \$(shell tput bold)\$(shell tput setaf 4)
RESET   := \$(shell tput init)
EOF
}
