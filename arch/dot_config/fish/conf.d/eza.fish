if status is-interactive
    if type --query eza >/dev/null
        alias ls 'eza --icons --time-style long-iso --git'
    end
end
