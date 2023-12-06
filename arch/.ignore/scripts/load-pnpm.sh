#shellcheck disable=SC2148

export PNPM_HOME="$HOME/.local/share/pnpm"
mkdir --parents --verbose "$PNPM_HOME"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME${PATH:+:$PATH}" ;;
esac
