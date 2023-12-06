#shellcheck disable=SC2148

if [[ -f "$HOME/.local/opt/conda/etc/profile.d/conda.sh" ]]; then
  # shellcheck source=/dev/null
  source "$HOME/.local/opt/conda/etc/profile.d/conda.sh"
elif [[ -f /opt/miniconda3/etc/profile.d/conda.sh ]]; then
  # shellcheck source=/dev/null
  source /opt/miniconda3/etc/profile.d/conda.sh
fi
