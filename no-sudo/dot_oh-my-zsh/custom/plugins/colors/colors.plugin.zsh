#!/usr/bin/zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Requires colors autoload.
# See termcap(5).

# Set up once, and then reuse. This way it supports user overrides after the
# plugin is loaded.
# typeset -AHg less_termcap

# bold & blinking mode
export LESS_TERMCAP_mb="${fg_bold[red]}"
export LESS_TERMCAP_md="${fg_bold[red]}"
export LESS_TERMCAP_me="${reset_color}"
# standout mode
export LESS_TERMCAP_so="${fg_bold[yellow]}${bg[blue]}"
export LESS_TERMCAP_se="${reset_color}"
# underlining
export LESS_TERMCAP_us="${fg_bold[green]}"
export LESS_TERMCAP_ue="${reset_color}"

if command -v moar > /dev/null; then
  export PAGER="moar"
  export BAT_PAGER="moar --no-linenumbers"
  alias L="| moar"
fi
