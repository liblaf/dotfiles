if status is-interactive
    # ref: <https://github.com/zellij-org/zellij/issues/689#issuecomment-914057955>
    # Kitty is generally hostile to terminal multiplexers, so we skip launching
    # Zellij in Kitty.
    if contains -- "$TERM" alacritty rio foot xterm-ghostty
        # ref: <https://zellij.dev/documentation/integration.html#fish>
        set ZELLIJ_AUTO_ATTACH true
        set ZELLIJ_AUTO_EXIT true
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
