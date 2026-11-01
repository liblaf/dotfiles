set --local mode (gsettings get org.gnome.system.proxy mode | tr --delete "'")
if test "$mode" = manual
    proxy-on
else if test "$mode" = none
    proxy-off
end

if status is-interactive
    and type --query direct.sh
    for app in chsrc rate-mirrors
        if type --query $app
            function $app --wraps $app --inherit-variable app
                direct.sh $app $argv
            end
        end
    end
end
