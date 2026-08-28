# Build and packaging: from commit to a shareable zip

> **Scope:** `python3 Tools/build/build.py` — headless standalone builds for *Where the Roots
> Dance*, and their packaging into a zip named after the exact commit that produced them.
> **Applies to:** anyone producing a build to share (jam submission, playtest hand-off) or a
> teammate reading the profile/player-settings rationale.
> **Status:** written 2026-08-28 from the design spec
> (`docs/superpowers/specs/2026-08-28-build-and-packaging-design.md`), alongside the
> implementation. macOS is the verified path; Windows is designed but untested (see Open
> follow-ups).

Owning guideline: [08 — Testing, tooling and IDE setup](../../guidelines/08-testing-tooling.md)
holds the project's build-profile and command-line-build rules (profiles live under
`Assets/RootsDance/Settings/BuildProfiles/`, one platform per invocation, `Builds/` is
gitignored). This document does not restate those rules — it documents the concrete system built
on top of them: profile generation from code, the naming convention, the packaging step and the
player settings the profiles carry.

## What it is

`Tools/build/build.py` is a CLI that runs three phases in order — preflight checks, a headless
Unity build via `-executeMethod`, and packaging the build output into a zip — and prints exit
codes a CI system could act on, even though no CI is configured for this project yet. It replaces
hand-run `-batchmode -activeBuildProfile` invocations for anyone who wants a shareable artifact
rather than just a `Builds/<Profile>/` folder.

```
python3 Tools/build/build.py [PROFILE] [--dev] [--package-only] [--dry-run] [--force]
                             [--output-dir DIR] [--unity PATH]
```

`PROFILE` defaults to `macOS-Release`. Command usage lives in
[`Tools/build/README.md`](../../../Tools/build/README.md); this document is the specification it
points back to.

## Naming convention

```
<Base>_<Platform>_v<Version>_<YYYYMMDD>_<shortsha>[-dirty][-dev].zip

RootsDance_macOS_v0.1.0_20260828_fb56640.zip
RootsDance_macOS_v0.1.0_20260828_fb56640-dirty.zip
RootsDance_Windows_v0.1.0_20260828_fb56640-dev.zip
```

| Field | Source |
|---|---|
| `Base` | The constant `RootsDance` (`Tools/build/naming.py: BASE_NAME`). **Not** `productName` — see Open follow-ups. |
| `Platform` | Derived from the profile name's prefix: `macOS-*` → `macOS`, `Windows-*` → `Windows`. |
| `Version` | `bundleVersion`, parsed read-only from `ProjectSettings/ProjectSettings.asset` (currently `0.1.0`). The script never writes this file. |
| `YYYYMMDD` | Local date, snapshotted once in `main()` **before** the Unity build runs, not after it finishes. A `--package-only` run (no build phase) stamps today regardless of how old the build itself is. |
| `shortsha` | `git rev-parse --short HEAD` (7 characters). |
| `-dirty` | Appended when `git status --porcelain` is non-empty, snapshotted at that same point — before the build, not after. Doing it early rather than at package time is deliberate: Unity's own re-serialization of project files during a build could otherwise tag a zip `-dirty` for a build that actually came from a clean commit. |
| `-dev` | Appended when `--dev` was passed. |

The convention is implemented in exactly one place — `Tools/build/naming.py`, pure functions, no
I/O. The Unity side never computes a name; it only ever writes to `Builds/<ProfileName>/`, so
there is no second copy of the convention to drift out of sync.

Two builds made on the same day from the same clean commit produce the same zip name. The script
treats that as a feature: it refuses to silently overwrite an existing zip and exits `1` naming
the file, unless `--force` is passed. That check runs right after the plan is resolved, before the
(possibly 10–25 minute) Unity build starts — not after — since two same-day builds from the same
commit is the normal pattern and failing only at packaging time would burn a full build for
nothing.

## Zip layout

The zip root is a single folder named after the zip stem (no extension), so unzipping never
scatters files into whatever directory it was unzipped into:

```
RootsDance_macOS_v0.1.0_20260828_fb56640/
├── RootsDance.app
├── build-info.json      # product, version, commit, dirty, development, profile, platform, unityVersion, builtAt
└── README.txt           # how to run it, including the Gatekeeper quarantine workaround
```

