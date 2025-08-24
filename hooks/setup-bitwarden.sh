#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rbw config set email 'veto-dimly-corsage@duck.com'
rbw login
