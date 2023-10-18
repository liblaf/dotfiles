function h --argument-names cmd
    if whatis $cmd
        man $cmd
    else
        set --function output "$($cmd --help 2>&1)"
        if test -z "$output"
            set --function output "$($cmd -h 2>&1)"
        end
        if test -z "$output"
            set --function output "$($cmd help 2>&1)"
        end
        if test -z "$output"
            return 1
        end
        echo "$output" | bat --language=help --file-name="$cmd"
    end
end
