#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rustup default stable
rustup update
