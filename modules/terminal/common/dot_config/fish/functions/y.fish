if not status is-interactive
    or not type --query yazi
    return
end

function y
    # ref: <https://yazi-rs.github.io/docs/quick-start/#shell-wrapper>
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
