# AGENTS.md — shenicest-2026

Entry point for every AI coding agent (Claude Code, Codex, Cursor, Copilot…) and every human on this project. `CLAUDE.md` just includes this file. Read this page, then open the guideline that covers the task before writing code.

## What this project is

- **SheNicest 2026 hackathon / game jam entry (team G001)** — a **3D game** built with **Unity 6000.3.22f1 (Unity 6.3 LTS)**, **Universal Render Pipeline (URP 17.3)**, **C# 9.0**.
- Created from the Unity Hub **Universal 3D** template. Primary target: desktop standalone (Windows/macOS); a Web build is a possible secondary target.
- Small team, short timeframe. Every rule here optimises for *fast iteration without merge conflicts* — not for enterprise ceremony.
- Engineering docs are in English. The repo README is in Chinese; the game name is not decided yet, so `SheNicest` is the project-owned folder name, root namespace and assembly prefix until the team renames it.

## Non-negotiables (the 20 rules agents break most often)

Unity/C# facts that are easy to get wrong because training data predates Unity 6 (and Odin 4.0) — details and sources in [docs/guidelines/10-unity6-facts.md](docs/guidelines/10-unity6-facts.md):

1. **Unity 6.3 compiles C# 9.0 only.** No `record`, no `init` setters, no file-scoped namespaces, no C# 10+ syntax.
2. **`[SerializeField]` is field-only in 6.3.** Auto-properties need `[field: SerializeField]`; prefer an explicit `[SerializeField] private` backing field.
3. **`FindObjectOfType`/`FindObjectsOfType` are obsolete.** Use `FindFirstObjectByType` / `FindAnyObjectByType` / `FindObjectsByType(FindObjectsSortMode.None)` — and only in initialisation code.
4. **Physics API was renamed:** `Rigidbody.linearVelocity` / `linearDamping` / `angularDamping`, type `PhysicsMaterial`.
5. **Input comes from the Input System package** via the project-wide action asset (`InputSystem.actions`). `UnityEngine.Input` is never used.
6. **Async is `UnityEngine.Awaitable`** with a `CancellationToken` (`destroyCancellationToken`); coroutines only for trivial timed sequences; no UniTask/Task-based gameplay code.
7. **Custom render passes use the Render Graph API.** URP Compatibility Mode no longer exists in 6.3.
8. **Never `?.`, `??` or `is null` on a `UnityEngine.Object`** — use `== null` or the implicit bool; Unity's "fake null" bypasses those operators.

Project conventions — details in the guidelines linked in each line:

