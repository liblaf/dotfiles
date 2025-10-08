if not status is-interactive
    or not type --query starship
    return
end

starship init fish | source

function __starship_remote --on-event fish_prompt
    if string match --quiet -- "$HOME/mnt/**" "$PWD"
        set --global --export STARSHIP_CONFIG "$HOME/.config/starship/remote.toml"
    else
        set --global --erase STARSHIP_CONFIG
    end
end
