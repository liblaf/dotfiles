#!/usr/bin/zsh

function _get_proxy() {
  if [[ -r "$HOME/.config/clash/config.yaml" ]]; then
    if has dasel &> /dev/null; then
      _mixed_port=$(dasel select --file="$HOME/.config/clash/config.yaml" --selector=".mixed-port" 2> /dev/null)
    else
      _mixed_port=$(grep "mixed-port" "$HOME/.config/clash/config.yaml" | awk '{ print $2 }' 2> /dev/null)
    fi
  else
    _mixed_port=57890
  fi
  _ftp_proxy="http://127.0.0.1:$_mixed_port"
  _http_proxy="http://127.0.0.1:$_mixed_port"
  _https_proxy="http://127.0.0.1:$_mixed_port"
  _socks_proxy="socks://127.0.0.1:$_mixed_port"
}

function _test_proxy() {
  curl --fail --proxy $_http_proxy cp.cloudflare.com &> /dev/null
}

function _check_ip() {
  echo "========================================"
  local ipv4=$(curl -4 ip.sb 2> /dev/null)
  echo "IPv4: ${ipv4:-"-"}"
  echo "----------------------------------------"
  local ipv6=$(curl -6 ip.sb 2> /dev/null)
  echo "IPv6: ${ipv6:-"-"}"
  echo "----------------------------------------"
  https --body https://api.ip.sb/geoip 2> /dev/null
  echo "========================================"
}

function _enable_proxy_shell() {
  export all_proxy=$_socks_proxy
  export ALL_PROXY=$all_proxy
  export ftp_proxy=$_ftp_proxy
  export FTP_PROXY=$ftp_proxy
  export http_proxy=$_http_proxy
  export HTTP_PROXY=$http_proxy
  export https_proxy=$_https_proxy
  export HTTPS_PROXY=$https_proxy
  export no_proxy=localhost,127.0.0.0/8,::1
  export NO_PROXY=$no_proxy
}

function _disable_proxy_shell() {
  unset all_proxy
  unset ALL_PROXY
  unset ftp_proxy
  unset FTP_PROXY
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset no_proxy
  unset NO_PROXY
}

function _enable_proxy_system() {
  gsettings set org.gnome.system.proxy mode manual
  gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
  gsettings set org.gnome.system.proxy.ftp port $_mixed_port
  gsettings set org.gnome.system.proxy.http host 127.0.0.1
  gsettings set org.gnome.system.proxy.http port $_mixed_port
  gsettings set org.gnome.system.proxy.https host 127.0.0.1
  gsettings set org.gnome.system.proxy.https port $_mixed_port
  gsettings set org.gnome.system.proxy.socks host 127.0.0.1
  gsettings set org.gnome.system.proxy.socks port $_mixed_port
}

function _disable_proxy_system() {
  gsettings reset org.gnome.system.proxy mode
}

_proxy_targets=(
  shell
  system
)

function _auto_proxy() {
  _get_proxy
  if _test_proxy; then
    for target in "${_proxy_targets[@]}"; do
      _enable_proxy_$target
    done
  else
    for target in "${_proxy_targets[@]}"; do
      _disable_proxy_$target
    done
  fi
}

function proxy() {
  _get_proxy
  echo "========================================"
  echo "Enable proxy for:"
  for target in "${_proxy_targets[@]}"; do
    if _enable_proxy_$target; then
      echo "- $target"
    fi
  done
  _check_ip
}

function noproxy() {
  echo "========================================"
  echo "Disable proxy for:"
  for target in "${_proxy_targets[@]}"; do
    if _disable_proxy_$target; then
      echo "- $target"
    fi
  done
  _check_ip
}

function myip() {
  _check_ip
}

_auto_proxy

function ssh-proxy() {
  _get_proxy
  mkdir --parents /run/user/$UID/ssh
  ssh -f -M -N -o ExitOnForwardFailure=yes -R 57890:127.0.0.1:$_mixed_port -S /run/user/$UID/ssh/$1 "$@"
}
compdef ssh-proxy=ssh || true

function ssh-noproxy() {
  ssh -O exit -S /run/user/$UID/ssh/$1 "$@"
}
compdef ssh-noproxy=ssh || true

function ssh-proxy-list() {
  if [[ -d /run/user/$UID/ssh ]]; then
    l /run/user/1000/ssh
  fi
}
