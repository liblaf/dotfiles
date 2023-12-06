# https://code.visualstudio.com/docs/remote/troubleshooting#_connect-to-a-remote-host-from-the-terminal

function cri --argument-names remote --description="code remote interactive"
    set --function _path (zoxide query --interactive)
    if test -e "$_path"
        code --remote="ssh-remote+$remote" "$_path"
    end
end
