function unlock-keyring
    # https://stackoverflow.com/a/76049791
    read --silent --function --prompt-str="[keyring] password for $USER: " password
    echo -n "$password" |
        gnome-keyring-daemon --replace --unlock |
        sed "s/\([^=]\+\)=\(.*\)/set --global --export \1 \2/g" |
        source
end
