if status is-interactive
    starship init fish | source
    set --global --export STARSHIP_SHELL sh
end
