if status is-interactive
    if test "$TERM_PROGRAM" = WezTerm
        alias ssh "wezterm ssh"
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
