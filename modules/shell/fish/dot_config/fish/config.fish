if status is-interactive
    # According to <https://github.com/zellij-org/zellij/issues/689#issuecomment-914057955>, Kitty is generally hostile to terminal multiplexers, so we skip launching Zellij in Kitty.
    if test "$TERM" = alacritty
        or test "$TERM" = rio
        or test "$TERM" = foot
        or test "$TERM" = xterm-ghostty
        set ZELLIJ_AUTO_EXIT true
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
