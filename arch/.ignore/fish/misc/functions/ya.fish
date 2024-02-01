function ya
    # https://yazi-rs.github.io/docs/quick-start#shell-wrapper
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
