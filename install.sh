#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

WORKING_TREE=$(chezmoi dump-config | yq ".workingTree")
pushd "$WORKING_TREE" > /dev/null

bash "scripts/modules.sh" "profiles/PC05.yaml"
chezmoi apply --source "$WORKING_TREE/home"
