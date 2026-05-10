if status is-interactive
    # ref: <https://fishshell.com/docs/current/interactive.html#abbreviations>
    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    # ref: <https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh>
    alias md 'mkdir -p'
    alias rd rmdir

    # List directory contents
    alias lsa 'ls -lah'
    alias l 'ls -lah'
    alias ll 'ls -lh'
    alias la 'ls -lAh'

    if type --query pueue
        abbr --add r --command pueue -- status status="running"
    end

    for app in meshlab paraview typora
        if type --query $app
            function $app --wraps $app --inherit-variable app
                command $app $argv </dev/null &>/dev/null &
                disown
            end
        end
    end
end
