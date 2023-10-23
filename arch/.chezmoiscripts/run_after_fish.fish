#!/usr/bin/fish

set --local USER_SHELL (
    getent passwd $USER |
        awk --field-separator=":" '{ print $NF }'
)
if test $USER_SHELL != /usr/bin/fish
    run chsh --shell /usr/bin/fish
end

fisher install gitlab.com/lusiadas/insist
fisher install OakNinja/MakeMeFish
