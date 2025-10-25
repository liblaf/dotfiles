#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

email_new='veto-dimly-corsage@duck.com'
email_old="$(rbw config show | yq '.email')" || true
if [[ $email_old != "$email_new" ]]; then
  rbw config set email "$email_new"
fi
rbw login
