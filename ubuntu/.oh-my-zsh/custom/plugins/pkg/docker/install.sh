#!/usr/bin/env bash
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script

source "${PKG_HOME}/utility.sh"

filename="get-docker.sh"
filepath="${HOME}/Downloads/${filename}"
download "https://get.docker.com" "${filepath}"
call sudo bash "${filepath}"

call sudo apt install uidmap
call dockerd-rootless-setuptool.sh install
