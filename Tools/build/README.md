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

Flags combine. On Windows use `py -3` in place of `python3`, for example
`py -3 Tools/build/build.py Windows-Release --dev --dry-run`.

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
`editor_is_running`, `resolve_unity`, `stageable_entries` and `build_succeeded`.
`test_build.py` covers build orchestration, fresh-log success checks and manifest provenance,
including package-only validation and dry runs. These tests do not compile or launch a Unity
player; a real build and player smoke test remain separate checks.
`test_windows.py` covers Windows discovery, toolchain and process checks with mocks/fixtures,
plus Windows zip packaging. On Windows run `py -3 -m unittest discover -s Tools/build`.