9. **Naming:** PascalCase types/methods/properties/events; camelCase locals/params; private fields `m_camelCase`; mutable statics `s_camelCase`; `const`/`static readonly` `k_PascalCase`; interfaces `I…`; ScriptableObject classes end in `SO`. Allman braces, 4 spaces, ≤ 120 columns, one `MonoBehaviour`/`ScriptableObject` per file, file name = class name. → [01](docs/guidelines/01-csharp-style.md)
10. **Everything project-owned lives under `Assets/SheNicest/`**, organised by asset type; code under `Scripts/Runtime/<Feature>/` with namespace `SheNicest.<Feature>`; third-party under `Assets/ThirdParty/`; experiments under `Assets/_Sandbox/<user>/`. → [02](docs/guidelines/02-project-structure.md)
11. **Four assemblies only:** `SheNicest.Runtime`, `SheNicest.Editor`, `SheNicest.Tests.EditMode`, `SheNicest.Tests.PlayMode`. Editor-only code goes in `Scripts/Editor/`, never behind ad-hoc `#if UNITY_EDITOR` in runtime files unless unavoidable. → [02](docs/guidelines/02-project-structure.md), [04](docs/guidelines/04-unity-scripting-rules.md)
12. **Inspector data = `[SerializeField] private` fields**, never public fields; tunables live in ScriptableObject assets under `Assets/SheNicest/Data/`, not on scene objects. → [01](docs/guidelines/01-csharp-style.md), [11](docs/guidelines/11-scenes-prefabs-workflow.md)
13. **Wire dependencies through serialized references, `[RequireComponent]` + `GetComponent` in `Awake`, or constructor parameters.** No singletons (the only static access point is `GameBootstrap`), no DI framework, no `GameObject.Find` in gameplay code. Cross-feature communication goes through interfaces in `SheNicest.Core` or ScriptableObject event channels. → [03](docs/guidelines/03-architecture-patterns.md)
14. **Lifecycle:** own components in `Awake`, other objects in `Start`, subscribe in `OnEnable` / unsubscribe in `OnDisable`, physics in `FixedUpdate`, `Destroy` not `DestroyImmediate` at runtime. → [04](docs/guidelines/04-unity-scripting-rules.md)
15. **Zero allocations in per-frame code:** cache components and ids (`Animator.StringToHash`, `Shader.PropertyToID`), no LINQ/string building/closures in `Update`, `Physics.*NonAlloc`, pool with `UnityEngine.Pool.ObjectPool<T>`. → [05](docs/guidelines/05-performance.md)
16. **Never hand-edit or hand-merge `.unity`, `.prefab`, `.asset` YAML.** Move/rename/delete assets inside the Editor so `.meta` files follow; always commit the `.meta` with its asset. → [06](docs/guidelines/06-version-control.md)
17. **Scenes:** `Bootstrap.unity` is the only persistent scene; levels are additive `<Level>_Environment` + `<Level>_Gameplay` scenes; avoid concurrent edits by splitting scenes — each person works in their own part scene, and gives the team channel a heads-up before editing a shared scene/prefab or merging content into one; everything placed twice is a prefab. → [11](docs/guidelines/11-scenes-prefabs-workflow.md)
18. **UI is UI Toolkit** (UXML/USS under `Assets/SheNicest/UI/`, BEM class names, presenter MonoBehaviours); camera is **Cinemachine 3.1** with exactly one Unity `Camera` in the bootstrap scene. → [09](docs/guidelines/09-packages-systems.md), [07](docs/guidelines/07-rendering-urp.md)
19. **Packages:** only the versions listed in [09](docs/guidelines/09-packages-systems.md); adding/removing a package is a team decision and its own `chore(packages):` commit; no `Resources/` folder, no Addressables by default.
20. **Tests:** pure C# logic gets EditMode tests (`Method_Scenario_ExpectedResult`); run the EditMode suite before a PR; `main` must open in the Editor with zero errors and zero warnings from `SheNicest.*`. → [08](docs/guidelines/08-testing-tooling.md)
21. **Odin Inspector 4.0 is installed (`Assets/Plugins/Sirenix/`) as an Editor-UX layer only:** `Sirenix.OdinInspector` attributes on `[SerializeField] private` fields — content ScriptableObjects use the five standard `[TitleGroup]` sections (`Basic Info`, `Interaction`, `Conditions`, `Result`, `Scene Change`), `[Required]` on every reference, `[ValidateInput]` on IDs. **Never** `SerializedMonoBehaviour`/`SerializedScriptableObject`/`[OdinSerialize]` (Unity serialization stays the source of truth), never `Sirenix.OdinInspector.Editor` from runtime code, no `#if ODIN_INSPECTOR`, never edit `Assets/Plugins/Sirenix/`. Check an attribute in `docs/reference/third-party/odin-inspector/attributes.md` before using it. → [12](docs/guidelines/12-odin-inspector.md)

## Where things are

```
shenicest-2026/
├── AGENTS.md / CLAUDE.md        # this file (CLAUDE.md = @AGENTS.md)
├── .editorconfig                # C# formatting + naming rules (from guideline 01)
├── .gitattributes               # Git LFS + UnityYAMLMerge driver (from guideline 06)
├── .gitignore                   # GitHub Unity.gitignore + project additions
├── docs/
│   ├── README.md                # documentation index
│   ├── third-party.md           # record of vendor-package exceptions (Odin's install path, local edits)
│   ├── guidelines/              # the 12 coding guidelines (index: guidelines/README.md)
│   └── reference/               # 1,406 official Unity docs + third-party/odin-inspector/ (generated from the Odin XML docs)
├── Assets/
│   ├── SheNicest/               # all project-owned assets — tree in guideline 02
│   │   ├── Scripts/Runtime/     # SheNicest.Runtime.asmdef — App, Core, Data, Events, Player, Cameras, UI
│   │   ├── Scripts/Editor/      # SheNicest.Editor.asmdef
│   │   ├── Tests/{EditMode,PlayMode}/
│   │   ├── Scenes/              # Bootstrap, MainMenu, PrefabStage, Levels/<Level>/
│   │   ├── Data/                # ScriptableObject instances (Events/, Levels/, Config/…)
│   │   ├── Settings/            # URP assets, renderers, volume profiles, presets, build profiles
│   │   └── Animations/ Audio/ Fonts/ Input/ Materials/ Meshes/ Prefabs/ Shaders/ Textures/ UI/ VFX/
│   ├── ScriptTemplates/         # Unity script templates (must sit directly under Assets/)
│   ├── ThirdParty/              # Asset Store / vendor packages, never edited in place
│   ├── Plugins/                 # native plug-ins + Plugins/Sirenix/ (Odin Inspector 4.0, vendor-required path, never edited)
│   └── _Sandbox/<user>/         # personal experiments; never referenced by shipping content
├── Packages/                    # manifest.json + packages-lock.json (created by Unity)
└── ProjectSettings/             # created by Unity; ProjectVersion.txt pins 6000.3.22f1
```

