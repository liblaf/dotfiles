#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

fwupdmgr get-devices --assume-yes         # display all devices detected by fwupd
fwupdmgr refresh --assume-yes || true     # download the latest metadata from LVFS
fwupdmgr get-updates --assume-yes || true # list updates available for any devices on the system
fwupdmgr update --assume-yes              # install updates
