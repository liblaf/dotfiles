#!/usr/bin/zsh

if command -v rclone > /dev/null 2>&1; then

  function drive() {
    local remote="drive:"
    local local="${HOME}/drive"
    env remote="${remote}" local="${local}" bash "${ZSH_CUSTOM}/plugins/rclone/drive.sh" "${@}"
  }

  function drive-p() {
    local remote="drive-p:"
    local local="${HOME}/drive-p"
    env remote="${remote}" local="${local}" bash "${ZSH_CUSTOM}/plugins/rclone/drive.sh" "${@}"
  }

fi
