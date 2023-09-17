mkdir --parents --verbose "$HOME/.local/bin"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin${PATH:+:$PATH}" ;;
esac
