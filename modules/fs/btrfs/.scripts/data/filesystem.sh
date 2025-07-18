#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

fstype=$(findmnt --noheadings --output FSTYPE /)
echo ".fs.fstype = \"$fstype\""
source=$(findmnt --noheadings --output SOURCE /)
echo ".fs.source = \"$source\""
