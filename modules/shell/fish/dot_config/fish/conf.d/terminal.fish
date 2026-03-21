if status is-interactive
    if test "$TERM_PROGRAM" = WezTerm
        function ssh --description="alias ssh wezterm ssh" --wraps="wezterm ssh"
            command wezterm ssh $argv </dev/null &
            disown
        end
        alias icat "wezterm imgcat"
    else if test "$TERM" = xterm-kitty
        alias c "kitten clipboard"
        alias icat "kitten icat --align left"
        alias p "kitten clipboard --get-clipboard"
        alias ssh "kitty @ launch --type os-window kitten ssh"
    end
end
