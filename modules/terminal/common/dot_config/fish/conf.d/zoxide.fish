if status is-interactive
    # ref: <https://github.com/ajeetdsouza/zoxide/blob/main/init.fish>
    if type --query zoxide
        zoxide init fish | source
    else
        echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
    end
end
