function proxy-on
    _read_proxy
    gsettings set org.gnome.system.proxy mode manual
    set --global --export all_proxy "socks://$_proxy_host:$_proxy_port/"
    set --global --export ALL_PROXY $all_proxy
    set --global --export ftp_proxy "http://$_proxy_host:$_proxy_port/"
    set --global --export FTP_PROXY $ftp_proxy
    set --global --export http_proxy "http://$_proxy_host:$_proxy_port/"
    set --global --export HTTP_PROXY $http_proxy
    set --global --export https_proxy "http://$_proxy_host:$_proxy_port/"
    set --global --export HTTPS_PROXY $https_proxy
    set --global --export no_proxy $_proxy_ignore
    set --global --export NO_PROXY $no_proxy
end
