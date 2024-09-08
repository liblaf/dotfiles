if status is-interactive
    # https://github.com/ajeetdsouza/zoxide/blob/main/init.fish
    if command -sq zoxide
        set --global --export _ZO_EXCLUDE_DIRS "$HOME:$HOME/OneDrive/*:$HOME/SeaDrive/*"
        zoxide init fish | source
    else
        echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
    end
end
