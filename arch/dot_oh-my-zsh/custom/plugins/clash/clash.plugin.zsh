#!/usr/bin/zsh

function clash-dashboard() {
  if [[ -n ${1-} ]]; then
    local hostname="https://clash-$1.liblaf.me"
    local secret=$(dasel select --file="$HOME/.config/clash/config.yaml" --selector=".secret")
    open "https://yacd.haishan.me/?hostname=$hostname&secret=$secret"
  else
    local hostname=http://127.0.0.1
    local port=$(dasel select --file="$HOME/.config/clash/config.yaml" --selector=".external-controller" | awk --field-separator=":" '{ print $2 }')
    local secret=$(dasel select --file="$HOME/.config/clash/config.yaml" --selector=".secret")
    open "https://yacd.haishan.me/?hostname=$hostname&port=$port&secret=$secret"
  fi
}

function clash-update() {
  (
    set -o errexit
    local config="$HOME/.config/clash/config.yaml"
    local temp=$(mktemp --suffix=.yaml)
    trap "rm --force --verbose $temp" EXIT
    https --output=$temp --download subs.liblaf.me/api/clash subs==$(bw get notes CLASH_SUBSCRIPTION)
    dasel put --file="$temp" --selector=".secret" --value=$(bw get notes CLASH_SECRET)
    install --backup -D --no-target-directory --verbose $temp $config
    systemctl --user restart clash.service
  )
}
