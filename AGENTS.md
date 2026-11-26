# AGENTS.md

Rules for any agent editing `bojo_demo`. One line per rule, English, no prose.

- Keep `bojo_demo` a clean living showcase for `bojolib` libraries; add new showcase sections and dependencies here as libraries (`io`, `socket`, `task`, `http`, `tls`, …) ship.
- Always test changes locally with `bojo validate`, `bojo build`, and running `./.out/bojo_demo`.
- Keep `bojo.lock` committed and in sync with `bojo.toml` (run `bojo update` after dependency changes), and verify reproducible builds with `bojo build --locked`.
- Never commit generated or vendored directories (`.bojo/`, `.out/`, `.vendor/`, or legacy `vendor/`).
- Keep `[alias]`, `[override]`, and `[replace]` declarations root-only in `bojo.toml`; libraries never define them.
- Keep `main.mojo` output clear and deterministic so CI assertions in `.github/workflows/ci.yml` stay reliable.
- Run `bojo fmt` on every Mojo file you touch.
- Write English in code, comments, commits, and docs.
