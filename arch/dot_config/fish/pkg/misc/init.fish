alias lf 'PAGER="bat --paging=always" command lf'
alias pre "pre-commit run --all-files"
alias y "run yay --devel --nouseask --sync --sysupgrade --refresh --noconfirm"

if test $TERM = xterm-kitty
    alias ssh "kitty +kitten ssh"
    if type --query magick
        alias icat "kitten icat --engine magick"
    else
        alias icat "kitten icat"
    end
end