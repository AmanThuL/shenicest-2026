# 06. Version control with Git

> **Scope:** How this Unity project is stored, shared and merged with Git and GitHub — Editor settings that Git depends on, `.meta` rules, what is committed, Git LFS, UnityYAMLMerge, branch/commit conventions, and safe conflict resolution.
> **Applies to:** every human and every AI coding agent that commits to the `shenicest-2026` repository (the Unity project lives at the repository root: `Assets/`, `Packages/`, `ProjectSettings/`).
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

Folder layout inside `Assets/` is owned by [02 — Project structure](./02-project-structure.md); scene ownership and the additive-scene workflow are owned by [11 — Scenes, prefabs and team workflow](./11-scenes-prefabs-workflow.md). This document covers the Git mechanics only.

## TL;DR — rules at a glance

1. **MUST** keep *Edit > Project Settings > Editor > Asset Serialization > Mode = Force Text*, *Reduce version control noise = on*, and *Edit > Project Settings > Version Control > Mode = Visible Meta Files*. These are the template defaults; never change them.
2. **MUST** commit every `.meta` file together with its asset, in the same commit. A new asset without a `.meta` (or a `.meta` without its asset) never reaches `develop`.
3. **MUST** move, rename and delete assets inside the Unity Editor (Project window) so the `.meta` follows. Outside the Editor, move the asset and its `.meta` together.
4. **MUST** commit only `Assets/`, `Packages/` (`manifest.json`, `packages-lock.json`), `ProjectSettings/` and repo-root files (`docs/`, `.gitignore`, `.gitattributes`, `.editorconfig`, `README.md`, agent instruction files `AGENTS.md`, `CLAUDE.md`). **NEVER** commit `Library/`, `Temp/`, `Logs/`, `UserSettings/`, `obj/`, builds, IDE files, or the personal Claude Code files `CLAUDE.local.md` and `.claude/settings.local.json`.
5. **MUST** run `git lfs install` once per machine; binary assets (textures, models, audio, fonts, video, DLLs) go through Git LFS via the committed `.gitattributes`. Unity YAML (`.unity`, `.prefab`, `.asset`, `.mat`, `.meta`, …) stays plain text in Git; the only `.asset` exceptions are the binary `LightingData.asset`, generated Terrain data (`*_TerrainData.asset`) and TMP `* SDF.asset` (appendix).
6. **MUST** configure UnityYAMLMerge in `~/.gitconfig` (mergetool + merge driver, see below) before touching any scene or prefab.
7. **MUST** work on a short-lived task branch `<type>/<kebab-name>` created from `develop` and merged back into `develop` through a GitHub pull request (docs-only commits may go straight to `develop`). Only the integration owner merges `develop` into `main`; `main` always opens in the Editor and plays from Bootstrap. **NEVER** force-push `main` or `develop`.
8. **MUST** stage files explicitly and review `git status` before every commit. **NEVER** use `git commit -a` or blanket `git add -A` / `git add .`; revert scene, prefab and settings files you did not mean to change.
9. **MUST** `git pull --ff-only` on `develop` at the start of every session and merge `develop` into your branch (`git merge develop`, not rebase) before opening a pull request and at least daily.
10. **SHOULD** commit small and often with Conventional-Commit-style messages (`feat:`, `fix:`, `chore:`, …) and push at least at the end of every work session.
11. **MUST** put `Packages/` and `ProjectSettings/` changes in their own `chore:` commit and announce them to the team (see [07](./07-rendering-hdrp.md), [09](./09-packages-systems.md)).
12. **NEVER** hand-edit conflict markers inside `.unity`, `.prefab` or `.asset` files. Resolve with `git mergetool` (UnityYAMLMerge) or take one side whole, then repair in the Editor.
13. **NEVER** delete or regenerate a `.meta` file to "fix" a conflict — the GUID inside it is what every reference points to.
14. **NEVER** keep the repository inside a cloud-synced folder (iCloud Drive, Dropbox, OneDrive, Google Drive).
15. **NEVER** switch the project to Unity Version Control (UVCS) or Perforce, the Editor-integrated alternatives; this project is Git + GitHub + Git LFS only. **[project decision]**

## Editor settings Git depends on

Keep the first three settings below at their Universal 3D template defaults and set the fourth once after cloning; an agent can verify all four by reading `ProjectSettings/EditorSettings.asset`.

