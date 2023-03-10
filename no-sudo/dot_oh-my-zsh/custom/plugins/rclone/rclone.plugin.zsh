#!/usr/bin/zsh

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

if exists rclone; then

  function dp() {
    local remote="onedrive-personal:"
    local local="${HOME}/Desktop/onedrive-personal"
    env remote="${remote}" local="${local}" bash "${ZSH_CUSTOM}/plugins/rclone/drive.sh" "${@}"
  }

  function db() {
    local remote="onedrive-business:"
    local local="${HOME}/Desktop/onedrive-business"
    env remote="${remote}" local="${local}" bash "${ZSH_CUSTOM}/plugins/rclone/drive.sh" "${@}"
  }

fi

unset -f exists
