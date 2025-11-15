from typing import Any


def _install_grapes_icecream() -> bool:
    try:
        from liblaf.grapes.icecream import install
    except ImportError:
        return False
    else:
        install()
        return True


def _install_icecream() -> bool:
    try:
        from icecream import install
    except ImportError:
        return False
    else:
        install()
        return True


def _install_noop_ic() -> None:
    import builtins

    def ic(*args, **_kwargs) -> Any:
        match len(args):
            case 0:
                return None
            case 1:
                return args[0]
            case _:
                return args

    builtins.ic = ic  # pyright: ignore[reportAttributeAccessIssue]


_ = _install_grapes_icecream() or _install_icecream() or _install_noop_ic()
