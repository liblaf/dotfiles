for config in $HOME/.config/environment.d/*.conf
    export (
        envsubst <$config |
            sed --expression="s/\s*#.*//" --expression='/^\s*$/d' --regexp-extended
    )
end
