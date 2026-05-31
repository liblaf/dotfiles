if status is-interactive
    and type --query kitty
    function ssh --wraps ssh
        kitty kitten ssh "$argv"
    end
end
