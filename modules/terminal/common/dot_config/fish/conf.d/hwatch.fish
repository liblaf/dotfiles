if status is-interactive
    if type --query hwatch
        # ref: <https://github.com/blacknon/hwatch?tab=readme-ov-file#configuration>
        set --global --export HWATCH "--color --line-number"
        function hwatch --wraps="hwatch"
            set --function --export FORCE_COLOR 1 # ref: <https://force-color.org>
            set --function --export SYSTEMD_COLORS 1
            command hwatch $argv
        end
    end
end
