#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rbw get --clipboard 'SSH'
ssh-keygen -y -f "$HOME/.ssh/id_ed25519" > "$HOME/.ssh/id_ed25519.pub"
