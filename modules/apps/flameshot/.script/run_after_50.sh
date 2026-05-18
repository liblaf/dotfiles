#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://flameshot.org/docs/guide/wayland-help/#unable-to-capture-screen-error>
flatpak permission-set screenshot screenshot org.flameshot.Flameshot yes
