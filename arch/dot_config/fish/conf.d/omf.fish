set --global --export OMF_PATH "$HOME/.local/share/omf"

if status is-interactive
    source "$OMF_PATH/init.fish"
end
