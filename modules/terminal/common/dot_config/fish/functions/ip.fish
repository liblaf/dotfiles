if not status is-interactive
    or not type --query ip
    return
end

alias ip "ip -color=auto"
