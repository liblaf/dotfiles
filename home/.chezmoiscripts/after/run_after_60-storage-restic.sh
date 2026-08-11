#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# I don't feel the need for any backups at the moment. I'll enable resticprofile
# when I have some important files.
resticprofile unschedule
