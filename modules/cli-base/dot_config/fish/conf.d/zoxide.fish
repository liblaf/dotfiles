if not status is-interactive
    or not type --query zoxide
    return
end

# ref: <https://github.com/ajeetdsouza/zoxide/blob/main/init.fish>
zoxide init fish | source