`Library/`, `Temp/`, `Logs/`, `UserSettings/`, `Builds/` and `docs/reference/_ebooks-pdf/` are ignored.

## Guidelines index

Each guideline starts with a ≤ 15-line **TL;DR** that is enough for most tasks; the body carries the rationale, examples and the Unity sources. Full index with reading order: [docs/guidelines/README.md](docs/guidelines/README.md).

| # | Read when you… | Guideline |
|---|---|---|
| 01 | write or review any C# | [C# code style and naming](docs/guidelines/01-csharp-style.md) |
| 02 | create files/folders/assets or assemblies | [Project and asset organization](docs/guidelines/02-project-structure.md) |
| 03 | design a system, add a class, decide MonoBehaviour vs ScriptableObject | [Architecture and design patterns](docs/guidelines/03-architecture-patterns.md) |
| 04 | touch lifecycle, serialization, async, physics, input, logging | [Unity scripting rules](docs/guidelines/04-unity-scripting-rules.md) |
| 05 | write per-frame code, spawn objects, import assets, profile | [Performance guidelines](docs/guidelines/05-performance.md) |
| 06 | commit, branch, merge, resolve a conflict | [Version control with Git](docs/guidelines/06-version-control.md) |
| 07 | touch URP settings, lighting, materials, shaders, cameras | [Rendering and URP conventions](docs/guidelines/07-rendering-urp.md) |
| 08 | write tests, run the CLI, build, set up an IDE | [Testing, tooling and IDE setup](docs/guidelines/08-testing-tooling.md) |
| 09 | use Input System, Cinemachine, UI Toolkit, physics, NavMesh, animation, audio, packages | [Packages and game systems](docs/guidelines/09-packages-systems.md) |
| 10 | are unsure whether an API still exists in Unity 6.3 | [Unity 6.3 facts, API changes and deprecations](docs/guidelines/10-unity6-facts.md) |
| 11 | open a scene, make a prefab, add a level, coordinate with a teammate | [Scenes, prefabs and team workflow](docs/guidelines/11-scenes-prefabs-workflow.md) |
| 12 | write a content ScriptableObject, decorate an Inspector, add an Odin attribute or editor window | [Odin Inspector](docs/guidelines/12-odin-inspector.md) |

Sources: every rule links to a file in [docs/reference/](docs/reference/README.md) — official Unity 6000.3 manual pages, Script Reference pages, Unity 6 e-books (as extracted text) and Unity how-to articles, downloaded 2026-08-23. When a guideline and a reference disagree, the reference wins and the guideline gets fixed.

## How to work here (agents)

- **Before coding:** read the TL;DR of the guideline(s) for the task. If you need an API detail, grep `docs/reference/` before guessing (`grep -ril "<term>" docs/reference/scripting`; for Odin: `grep -n '^### \`<Name>Attribute\`' -A 30 docs/reference/third-party/odin-inspector/attributes.md`).
- **No Unity Editor on this machine?** You cannot compile or run tests yourself. Write code that follows [04](docs/guidelines/04-unity-scripting-rules.md), keep changes small, and say explicitly in your summary that the code is unverified until a teammate opens the project. Never claim "it compiles".
- **Creating assets from code or shell** (scripts, UXML/USS, asmdefs, folders): follow the tree in [02](docs/guidelines/02-project-structure.md). New files get their `.meta` when a teammate next opens the Editor — commit the `.meta` together with the file; never fabricate `.meta` files.
- **Never edit** `.unity`, `.prefab`, `.asset`, `.mat`, `.controller`, `.inputactions` YAML/JSON by hand, `Packages/packages-lock.json`, anything under `Assets/ThirdParty/` or `Assets/Plugins/Sirenix/`, or `ProjectSettings/` outside a dedicated `chore:` commit (Odin writes its own `ODIN_INSPECTOR*` defines there — commit that churn, never hand-edit it).
- **Git:** two long-lived branches — `main` (always opens and plays; submission builds come from it) and `develop` (integration). Work on `<type>/<kebab-name>` branches created from `develop` and merged back into `develop` by pull request; the integration owner merges `develop` into `main`. Commit messages are Conventional-Commit style, `<type>(<optional scope>): <what changed>`, imperative, ≤ 72 characters (`feat`, `fix`, `content`, `refactor`, `perf`, `docs`, `test`, `chore`). Small commits, stage files explicitly (no `git add -A`), never commit `Library/` or builds, never force-push `main` or `develop`. Only commit when the human asks.
- **Docs:** when a convention changes, update the owning guideline (and this file if a non-negotiable changes) in the same PR. Do not add new rule files outside `docs/guidelines/` without updating the indexes.

