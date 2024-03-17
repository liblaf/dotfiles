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
