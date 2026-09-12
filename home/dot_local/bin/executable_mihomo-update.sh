#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly config_file='/etc/mihomo/config.yaml'
port="$(gsettings get org.gnome.system.proxy.https port)"
export port
url=$(awk '
  NR == 1 {
    if ($1 == "#SUBSCRIBED" && NF == 2)
      print $2
    exit
  }
' "$config_file")
if [[ -z $url ]]; then
  echo "Subscription URL not found in '$config_file'"
  exit 1
fi
tmpfile="$(mktemp --suffix='.yaml')"
xhs --output "$tmpfile" --download GET "$url"
yq eval '.mixed-port=env(port)' "$tmpfile" --inplace
mihomo -f "$tmpfile" -t
sudo cp --verbose "$tmpfile" "$config_file"
rm --force "$tmpfile"
sudo systemctl --now enable mihomo.service
sudo systemctl restart mihomo.service
