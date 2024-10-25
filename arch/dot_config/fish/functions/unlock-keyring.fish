function unlock-keyring
    # https://stackoverflow.com/a/76049791
    read --silent --function --prompt-str="[keyring] password for $USER: " password || return $status
    echo -n "$password" |
        gnome-keyring-daemon --replace --unlock |
        sd '(?P<key>[A-Za-z_][0-9A-Za-z_]*)=(?P<val>.*)' 'set --global --export "$key" "$val"' |
        source
end
