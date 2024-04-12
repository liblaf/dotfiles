function _get_proxy_host --argument-names=type
    gsettings get "org.gnome.system.proxy.$type" host |
        tr --delete \'
end
