"""Living showcase for bojolib libraries.

Demonstrates consuming a published bojolib package via both its canonical
module path (`gh.bojolib.bojo_libtemplate`) and a project-local `[alias]`
(`greeting`) declared in `bojo.toml`.

Build and run with:
    bojo build --locked
    ./.out/bojo_demo
"""

from gh.bojolib.bojo_libtemplate import greet as greet_canonical
from greeting import greet


def main():
    print("bojolib demo")
    print("canonical:", greet_canonical("bojolib"))
    print("alias:", greet("mojo"))
