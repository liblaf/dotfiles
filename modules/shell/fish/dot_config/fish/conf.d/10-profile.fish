if status is-interactive
    and not set --query __fish_profile
    set --global --export __fish_profile 1
    exec bash -c -l 'exec fish'
end
