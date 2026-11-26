# bojo_demo

Living showcase and end-to-end consumer for [`bojolib`](https://github.com/bojolib) Mojo libraries, built with [`bojo`](https://github.com/bojolib/bojo).

Today it starts with a minimal smoke-test dependency on [`bojolib/bojo_libtemplate`](https://github.com/bojolib/bojo_libtemplate); new sections are added here as core `bojolib` libraries (`io`, `socket`, `task`, `http`, `tls`, …) ship.

## Quickstart

```bash
bojo build --locked
./.out/bojo_demo
```

Expected output:

```text
bojolib demo
canonical: hello, bojolib
alias: hello, mojo
```

`bojo build --locked` verifies `bojo.lock` against `bojo.toml`, fetches pinned commits, materializes `.vendor/`, and builds a self-contained directory in `.out/` (`.out/bojo_demo` plus its bundled Mojo runtime libraries in `.out/lib/`).

## What it demonstrates

### `bojo.toml`

- **Exact remote dependencies** under `[deps-from."<repo-url>"]`: one repository is one package, pinned to an exact `vX.Y.Z` tag.
- **Root-only `[alias]`**: libraries always import dependencies by full canonical module path (`gh.<owner>.<repo>` for `v0.x`/`v1.x`, `v<N>.gh.<owner>.<repo>` for `v2+`), while the root application may shorten any module path in `[alias]`.
- **Root-only `[override]` and `[replace]`**: dependency resolution is strict by default (D69: `bojo` never silently upgrades a diamond conflict). Only the consumer's root `bojo.toml` may pin an override version/commit or redirect a module path to a fork.

```toml
schema = 1

[project]
name    = "bojo_demo"
version = "0.1.0"
entry   = "main.mojo"

[version]
mojo = "1.2.0"

[build]
output = "dir"
strip  = true

[deps-from."https://github.com/bojolib/bojo_libtemplate"]
version = "v0.1.0"

[alias]
"gh.bojolib.bojo_libtemplate" = "greeting"

# Root-only conflict resolution / fork replacement (examples):
#
# [override."gh.bojolib.socket"]
# version = "v0.2.1"
#
# [replace."gh.bojolib.socket"]
# repo    = "https://github.com/example/socket-fork"
# version = "v0.2.1"
```

### `main.mojo`

`main.mojo` imports `greet` both through its canonical module path and through the `greeting` alias declared in `bojo.toml`:

```mojo
from gh.bojolib.bojo_libtemplate import greet as greet_canonical
from greeting import greet


def main():
    print("bojolib demo")
    print("canonical:", greet_canonical("bojolib"))
    print("alias:", greet("mojo"))
```

## Layout

```text
bojo_demo/
├── .github/workflows/ci.yml   # validates, builds (--locked), and runs the demo
├── .gitignore                 # ignores .bojo/, .out/, .vendor/
├── AGENTS.md                  # rules for maintaining the living showcase
├── LICENSE                    # Apache-2.0
├── README.md
├── bojo.lock                  # committed lockfile verified by `bojo build --locked`
├── bojo.toml                  # root project manifest
└── main.mojo                  # showcase entry point
```

Generated directories (`.bojo/`, `.out/`, `.vendor/`) are created on demand by `bojo` and are never committed.

## License

Apache-2.0. See [LICENSE](LICENSE).
