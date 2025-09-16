set --append PLUGINS \
    gazorby/fish-abbreviation-tips \
    gitlab.com/lusiadas/insist \
    ~/.config/fish/plugins/*

fisher update

set INSTALLED (fisher list)
for plugin in $PLUGINS
    if not contains $plugin $INSTALLED
        set --append TO_INSTALL $plugin
    end
end

if test (count $TO_INSTALL) -gt 0
    fisher install $TO_INSTALL
end
