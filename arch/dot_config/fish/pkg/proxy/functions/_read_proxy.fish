function _read_proxy
    set --global --export _proxy_host (gsettings get org.gnome.system.proxy.http host | tr --delete "'")
    set --global --export _proxy_ignore (gsettings get org.gnome.system.proxy ignore-hosts | tr --delete "[' ]")
    set --global --export _proxy_port (gsettings get org.gnome.system.proxy.http port)
end
