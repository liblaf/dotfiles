function ci --description="code interactive"
    set --function _path (zoxide query --interactive)
    pushd "$_path"
    code .
    popd
end
