#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://github.com/flameshot-org/flameshot/issues/3769#issuecomment-2475921012>
expression='.["Desktop Entry"].Exec = "sh -c \"flameshot < /dev/null\""'
yq eval "$expression" '/usr/share/applications/org.flameshot.Flameshot.desktop' \
  --input-format 'ini' --output-format 'ini' > 'org.flameshot.Flameshot.desktop'
