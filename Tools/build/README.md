# Tools/build

Command-line build and packaging for macOS/Windows standalone players.

**Read [docs/architecture/tooling/build-and-packaging.md](../../docs/architecture/tooling/build-and-packaging.md)
first.** That document is the specification: the naming convention, the zip layout, the
player-settings table with sources, preflight failures and fixes, exit codes, the Gatekeeper
note and the open follow-ups. This file only says how to run the code.

## One-time setup

Open the project in the Editor once and run **`RootsDance > Build > Create Default Build
Profiles`**. It creates `macOS-Release.asset` and `Windows-Release.asset` under
`Assets/RootsDance/Settings/BuildProfiles/` and applies the release player settings. Idempotent —
re-run it any time to re-apply the settings to an existing profile.

## Build and package in one command

```bash
python3 Tools/build/build.py
```

Defaults to `macOS-Release`. The Editor must be closed first (batch mode refuses to share the
project with a running Editor).

## Command reference

| Command | Effect |
|---|---|
| `python3 Tools/build/build.py macOS-Release` | Build and package the named profile. `PROFILE` defaults to `macOS-Release`. |
| `python3 Tools/build/build.py --dev` | Development build (`BuildOptions.Development \| AllowDebugging`, LZ4 instead of LZ4HC); zip stem gets a `-dev` suffix. |
| `python3 Tools/build/build.py --package-only` | Skip the Unity build; zip whatever is already in `Builds/<PROFILE>/`. |
| `python3 Tools/build/build.py --dry-run` | Print the resolved Unity path, the exact command and the computed zip name; exit 0 without building or packaging. |
| `python3 Tools/build/build.py --force` | Overwrite an existing zip of the same name (the script otherwise refuses and exits 1). |
| `python3 Tools/build/build.py --output-dir DIR` | Write the zip to `DIR` instead of `Builds/`. |
| `python3 Tools/build/build.py --unity PATH` | Use this Unity Editor binary instead of the auto-detected one. |

Flags combine, e.g. `python3 Tools/build/build.py Windows-Release --dev --dry-run`.

## Exit codes

| Code | Meaning |
|---|---|
| `0` | Success. |
| `1` | Preflight check or usage error — the message names the fix. |
| `2` | The Unity build failed — check the log path the script prints. |
| `3` | Packaging failed. |

## Tests

```bash
python3 -m unittest discover -s Tools/build
```

Stdlib `unittest`, no third-party dependencies. Covers `Tools/build/naming.py` only — the naming
and version-parsing logic — not the Unity build or the packaging step.
