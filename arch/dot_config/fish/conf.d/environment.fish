fish_add_path --global ~/.local/bin ~/.bun/bin
for config in ~/.config/environment.d/*.conf
    if test ! "$config" -ef ~/.config/environment.d/path.conf
        sed --regexp-extended --expression='s/([[:alnum:]_]+)=(.*)/set --global --export \1 "\2"/g' "$config" | source
    end
end
