#!/bin/bash

gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
gsettings set org.gnome.system.proxy.ftp port 62562
gsettings set org.gnome.system.proxy.http host 127.0.0.1
gsettings set org.gnome.system.proxy.http port 62562
gsettings set org.gnome.system.proxy.https host 127.0.0.1
gsettings set org.gnome.system.proxy.https port 62562
gsettings set org.gnome.system.proxy.socks host 127.0.0.1
gsettings set org.gnome.system.proxy.socks port 62562
gsettings set org.gnome.system.proxy mode manual

export all_proxy='http://127.0.0.1:62562/'
export ALL_PROXY="$all_proxy"
export ftp_proxy='http://127.0.0.1:62562/'
export FTP_PROXY="$ftp_proxy"
export http_proxy='http://127.0.0.1:62562/'
export HTTP_PROXY="$http_proxy"
export https_proxy='http://127.0.0.1:62562/'
export HTTPS_PROXY="$https_proxy"
export no_proxy='localhost,127.0.0.0/8,::1'
export NO_PROXY="$no_proxy"
