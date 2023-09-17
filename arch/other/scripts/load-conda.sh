if [[ -f "$HOME/.local/opt/conda/etc/profile.d/conda.sh" ]]; then
  source "$HOME/.local/opt/conda/etc/profile.d/conda.sh"
elif [[ -f /opt/miniconda3/etc/profile.d/conda.sh ]]; then
  source /opt/miniconda3/etc/profile.d/conda.sh
fi
