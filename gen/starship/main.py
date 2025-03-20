import functools
import os
import subprocess as sp
from collections.abc import Mapping
from pathlib import Path
from typing import Any

import tomlkit

type StarshipConfig = Mapping[str, Any]


def _merge_binary(a: Mapping, b: Mapping) -> dict:
    result = dict(a)
    for key, value in b.items():
        if key in a and isinstance(a[key], Mapping):
            result[key] = _merge_binary(a[key], value)
        else:
            result[key] = value
    return result


def merge(*configs: Any) -> Any:
    return functools.reduce(_merge_binary, configs, {})


def load_preset(preset: str) -> StarshipConfig:
    proc: sp.CompletedProcess[str] = sp.run(
        ["starship", "preset", preset], stdout=sp.PIPE, check=True, text=True
    )
    config: StarshipConfig = tomlkit.loads(proc.stdout)
    return config


def load_file(fpath: str | os.PathLike[str]) -> StarshipConfig:
    fpath = Path(fpath)
    with fpath.open() as fp:
        return tomlkit.load(fp)


def save_config(fpath: str | os.PathLike[str], config: StarshipConfig) -> None:
    fpath = Path(fpath)
    with fpath.open("w") as fp:
        fp.write("""\
# This file is @generated by `gen/starship/main.py`.
# DO NOT EDIT!
#:schema https://starship.rs/config-schema.json
""")
        tomlkit.dump(config, fp, sort_keys=True)


def main() -> None:
    base_dir: Path = Path(__file__).parent
    dot_config = Path("arch/dot_config/")
    bracketed_segments: StarshipConfig = load_preset("bracketed-segments")
    nerd_font_symbols: StarshipConfig = load_preset("nerd-font-symbols")
    custom: StarshipConfig = load_file(base_dir / "starship.custom.toml")
    remote: StarshipConfig = load_file(base_dir / "starship.remote.toml")
    config: StarshipConfig = merge(bracketed_segments, nerd_font_symbols, custom)
    save_config(dot_config / "starship.toml", config)
    config = merge(config, remote)
    save_config(dot_config / "exact_starship" / "remote.toml", config)


if __name__ == "__main__":
    main()
