#!/usr/bin/env bash
set -o errexit
set -o nounset

rootlesskit rm -rf ~/.local/share/docker
cd ~/bin
rm -f containerd containerd-shim containerd-shim-runc-v2 ctr docker docker-init docker-proxy dockerd dockerd-rootless-setuptool.sh dockerd-rootless.sh rootlesskit rootlesskit-docker-proxy runc vpnkit
