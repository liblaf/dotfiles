if not status is-interactive
    and not type --query trash-cli
end

# ref: <https://github.com/andreafrancia/trash-cli#but-sometimes-i-forget-to-use-trash-put-really-cant-i>
function rm
    echo "This is not the command you are looking for."
    false
end
