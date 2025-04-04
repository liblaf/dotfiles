fish_add_path --global ~/.local/bin ~/.bun/bin ~/.pixi/bin
for config in ~/.config/environment.d/*.conf
    if test ! "$config" -ef ~/.config/environment.d/path.conf
        sd '(?P<key>[A-Za-z_][0-9A-Za-z_]*)=(?P<val>.*)' 'set --global --export $key $val' <"$config" | source
    end
end

set --global --export SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gcr/ssh"
