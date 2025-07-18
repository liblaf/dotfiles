from typing import Any

# ref: <https://github.com/gruns/icecream>
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

    setattr(builtins, "ic", ic)  # noqa: B010
else:
    install()
