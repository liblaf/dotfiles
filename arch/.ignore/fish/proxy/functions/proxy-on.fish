function proxy-on
    gsettings set org.gnome.system.proxy mode manual
    set --global --export all_proxy "socks://$(_get_proxy_host socks):$(_get_proxy_port socks)/"
    set --global --export ALL_PROXY $all_proxy
    set --global --export ftp_proxy "http://$(_get_proxy_host ftp):$(_get_proxy_port ftp)/"
    set --global --export FTP_PROXY $ftp_proxy
    set --global --export http_proxy "http://$(_get_proxy_host http):$(_get_proxy_port http)/"
    set --global --export HTTP_PROXY $http_proxy
    set --global --export https_proxy "http://$(_get_proxy_host https):$(_get_proxy_port https)/"
    set --global --export HTTPS_PROXY $https_proxy
    set --global --export no_proxy (_get_proxy_ignore)
    set --global --export NO_PROXY $no_proxy
end
