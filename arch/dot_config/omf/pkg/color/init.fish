# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh

set --global --export LESS_TERMCAP_mb (set_color --bold red) # blink
set --global --export LESS_TERMCAP_md (set_color --bold red) # bold
set --global --export LESS_TERMCAP_me (set_color normal) # end
set --global --export LESS_TERMCAP_so (set_color --background=blue --bold yellow) # standout
set --global --export LESS_TERMCAP_se (set_color normal) # end
set --global --export LESS_TERMCAP_us (set_color --bold green) # underline
set --global --export LESS_TERMCAP_ue (set_color normal) # end

set --global --export GROFF_NO_SGR 1
