set --local mode (gsettings get org.gnome.system.proxy mode | tr --delete "'")
if test "$mode" = manual
    proxy-on
else if test "$mode" = none
    proxy-off
end
