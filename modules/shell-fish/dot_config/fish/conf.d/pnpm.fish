if type --query pnpm
    set --global --export PNPM_HOME "$HOME/.local/share/pnpm"
    mkdir --parents "$PNPM_HOME"
    fish_add_path --global --path "$PNPM_HOME"
end
