if status is-interactive
    if test "$TERM" = xterm-kitty
        alias c 'kitten clipboard'
        alias icat 'kitten icat --align left'
        alias p 'kitten clipboard --get-clipboard'
        alias ssh 'kitty @ launch --type os-window kitten ssh'
    else if type --query kitty
        function ssh --wraps ssh
            kitty kitten ssh "$argv" </dev/null &>/dev/null &
            disown
        end
    end
end
