if not status is-interactive
    or not type --query direnv
    return
end

direnv hook fish | source
