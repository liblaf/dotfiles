#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt; then exit; fi

# TODO: setup resticprofile on all machines

# {{- if .service.restic }}

resticprofile schedule

# {{- else }}

resticprofile unschedule

# {{- end }}