| Setting (Unity 6.3 menu path) | Required value | Line in `ProjectSettings/EditorSettings.asset` |
|---|---|---|
| Edit > Project Settings > **Editor** > Asset Serialization > **Mode** | **Force Text** | `m_SerializationMode: 2` |
| Edit > Project Settings > **Editor** > Asset Serialization > **Reduce version control noise** | **enabled** | `m_SerializeInlineMappingsOnOneLine: 1` |
| Edit > Project Settings > **Version Control** > **Mode** | **Visible Meta Files** | `m_ExternalVersionControlSupport: Visible Meta Files` |
| Edit > Project Settings > **Editor** > Line Endings For New Scripts > **Mode** | **Unix** | `m_LineEndingsForNewScripts: 1` (template ships `0` = OS Native; the value follows the manual's OS Native / Unix / Windows order) |

**MUST** keep Asset Serialization in **Force Text**.
- *Why:* Force Text stores scenes, prefabs and `.asset` files as YAML text, which Git can diff and three-way merge; switching to binary "will remove the ability to merge these files by version control". Force Text is the default for new projects.
- *Source:* [Editor settings](../reference/version-control/manual-class-editormanager.md), [Text-based scene files](../reference/version-control/manual-textsceneformat.md), [Authoring scenes and prefabs with version control](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

**MUST** keep **Reduce version control noise** enabled.
- *Why:* It forces Unity to write references and similar YAML structures on one line instead of wrapping at 80 characters, so diffs only show real changes. Because the setting is on, UnityYAMLMerge is run *without* `--nomappinginoneline` (that flag only exists to match the multi-line format).
- *Source:* [EditorSettings.serializeInlineMappingsOnOneLine](../reference/version-control/scriptref-editorsettings-serializeinlinemappingsononeline.md), [Smart merge](../reference/version-control/manual-smartmerge.md), [Universal 3D template EditorSettings.asset](../reference/version-control/github-graphics-editorsettings-asset.md).

**MUST** keep Version Control Mode at **Visible Meta Files**.
- *Why:* Unity only integrates Perforce and UVCS natively. "Visible meta files" is the mode for "a version control system that Unity doesn't support", i.e. Git: the `.meta` files are visible on disk so Git can track them.
- *Source:* [Version control project settings](../reference/version-control/manual-class-versioncontrolsettings.md), [Version control integrations](../reference/version-control/manual-versioncontrolintegration.md), [Project organization e-book, "The .meta file"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md).

**MUST** set Line Endings For New Scripts to **Unix** (rule owned by [01 — C# style](./01-csharp-style.md)). **[project decision]**
- *Why:* The repo normalises to LF (`.gitattributes` `eol=lf`, `.editorconfig`); creating scripts as LF avoids "will be replaced" line-ending warnings and noisy first diffs. The setting does not convert existing scripts.
- *Source:* [Editor settings, "Line Endings For New Scripts"](../reference/version-control/manual-class-editormanager.md), [Universal 3D template EditorSettings.asset](../reference/version-control/github-graphics-editorsettings-asset.md) (`m_LineEndingsForNewScripts: 0` default).

**MAY** re-serialize assets deliberately after a serialization or Editor-version change, using `AssetDatabase.ForceReserializeAssets()` from a menu item, committed alone as `chore: reserialize assets`.
- *Why:* Unity upgrades old asset data in memory but only writes it back when the asset is dirtied, so upgrades otherwise leak into unrelated commits. The API must be called from a direct user action (menu item), never from a callback such as `OnEnable`.
- *Source:* [AssetDatabase.ForceReserializeAssets](../reference/version-control/scriptref-assetdatabase-forcereserializeassets.md).

```csharp
// Assets/RootsDance/Scripts/Editor/Tools/ReserializeAssetsMenu.cs — run once, commit the result alone.
using UnityEditor;

namespace RootsDance.Editor.Tools
{
    public static class ReserializeAssetsMenu
    {
        [MenuItem("RootsDance/Version Control/Force Reserialize All Assets")]
        private static void ForceReserializeAllAssets()
        {
            AssetDatabase.ForceReserializeAssets();
        }
    }
}
```

## `.meta` files

**MUST** commit the `.meta` file of every file and folder under `Assets/`, in the same commit as the asset.
- *Why:* The `.meta` holds the asset's GUID (what every cross-file reference points to) and its import settings. If an asset loses its `.meta`, Unity generates a new one with a new GUID and every reference to that asset breaks (materials lose textures, GameObjects lose scripts). Committing import settings is also how everyone works with the same texture/model/audio settings.
- *Source:* [Asset metadata](../reference/project-structure/manual-assetmetadata.md), [Authoring scenes and prefabs with version control](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md), [Understanding Unity's YAML](../reference/version-control/blog-understanding-unitys-serialization-language-yaml.md).

**MUST** move, rename and delete assets in the Unity Project window. When a file must be moved outside the Editor (a script, a tool, a Git rename), move the asset and its `.meta` together so name and location stay identical.
- *Why:* Unity moves the `.meta` automatically only when the operation happens inside the Editor; otherwise you must do it yourself or the asset is treated as brand new.
- *Source:* [Asset metadata, "Moving and renaming assets"](../reference/project-structure/manual-assetmetadata.md), [Project organization e-book](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md).

**MUST** (agents in particular) let the Editor import a new file before committing it. Files written by a coding agent (`Write`/`Edit` tools, scripts, `.asmdef`) have no `.meta` until the Editor regains focus and imports them. Workflow: write the file → focus the Editor (or *Assets > Refresh*) → confirm `<file>.meta` exists → stage both. **[project decision]**
- *Why:* If two machines each generate a `.meta` for the same path, the GUIDs differ and the `.meta` conflicts on every merge; any reference made on one machine breaks on the other.
- *Source:* consequence of [Asset metadata](../reference/project-structure/manual-assetmetadata.md).

**SHOULD** run this check before committing anything under `Assets/` (agents: run it before every commit under `Assets/`; there is no CI during the hackathon):

```bash
#!/usr/bin/env bash
# Lists staged additions/renames under Assets/ whose .meta is missing from the index,
# .meta files whose asset is not staged, and parent folders without a folder .meta.
status=0
while IFS= read -r f; do
    case "$f" in
        *.meta)
            git ls-files --error-unmatch "${f%.meta}" >/dev/null 2>&1 \
                || [ -d "${f%.meta}" ] \
                || { echo "orphan .meta (asset not staged): $f"; status=1; } ;;
        *)
            git ls-files --error-unmatch "$f.meta" >/dev/null 2>&1 \
                || { echo "missing .meta: $f.meta"; status=1; }
            d=$(dirname "$f")
            while [ "$d" != "Assets" ] && [ "$d" != "." ]; do
                git ls-files --error-unmatch "$d.meta" >/dev/null 2>&1 \
                    || { echo "missing folder .meta: $d.meta"; status=1; }
                d=$(dirname "$d")
            done ;;
    esac
done < <(git -c core.quotePath=false diff --cached --name-only --diff-filter=AR -- Assets)
exit $status
```

**NEVER** commit an empty folder's `.meta`. Create folders when you have something to put in them (or add a `.gitkeep` file as [02](./02-project-structure.md) prescribes — dot-files are ignored by the importer, so it gets no `.meta`).
- *Why:* Git does not store empty folders, so only the `.meta` travels. On the next machine Unity 6.3 recreates the folder from the `.meta` (older Editors deleted the `.meta` instead), and the tree silently diverges from what was committed. A `.gitkeep` inside the folder makes the folder itself versioned.
- *Source:* [Asset metadata, "Empty folders and version control"](../reference/project-structure/manual-assetmetadata.md), [Project organization e-book](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md).

A `.meta` is ignored only when its asset is ignored too (the template does this for `*.blend1.meta`, `*.pdb.meta`, `*.unitypackage.meta`).
- *Source:* [Boss Room .gitignore](../reference/version-control/github-com-unity-multiplayer-samples-coop-gitignore.md) ("Asset meta data should only be ignored when the corresponding asset is also ignored"), [Unity.gitignore](../reference/version-control/github-gitignore-unity-gitignore.md).

## What to commit, what to ignore

| Path | Commit? | Reason |
|---|---|---|
| `Assets/**` (+ every `.meta`) | **yes** | The project content. |
| `Assets/Plugins/Sirenix/**` (Odin Inspector) | **yes, unmodified** | The vendor tree incl. `Config/Editor/*.asset`, `link.xml`, `.pdb`/`.xml` docs and every `.meta`; DLLs and `.bytes` go through LFS by extension. Changes only in a `chore(odin):` import/upgrade commit ([12](./12-odin-inspector.md)). The `ODIN_INSPECTOR*` defines Odin writes into `ProjectSettings.asset` are committed with the import or platform switch that caused them. |
| `Packages/manifest.json` | **yes** | Declares the package set. |
| `Packages/packages-lock.json` | **yes** | Reproduces the exact resolved package versions on every machine. Never hand-edit; delete it only to force re-resolution, and commit the regenerated file. |
| `ProjectSettings/**` (incl. `ProjectVersion.txt`) | **yes** | Project-wide settings; `ProjectVersion.txt` pins the Editor version (6000.3.22f1) the Hub opens the project with. |
| `docs/`, `.gitignore`, `.gitattributes`, `.editorconfig`, `README.md`, agent instruction files (`AGENTS.md`, `CLAUDE.md`) | **yes** | Repo-level configuration and documentation (documentation never goes under `Assets/`, see 02). |
| `Library/` | **never** | Per-machine import cache and Asset Database (`SourceAssetDB`, `ArtifactDB`); Unity regenerates it. |
| `Temp/`, `Logs/`, `obj/` | **never** | Cleared/regenerated by Unity and the compiler. |
| `UserSettings/` | **never** | Personal preferences and Editor layout; committing it overwrites teammates' settings. |
| `Build/`, `Builds/`, `*.app`, `*.apk` | **never** | Build output; build into `Builds/<ProfileName>/` at the repo root (see [08](./08-testing-tooling.md)) so the template ignore rule catches everything, including `.exe` files, which have no ignore rule of their own. |
| `*.csproj`, `*.sln`, `.vs/`, `.idea/`, `.vscode/` | **never** | IDE files regenerated by Unity / per-user (IDE setup: [08](./08-testing-tooling.md)). |
| `*.unitypackage` | **never** | Import third-party packages into `Assets/ThirdParty/` instead (see 02). |
| `CLAUDE.local.md`, `.claude/settings.local.json` | **never** | Personal Claude Code instructions and permission grants for one person and machine (absolute paths, local tools, session checklists); gitignored in the additions block. Shared agent instructions go in `AGENTS.md` (`CLAUDE.md` includes it). |
| Source art (`.psd`, `.blend`, `.aseprite` masters) | **not under `Assets/`** | Unity would import them; keep masters outside `Assets/` in the repo-root `SourceArt/<mirrored path>/` (LFS by extension, owned by [02](./02-project-structure.md)). Unity's blog suggests a separate repo for source content on Git; one folder in this repo is enough for a hackathon. **[project decision]** |

- *Why:* "Only files that cannot be generated should be placed under version control" — Unity recreates everything else. `Library` is explicitly per-machine; `UserSettings` holds personal preferences; `packages-lock.json` is what makes the package set deterministic across machines; cloud-synced folders are an unsupported workflow that can corrupt the project.
- *Source:* [Default project directories](../reference/project-structure/manual-default-directories.md), [Contents of the Asset Database](../reference/version-control/manual-asset-database-contents.md), [Lock files](../reference/version-control/manual-upm-conflicts-auto.md), [Project organization e-book, "What to ignore"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Authoring scenes and prefabs with version control, "Source content"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

The repository's `.gitignore` is the GitHub `Unity.gitignore` (the file Unity itself links as the recommended ignore list) plus a short "Project additions" block: the reference-PDF folder, `*.orig` (backup files `git mergetool` / UnityYAMLMerge leave behind), Odin's per-user `TypeRegistryUserConfig.asset`, the personal Claude Code files `CLAUDE.local.md` and `.claude/settings.local.json`, `.DS_Store`, `Thumbs.db`, `.idea/`, `.vscode/`. **NEVER** edit the template part; append new rules to the additions block. **[project decision]**
- *Source:* [Unity.gitignore](../reference/version-control/github-gitignore-unity-gitignore.md), [Speed up your programmer workflows](../reference/version-control/blog-speed-up-your-programmer-workflows.md), [Boss Room .gitignore](../reference/version-control/github-com-unity-multiplayer-samples-coop-gitignore.md).

Because `Library/` is never shared, every clone re-imports every asset. Unity's documented remedy is the Unity Accelerator cache server; we do not run one for a hackathon — keep imports cheap (small textures, compressed audio). **[project decision]**
- *Source:* [Contents of the Asset Database, "Asset caching and dependencies"](../reference/version-control/manual-asset-database-contents.md).

## Git LFS

**MUST** have Git LFS installed and initialised on every machine before the first clone or pull:

```bash
git lfs install            # once per machine: registers the lfs clean/smudge filters
git clone <repo-url>       # LFS content downloads automatically
git lfs pull               # only if a binary shows up as a small text "pointer" file
git lfs ls-files           # lists what is stored in LFS
```

- *Why:* Git keeps the complete history on every machine, so binary assets bloat clones; LFS replaces them with small text pointers and stores the content on GitHub's LFS server. Unity recommends Git LFS for any Git project with large content files.
- *Source:* [Project organization e-book, "Working with large files"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Working with Unity and GitHub](../reference/version-control/tutorial-working-with-unity-and-github.md), [Authoring scenes and prefabs with version control, "File locking"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

**MUST** let the committed `.gitattributes` (appendix below) decide what goes to LFS; do not run `git lfs track` ad hoc. LFS-tracked extensions: 3D models (`.fbx`, `.obj`, `.blend`, …), textures (`.png`, `.jpg`, `.tga`, `.psd`, `.exr`, `.hdr`, …), audio (`.wav`, `.mp3`, `.ogg`, `.aif`, …), video, fonts (`.ttf`, `.otf`), native/managed binaries (`.dll`, `.so`, `.dylib`, `.a`), archives, `*.bytes`, `LightingData.asset`, Unity Terrain data (`*_TerrainData.asset` — `TerrainData` is always serialised binary, and the greybox builder rewrites the whole file on every run), and TextMesh Pro `* SDF.asset` font atlases.
- *Why:* Patterns in `.gitattributes` are versioned with the repo, so every clone applies them identically; `git lfs track` just edits that file. The extension list follows Unity's own repositories.
- *Source:* [Boss Room .gitattributes](../reference/version-control/github-com-unity-multiplayer-samples-coop-gitattributes.md), [Unity Graphics .gitattributes](../reference/version-control/github-graphics-gitattributes.md).

**MUST** keep Unity YAML files (`.unity`, `.prefab`, `.asset`, `.mat`, `.anim`, `.controller`, `.meta`, …) as plain Git text, not in LFS. **[project decision]**
- *Why:* LFS pointers hide the content from `git diff` and from merge drivers unless every machine configures an extra `lfs-text` diff/merge driver (the Unity Graphics repo documents that extra config). Plain text keeps diffs readable and lets UnityYAMLMerge work out of the box; hackathon scenes are small.
- *Source:* [Unity Graphics .gitattributes, "MAYBE-DIFF/MERGEABLE FILES"](../reference/version-control/github-graphics-gitattributes.md), [Text-based scene files](../reference/version-control/manual-textsceneformat.md).

**MUST** use `-text` (never `binary`) on LFS lines, and run `git add --renormalize .` after changing `.gitattributes`.
- *Why:* An LFS pointer is a small text file; a CRLF conversion inside it breaks LFS. Adding a pattern does not re-filter files that are already tracked.
- *Source:* [Unity Graphics .gitattributes](../reference/version-control/github-graphics-gitattributes.md).

Git LFS also offers file locking (`git lfs lock`), which Unity names as Git's locking mechanism. We do not use locks; scene ownership (one owner per scene, see [11](./11-scenes-prefabs-workflow.md)) plays that role. **[project decision]**
- *Source:* [Authoring scenes and prefabs with version control, "File locking"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

## UnityYAMLMerge (Smart Merge)

UnityYAMLMerge ships with every Editor and merges scene and prefab files "in a semantically correct way" (by object and property, not by text line); we route our YAML `.asset` files through it as well **[project decision]**. In the Editor, the *Smart Merge* dropdown only appears for Perforce/UVCS modes, so with Git it is wired up at the Git level: as the **mergetool** (the documented setup, used on demand after a conflict) and as a **merge driver** (runs automatically during `git merge` for the extensions flagged in `.gitattributes`).

**MUST** add the snippet below to `~/.gitconfig` on every machine, with the path of the locally installed Editor. The path is per machine, so this is never committed.

```ini
# ~/.gitconfig — per machine. Pick the cmd/driver line for your OS; delete the other.
[merge]
    tool = unityyamlmerge

[mergetool]
    keepBackup = false

[mergetool "unityyamlmerge"]
    trustExitCode = false
    # macOS (Unity Hub install):
    cmd = '/Applications/Unity/Hub/Editor/6000.3.22f1/Unity.app/Contents/Tools/UnityYAMLMerge' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
    # macOS (direct download install — note Helpers/, not Tools/):
    # cmd = '/Applications/Unity/Unity-6000.3.22f1/Unity.app/Contents/Helpers/UnityYAMLMerge' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
    # Windows (Unity Hub install):
    # cmd = 'C:\\Program Files\\Unity\\Hub\\Editor\\6000.3.22f1\\Editor\\Data\\Tools\\UnityYAMLMerge.exe' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"

[merge "unityyamlmerge"]
    name = Unity SmartMerge (UnityYAMLMerge)
    # macOS (Hub install):
    driver = '/Applications/Unity/Hub/Editor/6000.3.22f1/Unity.app/Contents/Tools/UnityYAMLMerge' merge -h -p --force %O %B %A %A
    # macOS (direct download install):
    # driver = '/Applications/Unity/Unity-6000.3.22f1/Unity.app/Contents/Helpers/UnityYAMLMerge' merge -h -p --force %O %B %A %A
    # Windows (Hub install):
    # driver = 'C:\\Program Files\\Unity\\Hub\\Editor\\6000.3.22f1\\Editor\\Data\\Tools\\UnityYAMLMerge.exe' merge -h -p --force %O %B %A %A
```

The binary's location depends on how the Editor was installed: Hub installs put it under `Unity.app/Contents/Tools/`, while a direct (non-Hub) macOS download installs to `/Applications/Unity/Unity-<version>/Unity.app` with the binary under `Contents/Helpers/` (verified 2026-08-24 on a team machine with 6000.3.22f1; Unity's manual documents the older non-Hub locations `/Applications/Unity/Unity.app/Contents/Helpers/UnityYAMLMerge` and `C:\Program Files\Unity\Editor\Data\Tools\UnityYAMLMerge.exe`). The path **MUST** be verified on each machine with `ls "<path>"` / `dir "<path>"` before the smoke test — if neither `Contents/Tools/` nor `Contents/Helpers/` has it, search `Unity.app/Contents/` for the binary and use that path. Check the configuration with `git config --get mergetool.unityyamlmerge.cmd` and `git config --get merge.unityyamlmerge.driver`.

- *Why:* The `[merge]`/`[mergetool "unityyamlmerge"]` block is Unity's documented Git setup (`merge -p <base> <theirs> <mine> <output>`; `trustExitCode = false` makes Git ask you whether the result is good). `-p` premerges and accepts clean merges; `-h` runs headless (no dialogs); `--force` is the flag Unity's Mercurial example adds (`merge -p --force $base $other $local $output`). The `[merge "unityyamlmerge"]` driver reuses the same executable with Git's standard `%O` (ancestor) `%A` (ours, also the output) `%B` (theirs) placeholders — the same mechanism the Unity Graphics repo uses for its `lfs-text` driver. If the driver is not configured on a machine, Git silently falls back to its normal text merge for those files, so the `.gitattributes` lines are harmless.
- *Source:* [Smart merge](../reference/version-control/manual-smartmerge.md), [Working with YAMLMerge](../reference/version-control/tutorial-working-with-yamlmerge.md) (Hub path pattern, `-h`, `-l`/`-r`), [Unity Graphics .gitattributes](../reference/version-control/github-graphics-gitattributes.md) (`merge=<driver>` + `merge.<driver>.driver` pattern). The exact driver line is a **[project decision]** composed from those sources; the pre-jam smoke test below validates it.

**MUST** run a smoke test once per machine before the jam: create two scratch branches from `develop`, move object A in a `_Sandbox/` scene on one and object B in the same scene on the other, then `git merge` one branch into the other — the driver should auto-merge; if it reports a conflict, `git mergetool -- <scene>` must produce the merged scene. Delete both scratch branches afterwards. **[project decision]**

**MAY** tune `mergerules.txt` / `mergespecfile.txt` (in the Editor's `Tools` folder) — but do not, unless a real merge failure needs it; defaults are fine for this project.
- *Source:* [Smart merge, "Configuring mergerules.txt"](../reference/version-control/manual-smartmerge.md).

## Avoiding scene and prefab conflicts (VCS level)

Conflicts in YAML files are the main way a Unity team loses work. The Git-level defences, in order of effectiveness:

1. **Force Text + Smart Merge** (above) — makes most simultaneous edits to *different* objects in one scene merge automatically. *Source:* [Authoring scenes and prefabs with version control, "Smart Merge"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).
2. **Fewer shared files.** Content is split into additive scenes and prefabs; edit prefabs in Prefab Mode so overrides do not land in the scene file. Rules and ownership live in [11](./11-scenes-prefabs-workflow.md). *Source:* [Project organization e-book, "Split up your assets"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Authoring scenes and prefabs](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).
3. **Commit only what you changed.** Unity can mark scenes, prefabs or settings as modified although you changed nothing (opening a scene, re-serialization, a lighting auto-bake). Check `git status`; restore unintended files with `git restore -- <file>`. *Source:* [Best practices for version control, "Avoid indiscriminate commits"](../reference/version-control/how-to-version-control-systems.md).
4. **Get the latest first.** Pull before you start and before you push; isolation is what turns small overlaps into conflicts. *Source:* [Best practices for version control, "Get the latest, first"](../reference/version-control/how-to-version-control-systems.md).
5. **Baked data is the environment-scene owner's separate commit** — who bakes and when is rule 9 of [11](./11-scenes-prefabs-workflow.md). Git's part: `LightingData.asset` is LFS-tracked (appendix) and lives outside the scene file, so bakes never dirty `.unity`. *Source:* [Lighting Data Assets](../reference/version-control/manual-lightmapsnapshot.md).
6. **Settings in their own commit.** `ProjectSettings/*.asset` (tags, layers, input, quality) and `Packages/*.json` are shared by everyone and conflict easily; commit them alone as `chore:` and tell the team in chat so they pull before touching the same settings. **[project decision]**

## Branches, commits and cadence

**Branch model** **[project decision]** — a two-branch simplification of Git Flow: two long-lived branches, `main` and `develop`, plus short-lived task branches created from `develop` and merged back by pull request:

| Rule | Detail |
|---|---|
| `main` | The release line. Always opens in Unity 6000.3.22f1 without compile errors and plays from `Bootstrap.unity`; submission and demo builds are cut from it. Only the integration owner merges into it, and only from `develop` (fast-forward when possible, `git merge --ff-only develop`; a merge commit otherwise) — at least once per jam day and before every submission. No direct commits. Never force-push. |
| `develop` | The integration branch. Every task branch starts here and merges back here. Must compile and open in the Editor after every merge. No direct pushes of `Assets/`, `Packages/` or `ProjectSettings/` changes; docs-only commits may go straight to `develop`. Never force-push. |
| Branch name | `<type>/<kebab-name>`, lowercase, where `<type>` is a commit type below: `feat/player-dash`, `fix/door-trigger`, `content/level-02-greybox`. |
| Lifetime | One task, one branch, ideally finished within a day, two days at most. Split larger work. |
| Ownership | One person (plus their agents) per branch. Never rebase or rewrite a branch someone else has pulled. |
| Integration | Open a GitHub pull request against `develop`; one teammate (or that teammate's coding agent) checks it; merge with a **merge commit** (GitHub "Create a merge commit"). No squash, no rebase-merge. |
| Updating a branch | `git merge develop` into the branch (never `git rebase develop`). |

- *Why:* Unity describes Git Flow — isolated feature branches that merge back into the main line while a teammate can still fix and release the previous version safely — and recommends pull requests so review happens before integration; its DevOps guidance keeps task branches short (hours, not weeks) and independent so merges stay small. Git Flow's release and hotfix branches are overkill for a jam, so `develop` absorbs everyday integration and `main` only ever receives a `develop` state that has been opened and played — a broken merge can never take the submission build down. Merge commits resolve a scene conflict once; a rebase replays every commit and can raise the same YAML conflict repeatedly, and `--ours/--theirs` swap meaning under rebase. Lowercase prefixed branch names follow Unity's GitHub tutorial.
- *Source:* [Best practices for version control, "Git Flow", "Pull requests"](../reference/version-control/how-to-version-control-systems.md), [Task branch workflow](../reference/version-control/how-to-devops-task-branch-workflow.md), [Create branches and resolve merge conflicts](../reference/version-control/course-create-branches-and-resolve-merge-conflicts.md). The two-branch simplification is a **[project decision]**.

**Commit messages** **[project decision]** — Conventional-Commit style, imperative mood, subject ≤ 72 characters, optional body explaining *why*:

```
<type>(<optional scope>): <what changed>

feat(player): add dash with 0.4 s cooldown
fix(ui): pause menu no longer blocks input after resume
content(level-02): greybox the canyon section
chore(packages): add Cinemachine 3.1
```

Types: `feat`, `fix`, `content` (scenes/prefabs/art-only changes), `refactor`, `perf`, `docs`, `test`, `chore` (settings, packages, tooling).

- *Why:* Clean, specific messages are how you find "the change that added high-score tables" later; one commit per task makes a bad change easy to revert without touching good ones.
- *Source:* [Best practices for version control, "Commit little, commit often", "Keep commit messages clean"](../reference/version-control/how-to-version-control-systems.md), [Project organization e-book](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md).

**Daily cadence** — the Git loop Unity recommends, adapted to branches:

```bash
git switch develop && git pull --ff-only       # start of session: latest develop
git switch -c feat/player-dash                  # or: git switch feat/player-dash && git merge develop
# ... work in small increments; after each increment that compiles and whose scene opens:
git status                                      # inspect; revert unintended scene/settings files
git add Assets/RootsDance/Scripts/Runtime/Player/PlayerDash.cs \
        Assets/RootsDance/Scripts/Runtime/Player/PlayerDash.cs.meta
git commit -m "feat(player): add dash with 0.4 s cooldown"
git push -u origin feat/player-dash             # at least at the end of every session
# before the pull request (and at least once a day):
git merge develop                               # resolve conflicts now, on your branch
```

- **MUST** commit after each small, meaningful, working step and push at least once per session; never sit on a day of uncommitted jam work.
- **MUST** merge `develop` into the branch at least daily, before opening the PR, and whenever a teammate announces a merge touching files you edit.
- *Why:* Small, frequent commits and pushes are the single cheapest way to reduce conflicts and the blast radius of a bad change; "avoid waiting until the end of a game jam".
- *Source:* [Connect a Unity project to GitHub Desktop, step 6](../reference/version-control/course-connect-a-unity-project-to-github-desktop.md), [Project organization e-book, "Get the latest"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md).

**Integration owner's loop** **[project decision]** — once per jam day after the last PR has merged, and before every submission:

```bash
git switch develop && git pull --ff-only       # the state every PR of the day landed in
# open the project in 6000.3.22f1: zero compile errors, Play from Bootstrap.unity, every level opens
git switch main && git pull --ff-only
git merge --ff-only develop                     # fast-forward when possible; drop --ff-only only if main has diverged
git push origin main
```

- *Why:* `main` is what the submission build is cut from, so it only ever advances to a `develop` state someone has opened and played; fast-forwarding keeps `main` a strict prefix of `develop`, so nothing exists on `main` that `develop` does not also contain.

## Resolving a conflict safely

### Code and other text (`.cs`, `.json`, `.md`)

Resolve in the IDE as usual, then compile in the Editor before committing the merge.

### Scenes, prefabs and `.asset` files

1. **Stop and coordinate.** Tell the file's owner (see [11](./11-scenes-prefabs-workflow.md)); agree which side wins if the tool cannot merge. Never resolve a scene conflict silently. *Source:* [Create branches and resolve merge conflicts](../reference/version-control/course-create-branches-and-resolve-merge-conflicts.md) ("always discuss the change with your team").
2. **Keep the Editor out of the way.** Close the conflicting scene (or the Editor) until the merge is committed, so Unity does not import half-merged files. **[project decision]**
3. **Run Smart Merge** on each conflicted YAML file:
   ```bash
   git status                                   # lists "both modified" files
   git mergetool -- Assets/RootsDance/Scenes/Levels/Level02/Level02_Gameplay.unity
   # UnityYAMLMerge merges object-by-object; Git then asks "Was the merge successful?" — answer y only after step 5.
   ```
   *Source:* [Smart merge](../reference/version-control/manual-smartmerge.md), [Working with YAMLMerge](../reference/version-control/tutorial-working-with-yamlmerge.md).
4. **If it cannot merge cleanly, take one side whole** and re-apply the smaller change by hand in the Editor afterwards:
   ```bash
   git checkout --theirs -- Assets/RootsDance/Scenes/Levels/Level02/Level02_Gameplay.unity   # during `git merge develop` on your branch: --theirs = develop, --ours = your branch
   git add Assets/RootsDance/Scenes/Levels/Level02/Level02_Gameplay.unity
   ```
   Picking a side is what Unity's tutorial does; the owner's version normally wins.
5. **Verify in the Editor before committing:** open the scene, check the Console for missing scripts/references and YAML parse errors, enter Play Mode once.
6. **Commit the merge** (`git commit`) and push. Then re-apply any change that was lost in step 4 as a normal follow-up commit.

**NEVER** edit the YAML text by hand to remove `<<<<<<<`/`>>>>>>>` markers. Unity's YAML is a restricted dialect with file-ID cross references; a hand edit that parses can still corrupt the object graph, and manual editing is explicitly unsupported.
- *Source:* [Understanding Unity's YAML](../reference/version-control/blog-understanding-unitys-serialization-language-yaml.md), [Format of text serialized files](../reference/version-control/manual-formatdescription.md).

### `.meta` conflicts

A `.meta` conflict almost always means two people created the same asset path independently (two GUIDs). Keep the GUID already on `develop` (`git checkout --theirs -- <file>.meta` while merging `develop`), keep the asset content you want, and let the Editor re-import. If something on your branch referenced the losing GUID, re-assign it in the Inspector. **NEVER** delete the `.meta` and let Unity regenerate it.
- *Source:* [Asset metadata](../reference/project-structure/manual-assetmetadata.md), [Understanding Unity's YAML, "Meta files and cross-file references"](../reference/version-control/blog-understanding-unitys-serialization-language-yaml.md).

### `packages-lock.json` conflicts

Take `develop`'s version, then re-add your package through the Package Manager so Unity regenerates the lock file; never hand-merge it.
- *Source:* [Lock files](../reference/version-control/manual-upm-conflicts-auto.md).

## Unity Version Control (UVCS) — the documented alternative, not used

Unity's Editor integrates two systems natively: Perforce and Unity Version Control (UVCS, formerly Plastic SCM). UVCS handles large binaries and empty folders natively, supports file locking, has the artist-oriented Gluon client, in-Editor check-in/changeset windows, and can be attached from the Hub when creating a project. Unity's own Unity 6 version-control guide is written around it.

This project uses **Git + GitHub + Git LFS** instead. **[project decision]**
- *Why:* The whole team and its coding agents already work Git-natively (branches, pull requests, CLI), GitHub hosts the repo and LFS, and the Git setup above covers the two things UVCS would otherwise add for us (binary storage via LFS, semantic merges via UnityYAMLMerge). What we give up — file locking and a GUI-first artist workflow — is replaced by scene ownership for a team of a handful of people.
- *Source:* [Version control integrations](../reference/version-control/manual-versioncontrolintegration.md), [Unity Version Control overview](../reference/version-control/ugs-unity-version-control.md), [Project organization e-book, "Unity Version Control"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Ultimate guide to version control & DevOps in Unity 6](../reference/version-control/blog-complete-guide-version-control-devops-unity-6.md), [8 factors to consider when choosing a VCS](../reference/version-control/blog-8-factors-to-consider-when-choosing-a-version-control-system.md).

## Anti-patterns

- ❌ `git add -A && git commit -m "wip"` — ✅ stage named files, one task per commit, descriptive message.
- ❌ Committing `PlayerDash.cs` without `PlayerDash.cs.meta` (agent wrote the file, Editor never imported it) — ✅ focus the Editor, confirm the `.meta`, commit both.
- ❌ Renaming `Assets/RootsDance/Prefabs/Characters/Enemy.prefab` in Finder/Explorer — ✅ rename in the Project window (or move file + `.meta` together).
- ❌ Committing `Library/`, `UserSettings/`, a `Builds/` folder or `*.csproj` — ✅ they are ignored; if `git status` shows them the `.gitignore` is broken, fix that first.
- ❌ Switching Asset Serialization to *Mixed* or *Force Binary* "to make files smaller" — ✅ Force Text; binaries belong in LFS.
- ❌ Putting `.unity`/`.prefab` into LFS or marking `*.prefab binary` — ✅ plain text with `merge=unityyamlmerge`.
- ❌ Editing conflict markers in a `.unity` file in VS Code — ✅ `git mergetool`, or take one side and redo the smaller change in the Editor.
- ❌ Deleting a `.meta` to make a conflict go away — ✅ keep `develop`'s GUID, re-assign references.
- ❌ `git rebase develop` on a branch with scene changes, or `git push --force` to `main` or `develop` — ✅ `git merge develop`; merge commits via PR.
- ❌ Opening a pull request against `main`, or committing a feature straight to `develop` — ✅ task branch → PR into `develop`; only the integration owner fast-forwards `main`.
- ❌ A week-long `feature/everything` branch — ✅ one task per branch, merged within a day or two.
- ❌ Baking lighting on someone else's scene and committing the result — ✅ only the `<Level>_Environment` owner bakes and commits `LightingData.asset` (rule 9 of [11](./11-scenes-prefabs-workflow.md)).
- ❌ Cloning into `~/Library/Mobile Documents/…` (iCloud) or a Dropbox folder — ✅ a plain local folder; Git is the sync mechanism.

## Review checklist

Before approving a pull request (human or agent):

- [ ] The PR targets `develop`; `develop` is merged into the branch; no conflict markers anywhere (`git grep -n '^<<<<<<< ' -- . ':!docs'` returns nothing).
- [ ] Every added/renamed file under `Assets/` has its `.meta` staged, and no `.meta` is orphaned (run the check script).
- [ ] No files from `Library/`, `Temp/`, `Logs/`, `UserSettings/`, `Builds/`, `*.csproj`, `*.sln` in the diff.
- [ ] Only scenes, prefabs and settings the task needed are in the diff; unrelated `.unity`/`.prefab`/`ProjectSettings` changes are reverted or explained.
- [ ] Changes to `Packages/manifest.json`, `packages-lock.json` or `ProjectSettings/` are in their own `chore:` commit and announced.
- [ ] New binary assets are LFS pointers (`git lfs ls-files` lists them; `git show HEAD:<path>` prints a pointer, not bytes) and use extensions covered by `.gitattributes`.
- [ ] `ProjectSettings/EditorSettings.asset` still says `m_SerializationMode: 2`, `m_SerializeInlineMappingsOnOneLine: 1`, `m_ExternalVersionControlSupport: Visible Meta Files`.
- [ ] Branch name is `<type>/<kebab-name>`; commit subjects follow `<type>(<scope>): …`.
- [ ] The project opens in Unity 6000.3.22f1 with zero compile errors, the bootstrap scene plays, and any touched scene opens without missing references.
- [ ] Merged with a merge commit; no force-push, no rebase of a shared branch.
- [ ] `develop` → `main` only by the integration owner, after opening and playing `develop`, fast-forward when possible; done at least once per jam day and before every submission.

## Appendix: `.gitattributes`

Complete content of the repository-root `.gitattributes`. Sections: line endings (ECS-samples pattern), Unity text assets with the UnityYAMLMerge driver for `.unity`/`.prefab`/`.asset`, and Git LFS patterns taken from Unity's Boss Room and Graphics repositories. Validated with `git check-attr` (e.g. `Level01/LightingData.asset` → `merge: lfs`, `Gameplay.asset` → `merge: unityyamlmerge`, `Rock.FBX` → `filter: lfs`).

```gitattributes
# .gitattributes — shenicest-2026 (repository root)
# Rules explained in docs/guidelines/06-version-control.md.
# After changing this file run:  git add --renormalize .   (existing files are not re-filtered otherwise)

############################################################
# 1. Line endings — LF everywhere (keep in sync with .editorconfig)
############################################################
* text=auto eol=lf

# Windows-only scripts keep CRLF
*.bat eol=crlf
*.cmd eol=crlf

############################################################
# 2. Unity text assets — plain Git (diffable, mergeable)
#    Scenes / prefabs / .asset files merge through UnityYAMLMerge
#    (driver "unityyamlmerge" must be defined in each machine's ~/.gitconfig)
############################################################
*.cs                  diff=csharp text
*.meta                text
*.unity               text merge=unityyamlmerge
*.prefab              text merge=unityyamlmerge
*.asset               merge=unityyamlmerge
ProjectSettings/*.asset text
*.mat                 text
*.anim                text
*.controller          text
*.overrideController  text
*.playable            text
*.asmdef              text
*.asmref              text
*.inputactions        text
*.shadergraph         text
*.shadersubgraph      text
*.vfx                 text
*.shader              text
*.hlsl                text
*.cginc               text
*.compute             text
*.uxml                text
*.uss                 text
*.tss                 text
*.json                text
*.md                  text
*.txt                 text
*.rsp                 text

############################################################
# 3. Git LFS — binary assets
#    LFS pointer files are small TEXT files: never mark them `binary`,
#    always `-text` so no line-ending conversion touches the pointer.
############################################################
# 3D models
*.[fF][bB][xX]        filter=lfs diff=lfs merge=lfs -text
*.obj                 filter=lfs diff=lfs merge=lfs -text
*.blend               filter=lfs diff=lfs merge=lfs -text
*.dae                 filter=lfs diff=lfs merge=lfs -text
*.3ds                 filter=lfs diff=lfs merge=lfs -text
*.max                 filter=lfs diff=lfs merge=lfs -text
*.ma                  filter=lfs diff=lfs merge=lfs -text
*.mb                  filter=lfs diff=lfs merge=lfs -text
*.c4d                 filter=lfs diff=lfs merge=lfs -text
*.ply                 filter=lfs diff=lfs merge=lfs -text
*.stl                 filter=lfs diff=lfs merge=lfs -text
# Textures and images
*.[pP][nN][gG]        filter=lfs diff=lfs merge=lfs -text
*.[jJ][pP][gG]        filter=lfs diff=lfs merge=lfs -text
*.[jJ][pP][eE][gG]    filter=lfs diff=lfs merge=lfs -text
*.[tT][gG][aA]        filter=lfs diff=lfs merge=lfs -text
*.[pP][sS][dD]        filter=lfs diff=lfs merge=lfs -text
*.psb                 filter=lfs diff=lfs merge=lfs -text
*.tif                 filter=lfs diff=lfs merge=lfs -text
*.tiff                filter=lfs diff=lfs merge=lfs -text
*.bmp                 filter=lfs diff=lfs merge=lfs -text
*.gif                 filter=lfs diff=lfs merge=lfs -text
*.exr                 filter=lfs diff=lfs merge=lfs -text
*.hdr                 filter=lfs diff=lfs merge=lfs -text
*.dds                 filter=lfs diff=lfs merge=lfs -text
*.cubemap             filter=lfs diff=lfs merge=lfs -text
# Audio
*.wav                 filter=lfs diff=lfs merge=lfs -text
*.mp3                 filter=lfs diff=lfs merge=lfs -text
*.ogg                 filter=lfs diff=lfs merge=lfs -text
*.aif                 filter=lfs diff=lfs merge=lfs -text
*.aiff                filter=lfs diff=lfs merge=lfs -text
*.mod                 filter=lfs diff=lfs merge=lfs -text
*.it                  filter=lfs diff=lfs merge=lfs -text
*.s3m                 filter=lfs diff=lfs merge=lfs -text
*.xm                  filter=lfs diff=lfs merge=lfs -text
# Video
*.mp4                 filter=lfs diff=lfs merge=lfs -text
*.mov                 filter=lfs diff=lfs merge=lfs -text
*.webm                filter=lfs diff=lfs merge=lfs -text
*.m4v                 filter=lfs diff=lfs merge=lfs -text
*.ogv                 filter=lfs diff=lfs merge=lfs -text
# Fonts
*.ttf                 filter=lfs diff=lfs merge=lfs -text
*.otf                 filter=lfs diff=lfs merge=lfs -text
*.ttc                 filter=lfs diff=lfs merge=lfs -text
# Native plug-ins, managed DLLs, archives
*.dll                 filter=lfs diff=lfs merge=lfs -text
*.so                  filter=lfs diff=lfs merge=lfs -text
*.dylib               filter=lfs diff=lfs merge=lfs -text
*.a                   filter=lfs diff=lfs merge=lfs -text
*.lib                 filter=lfs diff=lfs merge=lfs -text
*.aar                 filter=lfs diff=lfs merge=lfs -text
*.jar                 filter=lfs diff=lfs merge=lfs -text
*.zip                 filter=lfs diff=lfs merge=lfs -text
*.7z                  filter=lfs diff=lfs merge=lfs -text
# Unity binary data that happens to use a text-looking extension
*.bytes               filter=lfs diff=lfs merge=lfs -text
LightingData.asset    filter=lfs diff=lfs merge=lfs -text
# Unity TerrainData is always binary; generated by RootsDance/Terrain/Build Greybox Terrain
*_TerrainData.asset   filter=lfs diff=lfs merge=lfs -text
*[[:space:]]SDF.asset filter=lfs diff=lfs merge=lfs -text
*[[:space:]]SDF[[:space:]]*.asset filter=lfs diff=lfs merge=lfs -text
```

- *Source:* [ECS samples .gitattributes](../reference/version-control/github-entitycomponentsystemsamples-gitattributes.md) (`text=auto eol=lf`, explicit `text` declarations, `diff=csharp`), [Unity Graphics .gitattributes](../reference/version-control/github-graphics-gitattributes.md) (CRLF for `.bat`/`.cmd`, `-text` on LFS pointers, `LightingData.asset`, `SDF.asset`, `.bytes`, `.cubemap`, binaries, archives), [Boss Room .gitattributes](../reference/version-control/github-com-unity-multiplayer-samples-coop-gitattributes.md) (model/texture/audio/font extensions, case-insensitive `*.[fF][bB][xX]`). Keeping YAML out of LFS and routing `.unity`/`.prefab`/`.asset` through `merge=unityyamlmerge` is a **[project decision]**.

## Sources

1. [manual-class-editormanager.md](../reference/version-control/manual-class-editormanager.md) — Unity Manual 6.3: Editor settings (Asset Serialization, Reduce version control noise, Line Endings For New Scripts) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-EditorManager.html
2. [manual-class-versioncontrolsettings.md](../reference/version-control/manual-class-versioncontrolsettings.md) — Unity Manual 6.3: Version Control project settings (Visible Meta Files) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-VersionControlSettings.html
3. [manual-versioncontrolintegration.md](../reference/version-control/manual-versioncontrolintegration.md) — Unity Manual 6.3: Version control integrations (Perforce/UVCS; Git as unsupported VCS) — https://docs.unity3d.com/6000.3/Documentation/Manual/Versioncontrolintegration.html
4. [manual-smartmerge.md](../reference/version-control/manual-smartmerge.md) — Unity Manual 6.3: Smart merge (UnityYAMLMerge paths, Git `.gitconfig` snippet, mergerules.txt, `--nomappinginoneline`) — https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html
5. [tutorial-working-with-yamlmerge.md](../reference/version-control/tutorial-working-with-yamlmerge.md) — Unity Learn: Working with YAMLMerge (Hub path pattern, `-h`/`-l`/`-r`, `git mergetool`) — https://learn.unity.com/tutorial/working-with-yamlmerge
6. [scriptref-editorsettings-serializeinlinemappingsononeline.md](../reference/version-control/scriptref-editorsettings-serializeinlinemappingsononeline.md) — Scripting API 6.3: EditorSettings.serializeInlineMappingsOnOneLine — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorSettings-serializeInlineMappingsOnOneLine.html
7. [github-graphics-editorsettings-asset.md](../reference/version-control/github-graphics-editorsettings-asset.md) — Universal 3D template: EditorSettings.asset (default values) — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/Templates/com.unity.template-universal/ProjectSettings/EditorSettings.asset
8. [scriptref-assetdatabase-forcereserializeassets.md](../reference/version-control/scriptref-assetdatabase-forcereserializeassets.md) — Scripting API 6.3: AssetDatabase.ForceReserializeAssets — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.ForceReserializeAssets.html
9. [manual-textsceneformat.md](../reference/version-control/manual-textsceneformat.md) — Unity Manual 6.3: Text-based scene files — https://docs.unity3d.com/6000.3/Documentation/Manual/TextSceneFormat.html
10. [manual-formatdescription.md](../reference/version-control/manual-formatdescription.md) — Unity Manual 6.3: Format of text serialized files — https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html
11. [blog-understanding-unitys-serialization-language-yaml.md](../reference/version-control/blog-understanding-unitys-serialization-language-yaml.md) — Unity Blog: Understanding Unity's serialization language, YAML — https://unity.com/blog/engine-platform/understanding-unitys-serialization-language-yaml
12. [manual-assetmetadata.md](../reference/project-structure/manual-assetmetadata.md) — Unity Manual 6.3: Asset metadata (.meta files, moving assets, empty folders) — https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html
13. [manual-default-directories.md](../reference/project-structure/manual-default-directories.md) — Unity Manual 6.3: Default project directories (Library/Temp/UserSettings exclusion, cloud storage unsupported) — https://docs.unity3d.com/6000.3/Documentation/Manual/default-directories.html
14. [manual-asset-database-contents.md](../reference/version-control/manual-asset-database-contents.md) — Unity Manual 6.3: Contents of the Asset Database — https://docs.unity3d.com/6000.3/Documentation/Manual/asset-database-contents.html
15. [manual-upm-conflicts-auto.md](../reference/version-control/manual-upm-conflicts-auto.md) — Unity Manual 6.3: Lock files (packages-lock.json) — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts-auto.html
16. [manual-lightmapsnapshot.md](../reference/version-control/manual-lightmapsnapshot.md) — Unity Manual 6.3: Lighting Data Assets — https://docs.unity3d.com/6000.3/Documentation/Manual/LightmapSnapshot.html
17. [github-gitignore-unity-gitignore.md](../reference/version-control/github-gitignore-unity-gitignore.md) — GitHub gitignore templates: Unity.gitignore — https://raw.githubusercontent.com/github/gitignore/main/Unity.gitignore
18. [github-com-unity-multiplayer-samples-coop-gitignore.md](../reference/version-control/github-com-unity-multiplayer-samples-coop-gitignore.md) — Unity Boss Room sample: .gitignore — https://raw.githubusercontent.com/Unity-Technologies/com.unity.multiplayer.samples.coop/main/.gitignore
19. [github-com-unity-multiplayer-samples-coop-gitattributes.md](../reference/version-control/github-com-unity-multiplayer-samples-coop-gitattributes.md) — Unity Boss Room sample: .gitattributes (Git LFS rules) — https://raw.githubusercontent.com/Unity-Technologies/com.unity.multiplayer.samples.coop/main/.gitattributes
20. [github-graphics-gitattributes.md](../reference/version-control/github-graphics-gitattributes.md) — Unity Graphics repo: .gitattributes (6000.3) — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/.gitattributes
21. [github-entitycomponentsystemsamples-gitattributes.md](../reference/version-control/github-entitycomponentsystemsamples-gitattributes.md) — Unity ECS samples: .gitattributes (line-ending normalization) — https://raw.githubusercontent.com/Unity-Technologies/EntityComponentSystemSamples/master/.gitattributes
22. [blog-speed-up-your-programmer-workflows.md](../reference/version-control/blog-speed-up-your-programmer-workflows.md) — Unity Blog: Speed up your programmer workflows (Git LFS, Unity.gitignore) — https://unity.com/blog/engine-platform/speed-up-your-programmer-workflows
23. [how-to-version-control-systems.md](../reference/version-control/how-to-version-control-systems.md) — Unity: Best practices for version control systems — https://unity.com/how-to/version-control-systems
24. [how-to-devops-task-branch-workflow.md](../reference/version-control/how-to-devops-task-branch-workflow.md) — Unity DevOps: How to set up a task branching workflow — https://unity.com/how-to/devops-task-branch-workflow
25. [course-create-branches-and-resolve-merge-conflicts.md](../reference/version-control/course-create-branches-and-resolve-merge-conflicts.md) — Unity Learn: Create branches and resolve merge conflicts — https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/create-branches-and-resolve-merge-conflicts
26. [course-connect-a-unity-project-to-github-desktop.md](../reference/version-control/course-connect-a-unity-project-to-github-desktop.md) — Unity Learn: Connect a Unity project to GitHub Desktop — https://learn.unity.com/course/collaborate-with-github-desktop/tutorial/connect-a-unity-project-to-github-desktop
27. [tutorial-working-with-unity-and-github.md](../reference/version-control/tutorial-working-with-unity-and-github.md) — Unity Learn: Working with Unity and GitHub — https://learn.unity.com/tutorial/working-with-unity-and-github
28. [ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) — Unity e-book: Best practices for project organization and version control (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/hnnjs88z588fn62jggh9br6/Best_practices_for_project_organization_and_version_control_Unity_6_edition.pdf (landing page: https://unity.com/resources/best-practices-version-control-unity-6)
29. [blog-author-scenes-and-prefabs-with-verson-control.md](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md) — Unity Blog: How to author Scenes and Prefabs with a focus on version control — https://unity.com/blog/author-scenes-and-prefabs-with-verson-control
30. [ugs-unity-version-control.md](../reference/version-control/ugs-unity-version-control.md) — Unity Docs: Unity Version Control (UVCS) overview — https://docs.unity.com/ugs/en-us/manual/devops/manual/unity-version-control
31. [blog-complete-guide-version-control-devops-unity-6.md](../reference/version-control/blog-complete-guide-version-control-devops-unity-6.md) — Unity Blog: Ultimate guide to setting up version control & DevOps in Unity 6 — https://unity.com/blog/complete-guide-version-control-devops-unity-6
32. [blog-8-factors-to-consider-when-choosing-a-version-control-system.md](../reference/version-control/blog-8-factors-to-consider-when-choosing-a-version-control-system.md) — Unity Blog: 8 factors to consider when choosing a version control system — https://unity.com/blog/games/8-factors-to-consider-when-choosing-a-version-control-system
