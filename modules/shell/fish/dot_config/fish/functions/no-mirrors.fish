function no-mirrors --wraps="env"
    # https://pip.pypa.io/en/stable/topics/configuration/#environment-variables
    set --function --export PIP_INDEX_URL https://pypi.org/simple
    # https://docs.npmjs.com/cli/v10/using-npm/config
    set --function --export npm_config_registry https://registry.npmjs.org
    $argv
end
