# Tools/build

Command-line build and packaging for macOS/Windows standalone players.

**Read [docs/architecture/tooling/build-and-packaging.md](../../docs/architecture/tooling/build-and-packaging.md)
first.** That document is the specification: the naming convention, the zip layout, the
player-settings table with sources, preflight failures and fixes, exit codes, the Gatekeeper
note and the open follow-ups. This file only says how to run the code.

## One-time setup

Use Python 3.9 or newer (64-bit recommended), Git and Git LFS. Install the Unity version pinned
in `ProjectSettings/ProjectVersion.txt` and restore LFS assets before building.

Open the project in the Editor once and run **`RootsDance > Build > Create Default Build
Profiles`**. It creates `macOS-Release.asset` and `Windows-Release.asset` under
`Assets/RootsDance/Settings/BuildProfiles/` and applies the release player settings. Idempotent —
re-run it if the settings need to be restored. Normal builds validate settings without running
this generator or saving profile assets automatically.

On a machine without macOS Build Support installed, the menu item logs a warning and skips baking
ARM64 architecture onto the macOS profile instead of aborting — `Windows-Release.asset` and the
global player settings are still created. Re-run it on a Mac (or once the module is installed) to
finish the macOS profile.

On Windows, install **Windows Build Support (IL2CPP)** for that Editor, plus **Visual Studio
2019 or newer** (or Build Tools) with **Desktop development with C++**, MSVC x64/x86 build tools,
and a **Windows SDK 10.0.19041.0 or newer**. The script checks the selected release/development
IL2CPP player variant, compiler/linker and SDK headers, libraries, UCRT and resource compiler.
Unity initializes the Windows profile's platform defaults when it loads the asset with the
module installed; a profile first authored on a Mac does not need manual YAML repair.

## Build and package in one command

```bash
python3 Tools/build/build.py
```

On macOS this defaults to `macOS-Release`; on Windows it defaults to `Windows-Release`.
The Editor must be closed first (batch mode refuses to share the project with a running Editor).

On Windows, from PowerShell in the repository root:

```powershell
py -3 Tools/build/build.py Windows-Release --dry-run
py -3 Tools/build/build.py Windows-Release
py -3 Tools/build/build.py Windows-Release --dev
py -3 Tools/build/build.py Windows-Release --force
```

Unity Hub's versioned installation and the direct installation under Program Files are detected
automatically. For a custom install, point at the executable, not the Editor folder:

```powershell
py -3 Tools/build/build.py Windows-Release --unity "D:\Unity\6000.3.22f1\Editor\Unity.exe"
```

`UNITY_EDITOR` can also specify the executable. Build Windows on Windows and macOS on macOS;
cross-compilation is not supported. Extract the entire Windows zip and keep the `.exe`, DLLs
and `*_Data` directory together; the included `README.txt` explains how to launch it.

**Windows validation status:** implementation and script tests are in place; an actual Windows
IL2CPP build and player launch remain **UNVERIFIED** until run on a Windows machine.

## Command reference

| Command | Effect |
|---|---|
| `python3 Tools/build/build.py macOS-Release` | Build and package the named profile. `PROFILE` defaults to `macOS-Release` on Mac and `Windows-Release` on Windows. |
| `python3 Tools/build/build.py --dev` | Development build (`BuildOptions.Development \| AllowDebugging`, LZ4 instead of LZ4HC); zip stem gets a `-dev` suffix. |
| `python3 Tools/build/build.py --package-only` | Package the player in `Builds/<PROFILE>/` using its saved `build-info.json`; preserve its original commit, version, date and development flag. No Unity installation is needed. |
| `python3 Tools/build/build.py --dry-run` | Print the build plan and exit without building or packaging. Combined with `--package-only`, print the package plan from the saved manifest instead. |
| `python3 Tools/build/build.py --force` | Overwrite an existing zip of the same name (the script otherwise refuses and exits 1 — checked before the build runs, not just before packaging). |
| `python3 Tools/build/build.py --output-dir DIR` | Write the zip to `DIR` instead of `Builds/`. |
| `python3 Tools/build/build.py --unity PATH` | Use this Unity Editor binary instead of the auto-detected one. |
| `python3 Tools/build/build.py --audit` | Run the asset size audit instead of building (`RootsDance.Editor.Build.AssetSizeAudit.RunFromCommandLine`); prints a table of violations from `Logs/asset-audit.json`. Needs the Editor closed, like a build. |
| `python3 Tools/build/build.py --audit --fix` | Same, but rewrite the fixable importers/prefabs and reimport before reporting. `--fix` without `--audit` is a usage error. |
| `python3 Tools/build/build.py --audit --dry-run` | Print the audit command line and exit `0` without launching Unity. |
| `python3 Tools/build/build.py --strict` | Fail the build (exit `2`) if the pre-build asset size audit finds any *fixable* violation, instead of only logging it. Report-only rules (non-`fixable` violations such as an intentionally uncompressed texture or a pipeline-owned model) are still logged but never gate the build — `--audit --fix` has no action for them. |
| `python3 Tools/build/build.py --skip-audit` | Skip the pre-build audit entirely (`-rdSkipAudit`); use for a quick local build when you already know the asset state. |
| `python3 Tools/build/build.py --max-zip-mb N` | After packaging, exit `4` if the zip is larger than `N` MB. The zip is still written and kept — this is a size gate, not a packaging failure. |
| `python3 Tools/build/build.py --no-color` | Plain text output, no ANSI colour codes (same effect as setting `NO_COLOR`). |
| `python3 Tools/build/build.py --keep-churn` | Do not restore the files Unity re-serialises during a build (`ProjectSettings/ProjectSettings.asset`, `Assets/RootsDance/Fonts/`, `Assets/RootsDance/Settings/HDRP/`) — see "Post-build churn" in build-and-packaging.md. |

