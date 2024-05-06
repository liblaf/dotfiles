fish_add_path --global "$HOME/.local/bin"
for config in $HOME/.config/environment.d/*.conf
    if test ! "$config" -ef "$HOME/.config/environment.d/path.conf"
        sed --regexp-extended --expression='s/([[:alnum:]_]+)=(.*)/set --global --export \1 "\2"/g' "$config" | source
    end
end
