if status is-interactive
    and type --query goose
    abbr --add gc --position command 'goose run --recipe commit --interactive --no-session'
end
