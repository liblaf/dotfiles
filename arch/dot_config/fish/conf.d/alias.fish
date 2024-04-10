# https://fishshell.com/docs/current/interactive.html#abbreviations
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
alias md 'mkdir -p'
alias rd rmdir

# List directory contents
alias lsa 'ls -lah'
alias l 'ls -lah'
alias ll 'ls -lh'
alias la 'ls -lAh'

if status is-interactive
    abbr --add hx helix
    abbr --add y "yay --devel --useask=false --sync --sysupgrade --refresh --noconfirm"
    if type --query go-task
        alias task go-task
    end
    set apps typora
    for app in $apps
        if type --query $app
            echo "function $app --wraps $app
    command $app \$argv < /dev/null &> /dev/null &
    disown
end" | source
        end
    end
end

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
