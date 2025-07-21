#!/bin/bash
#MISE depends=["build"]
set -o errexit
set -o nounset
set -o pipefail

chezmoi apply
