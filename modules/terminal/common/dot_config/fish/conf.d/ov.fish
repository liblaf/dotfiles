if not status is-interactive
    or not type --query ov
    return
end

set --global --export GROFF_NO_SGR 1
set --global --export MANPAGER "ov --view-mode man"
