#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://github.com/flameshot-org/flameshot/issues/3769#issuecomment-2475921012>
sd '^Exec\s*=\s*/usr/bin/flameshot' 'Exec = sh -c "flameshot < /dev/null"' \
  < /usr/share/applications/org.flameshot.Flameshot.desktop \
  > flameshot.desktop
