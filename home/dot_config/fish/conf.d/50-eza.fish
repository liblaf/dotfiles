if status is-interactive
    and type --query eza
    # ref: <https://github.com/CachyOS/cachyos-fish-config/blob/main/cachyos-config.fish>
    # Replace ls with eza
    alias ls='eza -al --color=always --group-directories-first --icons=always' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons=always' # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons=always' # long format
    alias lt='eza -aT --color=always --group-directories-first --icons=always' # tree listing
    alias l.="eza -a | grep -e '^\.'" # show only dotfiles
end
