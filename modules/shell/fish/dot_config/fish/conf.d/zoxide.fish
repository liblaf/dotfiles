if status is-interactive
    and type --query zoxide
    # ref: <https://github.com/ajeetdsouza/zoxide/blob/main/init.fish>
    zoxide init fish | source
end
