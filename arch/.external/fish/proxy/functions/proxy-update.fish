function proxy-update
    gsettings set org.gnome.system.proxy.ftp host 127.0.0.1
    gsettings set org.gnome.system.proxy.ftp port 2080
    gsettings set org.gnome.system.proxy.http host 127.0.0.1
    gsettings set org.gnome.system.proxy.http port 2080
    gsettings set org.gnome.system.proxy.https host 127.0.0.1
    gsettings set org.gnome.system.proxy.https port 2080
    gsettings set org.gnome.system.proxy.socks host 127.0.0.1
    gsettings set org.gnome.system.proxy.socks port 2080
end
