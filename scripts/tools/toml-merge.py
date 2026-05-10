#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "tomlkit>=0.15.0",
# ]
# ///
import argparse
import sys
from collections.abc import Mapping
from pathlib import Path

import tomlkit
import tomllib


class Args(argparse.Namespace):
    files: list[Path]


def merge(first: Mapping, *dicts: Mapping) -> dict:
    result: dict = dict(first)
    for d in dicts:
        for key, value in d.items():
            if (
                key in result
                and isinstance(result[key], Mapping)
                and isinstance(value, Mapping)
            ):
                result[key] = merge(result[key], value)
            else:
                result[key] = value
    return result


def parse_args() -> Args:
    parser: argparse.ArgumentParser = argparse.ArgumentParser()
    parser.add_argument("files", nargs="+", type=Path)
    return parser.parse_args(namespace=Args())


def main() -> None:
    args: Args = parse_args()
    documents: list[Mapping] = []
    for file in args.files:
        with file.open("rb") as fp:
            documents.append(tomllib.load(fp))
    merged: dict = merge(*documents)
    tomlkit.dump(merged, sys.stdout, sort_keys=True)


if __name__ == "__main__":
    main()
