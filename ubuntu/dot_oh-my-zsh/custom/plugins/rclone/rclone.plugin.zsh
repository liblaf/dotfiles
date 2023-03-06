#!/usr/bin/zsh

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

if exists rclone; then

  function dp() {
    local remote="drive-personal:"
    local local="${HOME}/Desktop/drive-personal"
    env remote="${remote}" local="${local}" bash "${ZSH_CUSTOM}/plugins/rclone/drive.sh" "${@}"
  }

  function db() {
    local remote="drive-business:"
    local local="${HOME}/Desktop/drive-business"
    env remote="${remote}" local="${local}" bash "${ZSH_CUSTOM}/plugins/rclone/drive.sh" "${@}"
  }

fi

unset -f exists
