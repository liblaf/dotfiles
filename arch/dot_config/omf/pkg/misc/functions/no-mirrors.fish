function no-mirrors --wraps="env"
    set --function --export PIP_INDEX_URL https://pypi.org/simple
    $argv
end
