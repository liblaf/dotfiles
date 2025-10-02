from typing import Any

try:
    from icecream import install
except ImportError:
    import builtins

    def ic(*args) -> Any:
        if not args:
            return None
        if len(args) == 1:
            return args[0]
        return args

    builtins.ic = ic  # pyright: ignore[reportAttributeAccessIssue]
else:
    install()
