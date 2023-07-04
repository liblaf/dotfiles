if [[ -d "${HOME}/.local/share/pnpm" ]]; then
  export PNPM_HOME="${HOME}/.local/share/pnpm"
  case ":${PATH}:" in
    *":${PNPM_HOME}:"*) ;;
    *) export PATH="${PNPM_HOME}:${PATH}" ;;
  esac
fi
