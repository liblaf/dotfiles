function _get_proxy_port --argument-names=type
    gsettings get "org.gnome.system.proxy.$type" port
end
