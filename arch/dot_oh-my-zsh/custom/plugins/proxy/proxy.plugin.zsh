function proxy-off() {
  gsettings set org.gnome.system.proxy mode none
  unset all_proxy
  unset ALL_PROXY
  unset ftp_proxy
  unset FTP_PROXY
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
}

function proxy-on() {
  _read_proxy
  export all_proxy="socks://$_proxy_host:$_proxy_port/"
  export ALL_PROXY=$all_proxy
  export ftp_proxy="http://$_proxy_host:$_proxy_port/"
  export FTP_PROXY=$ftp_proxy
  export http_proxy="http://$_proxy_host:$_proxy_port/"
  export HTTP_PROXY=$http_proxy
  export https_proxy="http://$_proxy_host:$_proxy_port/"
  export HTTPS_PROXY=$https_proxy
  gsettings set org.gnome.system.proxy mode manual
}

function proxy-update() {
  local clash_config="$HOME/.config/clash/config.yaml"
  if [[ -r $clash_config ]]; then
    if has dasel; then
      _proxy_port=$(dasel select --file=$clash_config --selector=".mixed-port")
    else
      _proxy_port=$(grep "mixed-port" $clash_config | awk '{ print $2 }')
    fi
  else
    _proxy_port=57890
  fi
  gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
  gsettings set org.gnome.system.proxy.ftp port $_proxy_port
  gsettings set org.gnome.system.proxy.http host 127.0.0.1
  gsettings set org.gnome.system.proxy.http port $_proxy_port
  gsettings set org.gnome.system.proxy.https host 127.0.0.1
  gsettings set org.gnome.system.proxy.https port $_proxy_port
  gsettings set org.gnome.system.proxy.socks host 127.0.0.1
  gsettings set org.gnome.system.proxy.socks port $_proxy_port
}

function my-ip() {
  echo "========================================================="
  local ipv4=$(curl --ipv4 --fail --max-time 3 ip.sb 2> /dev/null)
  echo "IPv4: ${ipv4:-"-"}"
  echo "---------------------------------------------------------"
  local ipv6=$(curl --ipv6 --fail --max-time 3 ip.sb 2> /dev/null)
  echo "IPv6: ${ipv6:-"-"}"
  echo "---------------------------------------------------------"
  https --body --timeout=3 https://api.ip.sb/geoip 2> /dev/null
  echo "========================================================="
}

function no-proxy() {
  env \
    --unset=all_proxy \
    --unset=ALL_PROXY \
    --unset=ftp_proxy \
    --unset=FTP_PROXY \
    --unset=http_proxy \
    --unset=HTTP_PROXY \
    --unset=https_proxy \
    --unset=HTTPS_PROXY \
    "$@"
}

function _auto_proxy() {
  local mode=$(gsettings get org.gnome.system.proxy mode | tr -d "'")
  if [[ $mode == "manual" ]]; then
    proxy-on
  elif [[ $mode == "none" ]]; then
    proxy-off
  fi
}

function _read_proxy() {
  _proxy_host=$(gsettings get org.gnome.system.proxy.http host | tr -d "'")
  _proxy_port=$(gsettings get org.gnome.system.proxy.http port)
}

_auto_proxy
