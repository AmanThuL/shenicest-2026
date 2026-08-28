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

On a machine without macOS Build Support installed, the menu item logs a warning and skips baking
ARM64 architecture onto the macOS profile instead of aborting — `Windows-Release.asset` and the
global player settings are still created. Re-run it on a Mac (or once the module is installed) to
finish the macOS profile.

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
| `python3 Tools/build/build.py --force` | Overwrite an existing zip of the same name (the script otherwise refuses and exits 1 — checked before the build runs, not just before packaging). |
| `python3 Tools/build/build.py --output-dir DIR` | Write the zip to `DIR` instead of `Builds/`. |
| `python3 Tools/build/build.py --unity PATH` | Use this Unity Editor binary instead of the auto-detected one. |

Flags combine, e.g. `python3 Tools/build/build.py Windows-Release --dev --dry-run`.

## What's excluded from the zip

Unity's IL2CPP debug sidecars — `*_BackUpThisFolder_ButDontShipItWithYourGame` (incremental-build
cache) and `*_BurstDebugInformation_DoNotShip` (Burst's native debug symbols) — are dropped before
packaging; their own folder names say not to ship them. That's the whole reason the zip is roughly
40% the size of `Builds/<PROFILE>/` on disk (960.9 MB → 398.6 MB on the verified macOS-Release
build). The Burst folder holds the symbols needed to symbolicate a crash from a shared build and
only ever exists in `Builds/<PROFILE>/`, which the next `build.py` run deletes — copy it out first
if you'll need it later. Full details: [build-and-packaging.md, "Zip
layout"](../../docs/architecture/tooling/build-and-packaging.md#zip-layout).

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

Stdlib `unittest`, no third-party dependencies. Covers `Tools/build/naming.py` — the naming and
version-parsing logic — plus the pure/stubbable helpers in `Tools/build/build.py`: `git_state`,
`editor_is_running`, `resolve_unity`, `stageable_entries` and `build_succeeded`. It does not cover
the Unity build or the packaging step themselves.
