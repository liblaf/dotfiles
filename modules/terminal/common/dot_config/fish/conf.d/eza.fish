if status is-interactive
    if type --query eza
        # ref: <https://github.com/CachyOS/cachyos-fish-config/blob/f6e45f5927de901af281e8fc1b59b81a6f623c5d/cachyos-config.fish#L78-L83>
        # Replace ls with eza
        alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
        alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
        alias ll='eza -l --color=always --group-directories-first --icons' # long format
        alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
        alias l.="eza -a | grep -e '^\.'" # show only dotfiles
    end
end
