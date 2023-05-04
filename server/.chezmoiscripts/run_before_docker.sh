#!/usr/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
get_docker="$(mktemp --suffix=.sh)"
curl -fsSL https://get.docker.com -o "${get_docker}"
sudo sh "${get_docker}"

sudo docker container run \
  --env DASHDOT_ENABLE_CPU_TEMPS="true" \
  --env DASHDOT_ALWAYS_SHOW_PERCENTAGES="true" \
  --detach \
  --interactive \
  --name dashdot \
  --privileged \
  --publish 3001:3001 \
  --restart on-failure \
  --tty \
  --volume /:/mnt/host:ro \
  mauricenino/dashdot
