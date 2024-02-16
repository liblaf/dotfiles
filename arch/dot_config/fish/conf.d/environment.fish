fish_add_path --global "$HOME/.local/bin"
for config in $HOME/.config/environment.d/*.conf
    if test "$config" -ef "$HOME/.config/environment.d/path.conf"
        export (
            envsubst <$config |
                sed --expression="s/\s*#.*//" --expression='/^\s*$/d' --regexp-extended
        )
    end
end
