# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set --global --export MAMBA_EXE /usr/bin/micromamba
set --global --export MAMBA_ROOT_PREFIX "$HOME/micromamba"
"$MAMBA_EXE" shell hook --shell=fish --root-prefix="$MAMBA_ROOT_PREFIX" | source
# <<< mamba initialize <<<
