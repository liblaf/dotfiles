if command --query paru
    function paru
        set --export --function DFT_COLOR always
        command paru $argv
    end
end
