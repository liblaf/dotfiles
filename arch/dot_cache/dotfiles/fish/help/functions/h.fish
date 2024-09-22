function h
    if test (count $argv) -eq 0
        bat --language=help --file-name="Help"
        return
    end
    set --function output "$($argv --help 2>&1)"
    if test $status -ne 0
        set --function output "$($argv -h 2>&1)"
    end
    if test $status -ne 0
        set --function output "$($argv help 2>&1)"
    end
    set --function status_ $status
    if test $status_ -ne 0
        return $status_
    end
    echo "$output" | bat --language=help --file-name="$argv"
end
