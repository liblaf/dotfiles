#!/usr/bin/zsh

function __get_proxy() {
  if [[ -f ${HOME}/.config/clash/config.yaml ]]; then
    if command -v dasel &> /dev/null; then
      __mixed_port=$(dasel --file="${HOME}/.config/clash/config.yaml" "mixed-port" 2> /dev/null)
    else
      __mixed_port=$(grep "mixed-port" ${HOME}/.config/clash/config.yaml | awk '{ print $2 }' 2> /dev/null)
    fi
  else
    __mixed_port=57890
  fi
  __ftp_proxy=http://127.0.0.1:${__mixed_port}
  __http_proxy=http://127.0.0.1:${__mixed_port}
  __https_proxy=http://127.0.0.1:${__mixed_port}
  __socks_proxy=socks://127.0.0.1:${__mixed_port}
}

function __test_proxy() {
  curl --proxy ${__http_proxy} ip.sb &> /dev/null
}

function __check_ip() {
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

function __enable_proxy_shell() {
  export all_proxy=${__socks_proxy}
  export ALL_PROXY=${all_proxy}
  export ftp_proxy=${__ftp_proxy}
  export FTP_PROXY=${ftp_proxy}
  export http_proxy=${__http_proxy}
  export HTTP_PROXY=${http_proxy}
  export https_proxy=${__https_proxy}
  export HTTPS_PROXY=${https_proxy}
  export no_proxy=localhost,127.0.0.0/8,::1
  export NO_PROXY=${no_proxy}
}

function __disable_proxy_shell() {
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

function __enable_proxy_system() {
  gsettings set org.gnome.system.proxy mode manual
  gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
  gsettings set org.gnome.system.proxy.ftp port ${__mixed_port}
  gsettings set org.gnome.system.proxy.http host 127.0.0.1
  gsettings set org.gnome.system.proxy.http port ${__mixed_port}
  gsettings set org.gnome.system.proxy.https host 127.0.0.1
  gsettings set org.gnome.system.proxy.https port ${__mixed_port}
  gsettings set org.gnome.system.proxy.socks host 127.0.0.1
  gsettings set org.gnome.system.proxy.socks port ${__mixed_port}
}

function __disable_proxy_system() {
  gsettings reset org.gnome.system.proxy mode
}

__proxy_targets=(
  shell
  system
)

function __auto_proxy() {
  __get_proxy
  if __test_proxy; then
    for target in ${__proxy_targets[@]}; do
      __enable_proxy_${target}
    done
  else
    for target in ${__proxy_targets[@]}; do
      __disable_proxy_${target}
    done
  fi
}

function proxy() {
  __get_proxy
  echo "========================================"
  echo "Enable proxy for:"
  for target in ${__proxy_targets[@]}; do
    if __enable_proxy_${target}; then
      echo "- ${target}"
    fi
  done
  __check_ip
}

function noproxy() {
  echo "========================================"
  echo "Disable proxy for:"
  for target in ${__proxy_targets[@]}; do
    if __disable_proxy_${target}; then
      echo "- ${target}"
    fi
  done
  __check_ip
}

function myip() {
  __check_ip
}

__auto_proxy

function ssh-proxy() {
  __get_proxy
  mkdir --parents /run/user/${UID}/ssh
  ssh -f -M -N -o ExitOnForwardFailure=yes -R 57890:127.0.0.1:${__mixed_port} -S /run/user/${UID}/ssh/${1} "${@}"
}

function ssh-noproxy() {
  ssh -O exit -S /run/user/${UID}/ssh/${1} "${@}"
}

function ssh-proxy-list() {
  if [[ -d /run/user/${UID}/ssh ]]; then
    l /run/user/1000/ssh
  fi
}

compdef ssh-proxy=ssh
compdef ssh-noproxy=ssh
