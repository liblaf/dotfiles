function ci --description="code interactive"
    set --function _path (zoxide query --interactive)
    if test -e "$_path"
        direnv exec "$_path" code "$_path"
    end
end
