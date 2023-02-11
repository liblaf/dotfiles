#!/usr/bin/zsh
# Reference: https://github.com/SukkaW/zsh-proxy

function __dconf_read_proxy() {
  local t="${1}"
  local host="$(dconf read /system/proxy/${t}/host)"
  if [[ -z ${host} ]]; then
    host="127.0.0.1"
  else
    host="${host:1:-1}"
  fi
  local port="$(dconf read /system/proxy/${t}/port)"
  if [[ -z ${port} ]]; then
    port="7890"
  fi
  echo -n "${host}:${port}"
}

function __read_proxy() {
  __all_proxy="socks://$(__dconf_read_proxy socks)/"
  __ftp_proxy="http://$(__dconf_read_proxy ftp)/"
  __http_proxy="http://$(__dconf_read_proxy http)/"
  __https_proxy="http://$(__dconf_read_proxy https)/"
  __no_proxy="localhost,127.0.0.0/8,::1"
}

function __check_ip() {
  echo "========================================"
  echo "Check what your IP is"
  echo "----------------------------------------"
  ipv4="$(https --body https://api-ipv4.ip.sb/ip 2> /dev/null)"
  if [[ $ipv4 != "" ]]; then
    echo "IPv4: $ipv4"
  else
    echo "IPv4: -"
  fi
  echo "----------------------------------------"
  ipv6="$(https --body https://api-ipv6.ip.sb/ip 2> /dev/null)"
  if [[ $ipv6 != "" ]]; then
    echo "IPv6: $ipv6"
  else
    echo "IPv6: -"
  fi
  echo "----------------------------------------"
  echo "Info: "
  https --body https://api.ip.sb/geoip 2> /dev/null
  echo "========================================"
}

function __enable_proxy_apt() {
  if [ -d "/etc/apt/apt.conf.d" ]; then
    sudo touch /etc/apt/apt.conf.d/proxy.conf
    echo -e "Acquire::http::Proxy \"${__http_proxy}\";" | sudo tee -a /etc/apt/apt.conf.d/proxy.conf > /dev/null
    echo -e "Acquire::https::Proxy \"${__https_proxy}\";" | sudo tee -a /etc/apt/apt.conf.d/proxy.conf > /dev/null
    echo "- apt"
  fi
}

function __disable_proxy_apt() {
  if [ -d "/etc/apt/apt.conf.d" ]; then
    sudo rm -rf /etc/apt/apt.conf.d/proxy.conf
  fi
}

function __enable_proxy_git() {
  git config --global http.proxy "${__http_proxy}"
  git config --global https.proxy "${__https_proxy}"
  echo "- git"
}

function __disable_proxy_git() {
  git config --global --unset http.proxy
  git config --global --unset https.proxy
}

function __enable_proxy_pnpm() {
  if command -v pnpm > /dev/null; then
    pnpm config --global set proxy "${__http_proxy}" > /dev/null 2>&1
    pnpm config --global set https-proxy "${__https_proxy}" > /dev/null 2>&1
    echo "- pnpm"
  fi
}

function __disable_proxy_pnpm() {
  if command -v pnpm > /dev/null; then
    pnpm config --global delete proxy > /dev/null 2>&1
    pnpm config --global delete https-proxy > /dev/null 2>&1
  fi
}

function __enable_proxy_shell() {
  __read_proxy

  export ALL_PROXY="${__all_proxy}"
  export FTP_PROXY="${__ftp_proxy}"
  export HTTP_PROXY="${__http_proxy}"
  export HTTPS_PROXY="${__https_proxy}"
  export NO_PROXY="${__no_proxy}"

  export all_proxy="${__all_proxy}"
  export ftp_proxy="${__ftp_proxy}"
  export http_proxy="${__http_proxy}"
  export https_proxy="${__https_proxy}"
  export no_proxy="${__no_proxy}"

  echo "- shell"
}

function __disable_proxy_shell() {
  unset ALL_PROXY
  unset FTP_PROXY
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset NO_PROXY

  unset all_proxy
  unset ftp_proxy
  unset http_proxy
  unset https_proxy
  unset no_proxy
}

function proxy() {
  echo "========================================"
  echo -n "Resetting proxy... "
  noproxy
  echo "Done!"
  echo "----------------------------------------"
  echo "Enable proxy for:"
  if [[ ${#} -eq 0 ]]; then
    local -a arr=(apt git pnpm shell)
  else
    local -a arr="${@}"
  fi
  for t in "${arr[@]}"; do
    __enable_proxy_${t}
  done
  echo "Done!"
  __check_ip
}

function noproxy() {
  local -a arr=(apt git pnpm shell)
  for t in "${arr[@]}"; do
    __disable_proxy_${t}
  done
}

function myip() {
  __check_ip
}