Packaging stages into `Builds/.staging/<stem>/` first, writes `build-info.json` and `README.txt`
into it, archives, then removes the staging directory — on success and on failure, so
`Builds/.staging/` never lingers between runs. `build-info.json` carries `product, version, commit,
dirty, development, profile, platform, unityVersion, builtAt` — the date and the `-dirty` flag are
both computed once in `main()`, before the Unity build runs, not at package time: Unity's own
re-serialization of project files during a build could otherwise tag a zip `-dirty` for a build
that was actually made from a clean commit.

**Why not Python's `zipfile` on macOS:** it silently drops the symlinks and executable bits inside
a `.app` bundle, and the unzipped app fails to launch. macOS packaging shells out to
`ditto -c -k --sequesterRsrc --keepParent` instead. Windows output is a plain folder with no
symlinks, so `zipfile` with `ZIP_DEFLATED` is used there.

**What's excluded, and why.** Every build directory also contains two folders Unity's IL2CPP
backend writes next to the player itself: `<ProductName>_BackUpThisFolder_ButDontShipItWithYourGame`
(an incremental-build cache) and `<ProductName>_BurstDebugInformation_DoNotShip` (Burst's native
debug symbols). Their own folder names say not to ship them, so `stageable_entries()` in
`Tools/build/build.py` drops both by suffix match before staging (the prefix varies with
`productName`, so matching is by suffix, not exact name) — the run prints a
`skip: <name> (Unity debug sidecar, not shipped)` line for each one it drops. This is the entire
reason the zip is roughly 40% the size of `Builds/<PROFILE>/` on disk — the verified macOS-Release
build was 960.9 MB unstaged, 398.6 MB zipped.

**Symbolication warning:** `_BurstDebugInformation_DoNotShip` holds the native/IL2CPP debug symbols
needed to symbolicate a crash report from a build you've shared. It is never copied into the zip,
and it only ever exists in `Builds/<PROFILE>/` — which the next `build.py` run deletes
(`shutil.rmtree(build_dir, ...)` at the top of a non-`--package-only` run in `main()`). Copy that
folder out of `Builds/<PROFILE>/` before running `build.py` again if you might need to symbolicate a
crash from this specific build later.

## One-time setup

