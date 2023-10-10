if [[ $TERM == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
  if has magick; then
    alias icat="kitten icat --engine magick"
  else
    alias icat="kitten icat"
  fi
fi

if has bat; then
  alias cat="bat"
  unalias help
  function help() {
    local output=$("$@" --help 2> /dev/null)
    if [[ -z $output ]]; then
      output=$("$@" -h 2> /dev/null)
    fi
    if [[ -z $output ]]; then
      output=$("$@" help 2> /dev/null)
    fi
    if [[ -z $output ]]; then
      return 1
    fi
    echo $output | bat --language=help
  }
fi

if has bw; then
  if has ddns; then
    alias ddns='ddns --token=$(bw get notes CLOUDFLARE_TOKEN_DNS) --zone=$(bw get notes CLOUDFLARE_ZONE)'
  fi
fi

if has lf; then
  if [[ -f /etc/profile.d/lfcd.sh ]]; then
    source /etc/profile.d/lfcd.sh
  fi
fi

if has lsd; then
  alias ls="lsd"
  alias tree="lsd --tree"
fi

if has make && has color-make; then
  compdef color-make=make
  alias makec=color-make
fi

if has microsoft-edge-stable; then
  alias edge="microsoft-edge-stable"
fi

if has moar; then
  export BAT_PAGER="moar --no-linenumbers --quit-if-one-screen"
  export PAGER="moar --quit-if-one-screen"
  export SYSTEMD_PAGERSECURE=1
fi

if has nvim; then
  alias vim="nvim"
  export EDITOR="nvim"
fi

if has pre-commit; then
  alias pre="pre-commit run --all-files"
fi

if has sudo; then
  # https://wiki.archlinux.org/title/Sudo#Passing_aliases
  alias sudo="sudo "
fi

if has tmux; then
  executables=(
    blender
    cfw
    microsoft-edge-stable
    texdoc
    typora
  )
  for exe in "${executables[@]}"; do
    if has "$exe"; then
      alias "$exe"="tmux new-session -d $exe"
    fi
  done
fi

if has xdg-open; then
  function open() {
    xdg-open "$@" &> /dev/null
  }
fi

if has yay; then
  function y() {
    run yay --devel --nouseask --sync --sysupgrade --refresh --noconfirm "$@"
  }
fi
