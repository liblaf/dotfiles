if status is-interactive
    if test "$TERM" = xterm-kitty
        alias c 'kitten clipboard'
        alias icat 'kitten icat --align left'
        alias p 'kitten clipboard --get-clipboard'
        alias ssh 'kitty @ launch --type os-window kitten ssh'
    end
end
