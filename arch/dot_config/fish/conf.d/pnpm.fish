set --global --export PNPM_HOME "$HOME/.local/share/pnpm"
mkdir --parents "$PNPM_HOME"
fish_add_path --global "$PNPM_HOME"
