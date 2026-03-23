if type --query opencode
    and type --query zellij
    function opencode --wraps opencode
        if set --query ZELLIJ
            zellij action switch-mode locked
        end
        command opencode $argv
        if set --query ZELLIJ
            zellij action switch-mode normal
        end
    end
end
