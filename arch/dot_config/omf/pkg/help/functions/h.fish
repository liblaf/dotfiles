function h
    set --function output "$($argv --help 2>&1)"
    if test -z "$output"
        set --function output "$($argv -h 2>&1)"
    end
    if test -z "$output"
        set --function output "$($argv help 2>&1)"
    end
    if test -z "$output"
        return 1
    end
    echo "$output" | bat --language=help --file-name="$argv"
end
