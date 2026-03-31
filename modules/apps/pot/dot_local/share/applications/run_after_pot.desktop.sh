#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ? QUESTION: I don't know why, but this is needed to make screenshot work.
# ref: <https://github.com/flameshot-org/flameshot/issues/3769#issuecomment-2475921012>
expression='.["Desktop Entry"].Exec = "sh -c \"pot < /dev/null > /dev/null\""'
yq eval "$expression" '/usr/share/applications/pot.desktop' \
  --input-format 'ini' --output-format 'ini' > 'pot.desktop'
