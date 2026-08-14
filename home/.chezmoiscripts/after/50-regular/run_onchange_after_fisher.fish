#!/usr/bin/fish

set --append --local plugins \
    gitlab.com/lusiadas/insist

set --local plugins_to_remove (
    comm -2 -3 \
        (fisher list | sort | psub) \
        (printf '%s\n' $plugins | sort | psub)
)

if set --query plugins_to_remove[1]
    fisher remove $plugins_to_remove
end

set --local plugins_to_install (
    comm -2 -3 \
        (printf '%s\n' $plugins | sort | psub) \
        (fisher list | sort | psub)
)

if set --query plugins_to_install[1]
    fisher install $plugins_to_install
end