## Commands (run from the repo root; close the Editor first — one instance per project)

The commands show the Unity Hub install path; a direct (non-Hub) download lives elsewhere (macOS: `/Applications/Unity/Unity-6000.3.22f1/Unity.app`) — substitute your machine's Editor path.

```bash
# macOS — EditMode tests (results: Logs/TestResults/EditMode.xml)
mkdir -p Logs/TestResults
/Applications/Unity/Hub/Editor/6000.3.22f1/Unity.app/Contents/MacOS/Unity \
  -batchmode -projectPath "$PWD" -runTests -testPlatform EditMode \
  -testResults "$PWD/Logs/TestResults/EditMode.xml" -logFile "$PWD/Logs/TestResults/EditMode.log"
```

```powershell
# Windows (PowerShell) — EditMode tests
New-Item -ItemType Directory -Force Logs\TestResults | Out-Null
& "C:\Program Files\Unity\Hub\Editor\6000.3.22f1\Editor\Unity.exe" `
  -batchmode -projectPath "$PWD" -runTests -testPlatform EditMode `
  -testResults "$PWD\Logs\TestResults\EditMode.xml" -logFile "$PWD\Logs\TestResults\EditMode.log"
```

```bash
# Build from a Build Profile (profiles live in Assets/SheNicest/Settings/BuildProfiles/)
<Unity> -batchmode -quit -projectPath "$PWD" \
  -activeBuildProfile "Assets/SheNicest/Settings/BuildProfiles/macOS-Release.asset" \
  -build "$PWD/Builds/macOS-Release/SheNicest.app" -logFile "$PWD/Logs/Build.log"
```

Never pass `-quit` to a `-runTests` run (it kills the Editor before the tests finish); `-testPlatform PlayMode` runs the PlayMode suite. Full details, filters and exit codes: [08](docs/guidelines/08-testing-tooling.md).

## Machine setup (every human, once per machine)

The project itself is fully set up (Universal 3D template imported, cleaned and committed 2026-08-24) — **do not create or merge a template project again.** What each teammate does once on their own machine, before their first scene or prefab edit:

1. Install Unity **6000.3.22f1** via Unity Hub or direct download (modules: Windows/Mac Build Support as needed, WebGL optional). Note the install path — the CLI commands above and the UnityYAMLMerge config in [06](docs/guidelines/06-version-control.md) need it.
2. Run `git lfs install` (ideally before the first clone; afterwards, run it inside the repo and `git lfs pull` if any binary shows up as a small text pointer file).
3. Configure the UnityYAMLMerge mergetool + merge driver in `~/.gitconfig` per [06](docs/guidelines/06-version-control.md) — verify the binary path first (Hub installs: `Unity.app/Contents/Tools/`; direct downloads: `Unity.app/Contents/Helpers/`) — and run the merge-driver smoke test described there.
4. Open the project once from Unity Hub ("Add project from disk") and confirm the Console shows zero errors/warnings. Don't commit files Unity re-serializes on open unless they belong to your task ([06](docs/guidelines/06-version-control.md)).
5. Odin Inspector is committed in the repo (`Assets/Plugins/Sirenix/`, per-seat licence — every teammate holds their own); nothing to install. If you switch the active build target (e.g. to Web), Odin adds its define symbols to `ProjectSettings/ProjectSettings.asset` — commit that together with the platform switch ([12](docs/guidelines/12-odin-inspector.md)).

An AI agent asked to work in this repo should check steps 2–3 (`git config --get merge.unityyamlmerge.driver`, `git lfs version`) before its first commit that touches a scene, prefab or binary asset, and tell its human what is missing instead of working around it.