Flags combine. On Windows use `py -3` in place of `python3`, for example
`py -3 Tools/build/build.py Windows-Release --dev --dry-run`.

## What you see while it builds

Batch mode itself prints nothing, so `build.py` follows the Unity log as it grows and turns known
`[BuildScript]`/`[AssetSizeAudit]` marker lines into a phase name, a percent and, once a previous
run of the same profile has recorded phase timings under `Builds/.history/<profile>/timings.json`,
an ETA for the remaining phases. On an interactive terminal this is one status line that rewrites
itself in place (`Building scenes [############--------] 62%  1m 12s  eta ~45s  (scene 9/16)`);
piped output or a CI log is not a TTY, so instead each phase transition prints once, as its own
line, so the log stays readable and diffable. `-v`/`--verbose` also echoes every raw
`[BuildScript]`/`[AssetSizeAudit]` log line as it arrives.

Colour follows the [NO_COLOR](https://no-color.org) convention: on by default on a TTY, off when
piped, and always off with `--no-color` or `NO_COLOR` set in the environment.

Every successful build saves `Builds/<PROFILE>/build-info.json` alongside the player before
packaging. Keep that manifest with the player: `--package-only` reads it instead of the current
checkout's Git state or Player Settings, and retains the original zip name even on another day.
Missing, invalid or mismatched metadata exits `1` and asks you to rebuild; older builds without a
manifest must be rebuilt rather than assigned guessed provenance. A saved development build
keeps its `-dev` suffix without passing `--dev`; passing `--dev` for a saved release build is an
error because packaging cannot change the player into a development build.

A build succeeds only when its fresh log contains the requested profile's
`[BuildScript] <profile>: result=Succeeded` marker. The script clears the previous log before
launching Unity, rejects a zero exit without that marker, and accepts a nonzero shutdown exit
when the marker confirms the build succeeded.

## What's excluded from the zip

Unity's IL2CPP debug sidecars — `*_BackUpThisFolder_ButDontShipItWithYourGame` (incremental-build
cache) and `*_BurstDebugInformation_DoNotShip` (Burst's native debug symbols) — are dropped before
packaging; their own folder names say not to ship them. The Burst folder holds the symbols needed
to symbolicate a crash from a shared build and only ever exists in `Builds/<PROFILE>/`, which the
next `build.py` run deletes — copy it out first if you'll need it later.

The bigger factor in the zip's size, as of the 2026-09-03 verification build (commit `6108177a`),
is the asset size audit fixing 302 violations — mostly scattered rock/prop prefabs that were
`Batching Static` and copying every instance's mesh into the scene file (1,479.8 MB in one
`level1.resS` alone) — plus the texture and audio import rules below. That took the player from
2,791.8 MB unstaged / 2,322.2 MB zipped on 2026-08-30 to 665 MB unstaged / **512.1 MB zipped**
(−78%) with the audit clean (0 fixable violations left; 3 remaining ones are pipeline-owned meshes,
report-only by design). Full details, including the packed-size breakdown by asset type:
build-and-packaging.md's ["Asset size policy and audit"](../../docs/architecture/tooling/build-and-packaging.md#asset-size-policy-and-audit)
and ["Zip layout"](../../docs/architecture/tooling/build-and-packaging.md#zip-layout) sections.

## Exit codes

| Code | Meaning |
|---|---|
| `0` | Success. |
| `1` | Preflight check or usage error — the message names the fix. |
| `2` | The Unity build failed — check the log path the script prints. |
| `3` | Packaging failed. |
| `4` | Zip larger than `--max-zip-mb` (the zip is kept). |

## Tests

```bash
python3 -m unittest discover -s Tools/build
```

Stdlib `unittest`, no third-party dependencies. Covers `Tools/build/naming.py` — the naming and
version-parsing logic — plus the pure/stubbable helpers in `Tools/build/build.py`: `git_state`,
`editor_is_running`, `resolve_unity` and `stageable_entries`. The build-success check itself is
`progress.success_marker_pattern` matched against `PhaseTracker.success_marker`, covered by
`test_progress.py`.
`test_build.py` covers build orchestration, fresh-log success checks and manifest provenance,
including package-only validation, dry runs, the `--audit`/`--strict`/`--skip-audit` command
construction, the `--audit --dry-run` plan, the stale-`asset-audit.json` guard, the
`--max-zip-mb` size gate, and post-build churn restoration (including the
`Assets/RootsDance/Settings/HDRP/` allowlist entries and the unknown-baseline skip). These tests
do not compile or launch a Unity player; a real build and player smoke test remain separate
checks.
`test_windows.py` covers Windows discovery, toolchain and process checks with mocks/fixtures,
plus Windows zip packaging. On Windows run `py -3 -m unittest discover -s Tools/build`.
`test_console.py` covers `console.py`'s colour/`NO_COLOR` detection, the in-place status line and
table rendering, and the `fmt_duration`/`fmt_bytes`/`bar` helpers.
`test_progress.py` covers `progress.py`'s `LogFollower` (incremental reads, truncation, tailing)
and `PhaseTracker` (marker matching, strict-phase ordering, scene progress, percent/ETA, error
collection).
`test_history.py` covers `history.py`'s timings round-trip, previous-report archiving, and the
`report_delta` computation used for the size-by-type and changed-assets tables.
