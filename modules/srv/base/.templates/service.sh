#!/bin/bash

function service-user-add() {
  local login="$1"
  local uid="$2"
  local comment="$3"
  shift 3

  if getent group 'srv' &> /dev/null; then
    local gid_old
    gid_old="$(
      getent group 'srv' |
        cut --delimiter=':' --fields='3'
    )"
    local gid='{{ .services.gid }}'
    if ((gid_old != gid)); then
      sudo groupmod --gid "$gid" 'srv'
    fi
  else
    sudo groupadd --gid "$gid" --users "$USER" 'srv'
  fi

  if getent passwd "$login" &> /dev/null; then
    local uid_old
    uid_old="$(
      getent passwd "$login" |
        cut --delimiter=':' --fields='3'
    )"
    if ((uid_old != uid)); then
      sudo usermod --comment "$comment" --groups 'srv' \
        --shell '/usr/bin/nologin' --uid "$uid" "$login"
      # for root in "$@"; do
      #   if [[ ! -e $root ]]; then continue; fi
      #   chown --verbose --no-dereference --from="$uid_old" --recursive \
      #     "$login:srv" "$root"
      # done
    fi
  else
    sudo useradd --comment "$comment" --groups 'srv' --no-create-home \
      --no-user-group --shell '/usr/bin/nologin' --uid "$uid" "$login"
  fi
}
