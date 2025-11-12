function proxy-off
    gsettings set org.gnome.system.proxy mode none
    set --erase all_proxy
    set --erase ALL_PROXY
    set --erase ftp_proxy
    set --erase FTP_PROXY
    set --erase http_proxy
    set --erase HTTP_PROXY
    set --erase https_proxy
    set --erase HTTPS_PROXY
end
