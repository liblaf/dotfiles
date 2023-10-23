set --global --prepend fish_function_path $__fish_config_dir/pkg/*/functions

if not status is-interactive
    exit
end

set --global --prepend fish_complete_path $__fish_config_dir/pkg/*/completions

for file in $__fish_config_dir/pkg/*/init.fish
    source $file
end
