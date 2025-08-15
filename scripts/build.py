# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "attrs",
#     "cappa",
#     "loguru",
#     "msgspec[yaml]",
#     "pydantic",
# ]
# ///

import shutil
from pathlib import Path
from typing import Annotated, Self

import attrs
import cappa
import msgspec
import pydantic
from cappa import Arg
from loguru import logger


class ProfileConfig(pydantic.BaseModel):
    modules: list[str]


@attrs.define
class Module:
    path: Path

    @property
    def name(self) -> str:
        return self.path.name

    def copy_to(self, target_dir: Path) -> None:
        for dirpath, _, filenames in self.path.walk():
            for filename in filenames:
                file: Path = dirpath / filename
                target: Path = target_dir / self.target_file(file)
                if target.exists():
                    logger.warning(f"'{target}' already exists")
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(file, target)

    def target_file(self, source: Path) -> Path:  # noqa: PLR0911
        relative: Path = source.relative_to(self.path)
        if relative.parts[0].startswith("^"):
            # '^etc/pacman.conf' -> 'dot_cache/dotfiles/root/etc/pacman.conf'
            return Path("dot_cache/exact_dotfiles/root").joinpath(
                relative.parts[0].removeprefix("^"), *relative.parts[1:]
            )
        if len(relative.parts) == 1:
            if relative.name.startswith(".data."):
                # '.data.*' -> '.chezmoidata/{module}.*'
                return Path(".chezmoidata") / with_stem(relative, self.name)
            if relative.name.startswith(".external."):
                # '.external.*' -> '.chezmoiexternal/{module}.*'
                return Path(".chezmoiexternals") / with_stem(relative, self.name)
            if relative.name.startswith(".packages."):
                # '.packages.*' -> '.packages/{module}.*'
                return Path(".packages") / with_stem(relative, self.name)
        if relative.is_relative_to(".scripts"):
            stem: str = short_stem(relative)
            target: Path = with_stem(relative, f"{stem}-{self.name}")
            return Path(".chezmoiscripts").joinpath(*target.parts[1:])
        if relative.is_relative_to(".templates"):
            return Path(".chezmoitemplates").joinpath(*relative.parts[1:])
        return relative


@attrs.define
class Profile:
    modules: list[Module] = attrs.field(factory=list)

    @classmethod
    def load(cls, file: Path, modules_dir: Path = Path("modules")) -> Self:
        config: ProfileConfig = ProfileConfig.model_validate(
            msgspec.yaml.decode(file.read_bytes())
        )
        modules: list[Module] = [
            Module(path=modules_dir / module) for module in config.modules
        ]
        return cls(modules=modules)

    def copy_to(self, target_dir: Path = Path("home")) -> None:
        shutil.rmtree(target_dir, ignore_errors=True)
        for module in self.modules:
            module.copy_to(target_dir)


@cappa.command
@attrs.define
class App:
    modules_dir: Annotated[Path, Arg(long=True, default=Path("modules"))]
    profile: Annotated[Path, Arg(default=Path("profiles/cachyos.yaml"))]
    target_dir: Annotated[Path, Arg(long=True, default=Path("home"))]

    def __call__(self) -> None:
        profile: Profile = Profile.load(self.profile, modules_dir=self.modules_dir)
        profile.copy_to(self.target_dir)


def long_suffix(path: Path) -> str:
    return "".join(path.suffixes)


def short_stem(path: Path) -> str:
    return path.name.removesuffix(long_suffix(path))


def with_stem(path: Path, stem: str) -> Path:
    suffix: str = long_suffix(path)
    return path.with_name(f"{stem}{suffix}")


if __name__ == "__main__":
    cappa.invoke(App)
