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
