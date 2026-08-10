function paraview --wraps paraview
    set --local logfile (mktemp --suffix='-paraview.log')
    function __paraview_try --inherit-variable logfile
        set --local sep (contains --index ':::' $argv)
        set --local cmd $argv[1..(math $sep - 1)]
        set --local args $argv[(math $sep + 1)..-1]
        if command $cmd --version >/dev/null 2>"$logfile"
            nohup $cmd $args &>/dev/null &
            disown
        else
            return 1
        end
    end
    if __paraview_try paraview ::: $argv
        rm --force "$logfile"
        return 0
    else if __paraview_try flatpak run org.paraview.ParaView ::: $argv
        rm --force "$logfile"
        return 0
    else
        set --local paraview_status $status
        cat "$logfile" >&2
        rm --force "$logfile"
        return $paraview_status
    end
end
