if status is-interactive
    # ref: <https://github.com/zellij-org/zellij/issues/689#issuecomment-914057955>
    # Kitty is generally hostile to terminal multiplexers, so we skip launching
    # Zellij in Kitty.
    if contains -- "$TERM" xterm-ghostty
        # ref: <https://zellij.dev/documentation/integration.html#fish>
        if not set --query ZELLIJ
            zellij attach --create "$hostname"
            kill $fish_pid
        end
    end
end
