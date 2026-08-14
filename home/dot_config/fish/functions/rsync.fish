if status is-interactive
    and type --query rsync
    alias rsync 'rsync --info="progress2" --archive --compress --stats --human-readable --progress --itemize-changes'
end
