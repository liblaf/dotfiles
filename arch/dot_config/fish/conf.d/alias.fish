if status is-interactive
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

    abbr --add hx helix
    abbr --add r --command pueue -- status status="running"

    set apps typora
    for app in $apps
        if type --query $app
            echo "
function $app --wraps $app
    command $app \$argv < /dev/null &> /dev/null &
    disown
end" | source
        end
    end
end
