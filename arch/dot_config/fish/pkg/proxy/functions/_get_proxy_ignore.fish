function _get_proxy_ignore
    gsettings get org.gnome.system.proxy ignore-hosts |
        tr --delete "[' ]"
end
