if status is-interactive
    alias hx helix
    alias lf 'PAGER="bat --paging=always" command lf'
    alias y "run yay --devel --useask=false --sync --sysupgrade --refresh --noconfirm"

    if test "$TERM" = xterm-kitty
        alias ssh "kitty +kitten ssh"
        if type --query magick
            alias icat "kitten icat --engine magick"
        else
            alias icat "kitten icat"
        end
    end
end
