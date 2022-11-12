#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

# Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:
call sudo apt purge docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Images, containers, volumes, or custom configuration files on your host
# aren't automatically removed. To delete all images, containers, and volumes:
call sudo rm --force --recursive /var/lib/docker
call sudo rm --force --recursive /var/lib/containerd

# You must delete any edited configuration files manually.
tip "You must delete any edited configuration files manually."