Open the project in the Editor once and run **`RootsDance > Build > Create Default Build
Profiles`**. It creates `macOS-Release.asset` and `Windows-Release.asset` under
`Assets/RootsDance/Settings/BuildProfiles/` (guideline 08's required location) and applies the
player settings in the table below to `NamedBuildTarget.Standalone`. It is idempotent — an
existing profile asset is loaded and updated in place rather than duplicated, so re-running it
after a settings change is the way to re-apply that change.

On a machine with no macOS Build Support module installed (e.g. a Windows-only teammate), the
generator logs a warning and skips baking ARM64 architecture onto `macOS-Release.asset` instead of
throwing — `Windows-Release.asset` and the global player settings are still created/applied. Run
the menu item again on a Mac (or once this machine has the module) to finish the macOS profile.

Both profiles set `overrideGlobalScenes = false`, so both inherit whatever is enabled in
`ProjectSettings/EditorBuildSettings.asset` instead of keeping a second copy that can drift out of
sync with it — `build.py` prints that list at preflight. See Open follow-ups for what is enabled
there today.

There are **no separate `-Dev` profile assets** — see "Why the scripting backend is global" below
for why, and the "Dev builds" row of the settings table for what changes instead.

## Commands

```bash
python3 Tools/build/build.py                       # macOS-Release, build + package
python3 Tools/build/build.py --dev                  # development build, zip tagged -dev
python3 Tools/build/build.py --package-only         # zip an existing Builds/<PROFILE>/, skip Unity
python3 Tools/build/build.py --dry-run              # print the plan, build and touch nothing
python3 Tools/build/build.py --force                # overwrite an existing zip of the same name
```

Full flag reference and combinations: [`Tools/build/README.md`](../../../Tools/build/README.md).

Under the hood, phase 2 is the same shape as guideline 08's `-executeMethod` escape hatch, run
non-interactively:

```
-batchmode -quit -projectPath <repo root>
-executeMethod RootsDance.Editor.Build.BuildScript.BuildFromCommandLine
-rdProfile <ProfileName> -rdOutput <path> [-rdDev]
-logFile Logs/build-<profile>.log
```

Batch mode prints nothing to the terminal while it works, so the script prints an elapsed-time
heartbeat and the log path up front — with an explicit warning that a first IL2CPP build can take
10–25 minutes.

## Profile and player settings

Applied **globally** for `NamedBuildTarget.Standalone` by the generator — not per profile — for
the reason in the next section, with one exception: target architecture, which cannot be global
(see below). The global settings land in `ProjectSettings/ProjectSettings.asset` and are committed
once, in their own `chore(settings):` commit, separately from this doc and the code.

| Setting | Value | Source / reason |
|---|---|---|
| Scripting Backend | IL2CPP | "Overall better runtime performance" at the cost of build time — `docs/reference/performance/ebook-optimize-…-consoles-and-pcs…md`. |
| IL2CPP Code Generation | `Il2CppCodeGeneration.OptimizeSpeed` (Faster runtime) | Trades build size for runtime speed. |
| C++ Compiler Configuration | `Il2CppCompilerConfiguration.Release` | `Master` costs far more build time than it returns for a jam-scale project. |
| Managed Stripping Level | **Minimal** | The IL2CPP default and "least likely to cause unexpected runtime behavior" — Odin Inspector and the Input System are both reflection-driven and a more aggressive level can strip code they need at runtime. `Low` is **marked for future deprecation** in the 6.3 docs and must never be used. Source: `docs/reference/scripting/manual-managed-code-stripping-configure.md`. |
| Compression Method | `CompressWithLz4HC` for release, `CompressWithLz4` for `--dev` (set via `BuildOptions` in `BuildScript.cs` at build time, not baked into the profile asset) | LZ4HC is "slower to build but produces better results for release builds"; the Standalone default is no compression at all. `--dev` trades some of that ratio back for faster iteration builds. Source: `docs/reference/testing-tooling/manual-build-profiles-reference.md`. |
| Graphics API | Metal only, Auto Graphics API off | Avoids generating shader variants for graphics APIs this project never ships against. |
| Development Build / Script Debugging / Autoconnect Profiler / Deep Profiling | Off | Set per build via `BuildOptions`, not baked into the profile — see below. |

### Target architecture: baked into the macOS profile asset, not global

**Apple Silicon (ARM64) only.** Halves IL2CPP build time and size versus a universal binary; Intel
Macs cannot run the result — Rosetta does not translate ARM64→Intel. **[project decision]**

This setting is deliberately **not** in the global table above and does **not** land in
`ProjectSettings/ProjectSettings.asset`. `BuildScript.cs` builds via
`BuildPlayerWithProfileOptions.buildProfile`, and a profile build reads architecture from the
*profile asset's own* platform settings — it ignores the deprecated, machine-local
`UserBuildSettings.architecture` global entirely. So `BuildProfileGenerator`'s
`SetMacProfileArchitectureArm64` writes `m_Architecture: 1` directly onto `macOS-Release.asset`
itself, via reflection onto `platformBuildProfile.architecture` (internal-only in 6.3). Setting the
global instead — the natural first thing to try — silently produces a universal binary; this
mechanism is precisely the fix for that bug. To verify architecture, check `m_Architecture` in the
profile asset, not Player Settings.

### Dev builds (`--dev`)

Same profile asset, same IL2CPP backend, with
`BuildOptions.Development | BuildOptions.AllowDebugging | BuildOptions.CompressWithLz4` added at
build time instead of `CompressWithLz4HC`.

### Why the scripting backend is global, and why `--dev` builds are IL2CPP too

Per-profile Player Settings overrides are **internal-only** in Unity 6.3 — there is no public API
for a `BuildProfile` asset to carry its own Scripting Backend or Development Build checkbox. A
`Windows-Dev` or `macOS-Dev` *profile asset* could therefore never actually differ from its
`-Release` sibling in the Editor UI; it would just be a second asset that lies about what it does.
The generator applies scripting-backend-level settings once, globally, and Dev vs. Release is
expressed entirely through `BuildOptions` passed to `BuildPipeline.BuildPlayer` at build time
(`BuildScript.cs`).

The direct consequence: **a `--dev` player build is exactly as slow to compile as a release
one** — IL2CPP always compiles the whole managed assembly set to C++ regardless of
`BuildOptions.Development`. This tool is not the fast-iteration loop. Day-to-day iteration is
Editor Play mode, which this system does not touch at all; reach for `--dev` only when you need an
actual player binary with debugging/profiling attached (e.g. handing a build to someone off-machine
who needs to reproduce a bug).

## Preflight failures and fixes

All preflight checks run before Unity is launched, so a failure costs seconds, not the 10–25
minutes of an IL2CPP build. Each one exits `1` and names its own fix:

| Failure | Fix |
|---|---|
| `ProjectSettings/ProjectVersion.txt` missing (repo root not resolved) | Run the script from inside the project, or check `Tools/build/build.py`'s repo-root resolution. |
| Named profile asset does not exist under `BuildProfiles/` | The error lists what *is* there — run the one-time setup menu item, or check the spelling of `PROFILE`. |
| Platform token does not parse from the profile name | Only `macOS-*` and `Windows-*` are recognized; rename or add the profile to `Tools/build/naming.py`. |
| Target platform ≠ host platform | "Build Windows on Windows" — this script does not cross-compile. |
| The platform's PlaybackEngine module is not installed | Install it via Unity Hub, or `unity install --module <name>`. |
| The Editor is already running for this project | Close it — a batch build cannot share the project with an open Editor (the same rule as guideline 08 / `CLAUDE.local.md`). |
| No usable Unity binary found | Pass `--unity PATH`, or set `$UNITY_EDITOR`; the script otherwise tries the direct-install path, then the Hub path, for the version pinned in `ProjectVersion.txt`. |
| `xcodebuild` not found on `PATH` (`shutil.which("xcodebuild")`) on a macOS IL2CPP profile | Install full Xcode from the App Store or developer.apple.com — the Command Line Tools alone are not enough: `xcode-select -p` succeeds with just CLT installed, but IL2CPP's C++ toolchain needs the full `Xcode.app` (the CLT bundle doesn't ship it). Then run `xcode-select --install` if prompted. |
| No scenes are enabled in `EditorBuildSettings.asset` | Enable at least one in **File > Build Profiles > Scene List** (Bootstrap first). |
| A zip of that exact name already exists in the output directory | Checked in `main()` right after the plan is resolved, before the (possibly 10–25 minute) Unity build starts — not after. Pass `--force` to overwrite, or remove the existing zip. |

