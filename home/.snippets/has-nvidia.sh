#!/bin/bash

function has-nvidia() {
  # ref: <https://github.com/CachyOS/chwd/blob/master/profiles/pci/graphic_drivers/profiles.toml>
  lspci -n -d '10de::' |
    awk '
      $2 ~ /^(0300|0302|0380):/ { found = 1 }
      END {
        if (found) {
          exit 0
        } else {
          exit 1
        }
      }
    '
}
