if status is-interactive
    if test "$TERM_PROGRAM" = WezTerm
        echo "function ssh --description \"alias ssh wezterm ssh\" --wraps \"wezterm ssh\"
    command wezterm ssh \$argv < /dev/null &> /dev/null &
    disown
end" | source
        alias icat "wezterm imgcat"
    else if test "$TERM" = xterm-kitty
        alias ssh "kitty +kitten ssh"
        if type --query magick
            alias icat "kitten icat --engine magick"
        else
            alias icat "kitten icat"
        end
    end
end
