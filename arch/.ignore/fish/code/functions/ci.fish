function ci --description="code interactive"
    set --function path_ (zoxide query --interactive)
    if test -e "$path_"
        direnv exec "$path_" code "$path_"
    end
end
