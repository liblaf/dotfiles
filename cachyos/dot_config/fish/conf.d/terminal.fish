if status is-interactive
    if test "$TERM_PROGRAM" = WezTerm
        function ssh --description="alias ssh wezterm ssh" --wraps="wezterm ssh"
            command wezterm ssh $argv </dev/null &
            disown
        end
        alias icat "wezterm imgcat"
    else if test "$TERM" = xterm-kitty
        alias ssh "kitty +kitten ssh"
        alias icat "kitten icat"
    end
end
