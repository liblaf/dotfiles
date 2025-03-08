#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# TODO: schedule restic backups when everything is working
resticprofile unschedule
