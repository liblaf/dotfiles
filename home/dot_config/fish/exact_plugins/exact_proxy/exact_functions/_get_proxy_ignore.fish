function _get_proxy_ignore
    set --local ignore_hosts (gsettings get org.gnome.system.proxy ignore-hosts)
    set --local stripped (string trim --left --chars "[" -- "$ignore_hosts")
    set --local stripped (string trim --right --chars "]" -- "$stripped")
    set --local parts (string split "," -- "$stripped")
    set --local unquoted
    for part in $parts
        set --append unquoted (string trim --chars ' "\'' -- "$part")
    end
    string join "," -- $unquoted
end
