#!/usr/bin/env zsh

function get-ip() {
  if [[ -n "${WSL_DISTRO_NAME}" ]]; then
    export router_ip="$(ip route | grep 'default' | awk '{print $3}')"
  else
    export router_ip="127.0.0.1"
  fi
  export host_ip="$(hostname --all-ip-address | awk '{print $1}')"
}

function print-ip() {
  get-ip
  https --body "https://ipapi.co/yaml/"
  echo "Router IP : ${router_ip}"
  echo "Host IP   : ${host_ip}"
}

function proxy() {
  case "${1}" in
  apt)
    proxy-apt
    ;;
  git)
    proxy-git
    ;;
  *)
    get-ip
    export HTTP_PROXY="http://${router_ip}:57890/"
    export HTTPS_PROXY="http://${router_ip}:57890/"
    export FTP_PROXY="http://${router_ip}:57890/"
    export ALL_PROXY="socks5://${router_ip}:57890/"
    export NO_PROXY="localhost,127.0.0.0/8,::1"
    export http_proxy="${HTTP_PROXY}"
    export https_proxy="${HTTPS_PROXY}"
    export ftp_proxy="${FTP_PROXY}"
    export all_proxy="${ALL_PROXY}"
    export no_proxy="${NO_PROXY}"
    print-ip
    ;;
  esac
  unset router_ip
  unset host_ip
}

function unproxy() {
  case "${1}" in
  apt)
    unproxy-apt
    ;;
  git)
    unproxy-git
    ;;
  *)
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset ALL_PROXY
    unset NO_PROXY
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset all_proxy
    unset no_proxy
    print-ip
    ;;
  esac
  unset router_ip
  unset host_ip
}

function proxy-git() {
  get-ip
  git config --global "http.https://github.com.proxy" "${HTTP_PROXY}"
}

function unproxy-git() {
  git config --global --unset-all "http.https://github.com.proxy"
}

function proxy-apt() {
  get-ip
  echo "Acquire::http::Proxy \"${HTTP_PROXY}\";" | sudo tee "/etc/apt/apt.conf.d/proxy.conf" >"/dev/null"
  echo "Acquire::https::Proxy \"${HTTPS_PROXY}\";" | sudo tee --append "/etc/apt/apt.conf.d/proxy.conf" >"/dev/null"
}

function unproxy-apt() {
  sudo rm --force "/etc/apt/apt.conf.d/proxy.conf"
}
