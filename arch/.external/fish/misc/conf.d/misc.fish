if status is-interactive
    alias hx helix
    alias y "run yay --devel --useask=false --sync --sysupgrade --refresh --noconfirm"
    if type --query go-task
        alias task go-task
    end
end
