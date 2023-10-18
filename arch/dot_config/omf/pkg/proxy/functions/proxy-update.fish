function proxy-update
    set --function clash_config="$HOME/.config/clash/config.yaml"
    if test -f $clash_config
        set --function _proxy_port (dasel select --file=$clash_config --selector=".mixed-port")
    else
        set --function _proxy_port 57890
    end
    gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
    gsettings set org.gnome.system.proxy.ftp port $_proxy_port
    gsettings set org.gnome.system.proxy.http host 127.0.0.1
    gsettings set org.gnome.system.proxy.http port $_proxy_port
    gsettings set org.gnome.system.proxy.https host 127.0.0.1
    gsettings set org.gnome.system.proxy.https port $_proxy_port
    gsettings set org.gnome.system.proxy.socks host 127.0.0.1
    gsettings set org.gnome.system.proxy.socks port $_proxy_port
end
