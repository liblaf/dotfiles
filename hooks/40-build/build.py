# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "pyyaml>=6,<7"
# ]
# ///

from __future__ import annotations

import argparse
import dataclasses
import io
import json
import logging
import shutil
import subprocess
from collections import defaultdict
from collections.abc import Generator, Iterable, Mapping
from pathlib import Path
from typing import TYPE_CHECKING, Any, Self, cast

import yaml

if TYPE_CHECKING:
    from _typeshed import StrPath, SupportsRead


logger: logging.Logger = logging.getLogger(__name__)


_IGNORE: set[str] = {"README.md"}


@dataclasses.dataclass(slots=True)
class Context:
    output_dir: Path
    packages: dict[str, set[str]] = dataclasses.field(
        default_factory=lambda: defaultdict(set)
    )

    def add_packages(self, packages: Mapping[str, Iterable[str] | None]) -> None:
        for pkg_manager, pkgs in packages.items():
            if not pkgs:
                continue
            self.packages[pkg_manager].update(pkgs)

    def copy_to(self, source: Path, target: Path) -> None:
        target: Path = self.output_dir / target
        assert target.is_relative_to(self.output_dir)
        if target.exists():
            logger.warning("'%s' already exists", target)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, target)


@dataclasses.dataclass(slots=True)
class Module:
    name: str
    path: Path

    @classmethod
    def load(cls, name: str, path: StrPath) -> Self:
        return cls(name=name, path=Path(path))

    @property
    def slug(self) -> str:
        return self.name.replace("/", "-")

    def apply(self, ctx: Context) -> None:
        for source in _walk(self.path):
            self._apply_file(ctx, source)

    def _apply_file(self, ctx: Context, source: Path) -> None:
        if source.name in _IGNORE:
            return
        relative: Path = source.relative_to(self.path)
        for handler in (
            self._apply_data_file,
            self._apply_external_file,
            self._apply_scripts_file,
            self._apply_templates_file,
            self._apply_packages_file,
            self._apply_root_file,
        ):
            if handler(ctx, source, relative):
                return
        self._apply_normal_file(ctx, source, relative)

    def _apply_normal_file(self, ctx: Context, source: Path, relative: Path) -> None:
        ctx.copy_to(source, relative)

    def _apply_data_file(self, ctx: Context, source: Path, relative: Path) -> bool:
        if not (len(relative.parts) == 1 and relative.name.startswith(".data.")):
            return False
        ctx.copy_to(source, Path(".chezmoidata", _with_stem(relative, self.slug)))
        return True

    def _apply_external_file(self, ctx: Context, source: Path, relative: Path) -> bool:
        if not (len(relative.parts) == 1 and relative.name.startswith(".external.")):
            return False
        ctx.copy_to(source, Path(".chezmoiexternals", _with_stem(relative, self.slug)))
        return True

    def _apply_scripts_file(self, ctx: Context, source: Path, relative: Path) -> bool:
        if not relative.is_relative_to(".scripts"):
            return False
        stem: str = _short_stem(relative)
        target: Path = _with_stem(relative, f"{stem}-{self.slug}")
        ctx.copy_to(source, Path(".chezmoiscripts", *target.parts[1:]))
        return True

    def _apply_templates_file(self, ctx: Context, source: Path, relative: Path) -> bool:
        if not relative.is_relative_to(".templates"):
            return False
        ctx.copy_to(source, Path(".chezmoitemplates", *relative.parts[1:]))
        return True

    def _apply_packages_file(self, ctx: Context, source: Path, relative: Path) -> bool:
        if not relative.name.startswith(".packages."):
            return False
        if relative.suffix == ".tmpl":
            process: subprocess.CompletedProcess[str] = subprocess.run(
                ["chezmoi", "execute-template"],
                stdout=subprocess.PIPE,
                check=True,
                input=source.read_text(),
                text=True,
            )
            text: str = process.stdout
        else:
            text: str = source.read_text()
        packages: Any = yaml.safe_load(text)
        ctx.add_packages(packages)
        return True

    def _apply_root_file(self, ctx: Context, source: Path, relative: Path) -> bool:
        if not relative.parts[0].startswith("^"):
            return False
        parts: list[str] = list(relative.parts)
        parts[0] = parts[0].removeprefix("^")
        parts: list[str] = [f"exact_{part}" for part in parts]
        ctx.copy_to(source, Path("dot_cache/exact_dotfiles/exact_root", *parts))
        return True


@dataclasses.dataclass(slots=True)
class Profile:
    modules: list[Module]

    @classmethod
    def load(
        cls,
        stream: SupportsRead[str] | SupportsRead[bytes],
        modules_dir: StrPath = "modules",
    ) -> Self:
        modules_dir: Path = Path(modules_dir)
        profile: Any = yaml.safe_load(stream)
        module_names: list[str] = profile["modules"]
        modules: list[Module] = []
        for module_name in module_names:
            module_path: Path = modules_dir / module_name
            modules.append(Module.load(module_name, module_path))
        return cls(modules=modules)

    def apply(self, output_dir: StrPath) -> None:
        ctx: Context = Context(output_dir=Path(output_dir))
        for module in self.modules:
            module.apply(ctx)
        self.dump_packages(ctx)

    def dump_packages(self, ctx: Context) -> None:
        file: Path = ctx.output_dir / ".chezmoidata" / "gen" / "packages.json"
        obj: Any = {
            "packages": {
                pkg_manager: list(pkgs) for pkg_manager, pkgs in ctx.packages.items()
            }
        }
        file.parent.mkdir(parents=True, exist_ok=True)
        with file.open("w") as fp:
            json.dump(obj, fp)


class Args(argparse.Namespace):
    modules: Path
    output: Path
    profile: io.TextIOWrapper


def parse_args() -> Args:
    parser = argparse.ArgumentParser()
    parser.add_argument("--modules", default="modules", type=Path)
    parser.add_argument("--output", default="home", type=Path)
    parser.add_argument(
        "--profile", default="profiles/cachyos.yaml", type=argparse.FileType("r")
    )
    return cast("Args", parser.parse_args())


def _long_suffix(path: Path) -> str:
    return "".join(path.suffixes)


def _short_stem(path: Path) -> str:
    return path.name.removesuffix(_long_suffix(path))


def _walk(path: Path) -> Generator[Path]:
    for dirpath, _, filenames in path.walk():
        for filename in filenames:
            yield dirpath / filename


def _with_stem(path: Path, stem: str) -> Path:
    suffix: str = _long_suffix(path)
    return path.with_name(f"{stem}{suffix}")


def main() -> None:
    args: Args = parse_args()
    profile: Profile = Profile.load(args.profile, args.modules)
    profile.apply(args.output)


if __name__ == "__main__":
    main()