## Exit codes

| Code | Meaning |
|---|---|
| `0` | Success. |
| `1` | Preflight or usage failure — see the table above. |
| `2` | The Unity build failed. The script prints the log tail and the full log path. |
| `3` | Packaging failed (staging, `build-info.json`/`README.txt` generation, or archiving). |

## Running an unsigned build on another Mac (Gatekeeper)

This project does not do notarization or Apple Developer signing — Unity ad-hoc signs Apple
Silicon builds, which is enough for the build to *run*, but Gatekeeper still quarantines an
unsigned `.app` downloaded or copied from another machine. `README.txt` inside every zip carries
the workaround: right-click the app → **Open** (accepts the one-time warning), or from a terminal:

```bash
xattr -dr com.apple.quarantine RootsDance.app
```

## Troubleshooting

- **Compile errors send the Editor into Safe Mode.** In Safe Mode, `-executeMethod` cannot find
  `RootsDance.Editor.Build.BuildScript` and the batch build fails immediately with a generic
  error. Fix the compile errors first (Console, or the log file) — see guideline 08's
  [compile-check-without-tests note](../../guidelines/08-testing-tooling.md#from-the-command-line-humans-and-agents)
  (sourced from `manual-safemode.md`).
- **A non-zero exit does not always mean the build failed — but the mere existence of the `.app`
  bundle doesn't prove it succeeded either.** `-executeMethod` can report "Timeout after 300
  seconds while waiting async operations to finish" and exit non-zero *after* the player has
  already been written successfully — the timeout is Unity's batch-mode shutdown logic, not the
  build step. Unity also creates the `.app` skeleton *before* the IL2CPP/link stages run, so a
  StrictMode or IL2CPP failure late in the build can leave a `.app` on disk that will not launch.
  `build.py` handles both: on a non-zero exit it greps the log for `BuildScript.cs`'s own
  `[BuildScript] <profile>: result=Succeeded` marker (`build_succeeded()` in `build.py`) rather
  than trusting the exit code or `os.path.exists()` alone. If you are diagnosing a build by hand,
  do the same — look for that exact line in `Logs/build-<profile>.log`.
- **An Editor that was already open when you pulled will overwrite `ProjectSettings.asset` with
  its stale in-memory copy.** Unity loads Player Settings once, at project open; it does not
  re-read the file when git changes it underneath. The next thing that saves — any
  `AssetDatabase.SaveAssets()`, or just quitting the Editor — writes the *old* values back and
  silently reverts the merged ones. Observed on 2026-08-28: pulling this system into an Editor
  that had been open since before the merge wiped the IL2CPP backend, the compiler
  configuration, `Minimal` stripping and the Metal-only graphics API in one save, leaving builds
  quietly back on Mono defaults. **After pulling a change that touches `ProjectSettings.asset`,
  either restart the Editor or re-run `RootsDance > Build > Create Default Build Profiles`** —
  the generator is idempotent and re-applies every value. Then check
  `git diff ProjectSettings/ProjectSettings.asset` before committing.
- **`AssetDatabase.SaveAssets()` flushes every dirty asset in the project, not just the profiles.**
  Running the generator in a session where TVE materials are dirty writes ~37 unrelated `.mat`
  files. They are not yours to commit: `git restore Assets/RootsDance/Materials/Environment/`
  afterwards, and stage `ProjectSettings/` explicitly.
- **Every batch build re-serializes three assets** — the VT323 SDF font, `DefaultVolumeProfile`
  and `HDRenderPipelineGlobalSettings`. Restore them after a build, or the *next* build sees a
  dirty tree and tags its zip `-dirty`.

## Open follow-ups

- **HDRP shader-variant stripping is unexplored.** It lives in HDRP Global Settings, not in this
  script, and is the rendering owner's call — not addressed here.
- **`productName` is still `she-nicest-temp-proj`.** That is why `Base` in the naming convention
  is a hardcoded constant (`RootsDance`) rather than read from Player Settings — using
  `productName` today would put the placeholder name on every shared build.
- **The Windows path is untested.** It needs a Windows machine: this Mac has only
  `MacStandaloneSupport` installed, no Windows Playback Engine module. Windows IL2CPP additionally
  requires Visual Studio 2019+ with the C++ build tools and Windows SDK 10.0.19041.0+ (source:
  `docs/reference/unity6-release/manual-system-requirements.md`). Two things in `build.py` itself
  are also macOS-path-only today: `resolve_unity()`'s candidate paths are both
  `/Applications/Unity/...`, and `module_installed()` derives the `PlaybackEngines` folder from a
  `Unity.app/Contents/MacOS/Unity` layout that a Windows install does not have. A Windows host
  currently fails the module-installed check regardless of what is actually installed — pass
  `--unity PATH` to skip `resolve_unity()`, but `module_installed()` still needs a real fix before
  a Windows preflight can pass on its own. Separately, the committed `Windows-Release.asset` has a
  null platform-settings object (`rid: -2`, vs. macOS's real `rid`) because the Windows module was
  absent on the machine that generated it — whoever first builds Windows must re-run
  `RootsDance > Build > Create Default Build Profiles` there and commit the re-serialized asset.
- **`develop` currently ships six enabled scenes**, not just `Bootstrap` + `Main_*`:
  `ProjectSettings/EditorBuildSettings.asset` has `Bootstrap`, `PlayerTest_Environment`,
  `PlayerTest_Gameplay`, `Main_Environment`, `Main_Gameplay` and `MainMenu` all enabled. Because
  both profiles inherit that global scene list, every build made from `develop` today includes all
  six, until someone disables the ones that shouldn't ship in **File > Build Profiles > Scene
  List**. (The scene list itself is a content decision, not something this doc governs.)

## Files

- `Assets/RootsDance/Scripts/Editor/Build/BuildProfileGenerator.cs` — creates/updates the two
  profile assets, applies the global player settings, and bakes ARM64 architecture directly onto
  the macOS profile asset (see "Target architecture" above); menu item
  `RootsDance > Build > Create Default Build Profiles`.
- `Assets/RootsDance/Scripts/Editor/Build/BuildScript.cs` — the `-executeMethod` entry point,
  `BuildFromCommandLine`, reading `-rdProfile` / `-rdOutput` / `-rdDev`.
- `Tools/build/naming.py` — the naming convention, pure logic, no side effects.
- `Tools/build/build.py` — the CLI: preflight, build, package, report.
- `Tools/build/test_naming.py` — `unittest` coverage (`python3 -m unittest discover -s
  Tools/build`) for `naming.py` plus the pure/stubbable helpers in `build.py`: `git_state`,
  `editor_is_running`, `resolve_unity`, `stageable_entries` and `build_succeeded`.
