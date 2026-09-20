#!/usr/bin/fish

gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
gsettings set org.gnome.system.proxy.ftp port 62562
gsettings set org.gnome.system.proxy.http host 127.0.0.1
gsettings set org.gnome.system.proxy.http port 62562
gsettings set org.gnome.system.proxy.https host 127.0.0.1
gsettings set org.gnome.system.proxy.https port 62562
gsettings set org.gnome.system.proxy.socks host 127.0.0.1
gsettings set org.gnome.system.proxy.socks port 62562
gsettings set org.gnome.system.proxy mode manual

set --export --global all_proxy 'http://127.0.0.1:62562/'
set --export --global ALL_PROXY "$all_proxy"
set --export --global ftp_proxy 'http://127.0.0.1:62562/'
set --export --global FTP_PROXY "$ftp_proxy"
set --export --global http_proxy 'http://127.0.0.1:62562/'
set --export --global HTTP_PROXY "$http_proxy"
set --export --global https_proxy 'http://127.0.0.1:62562/'
set --export --global HTTPS_PROXY "$https_proxy"
set --export --global no_proxy 'localhost,127.0.0.0/8,::1'
set --export --global NO_PROXY "$no_proxy"
