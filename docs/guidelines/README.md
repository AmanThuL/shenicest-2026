# Coding guidelines — Unity 6000.3 (Unity 6.3 LTS), URP, C# 9

Eleven documents that together define how this project is built. They were distilled from the official Unity documentation snapshot in [`../reference/`](../reference/README.md) (Unity 6 e-books, the 6000.3 manual and Script Reference, unity.com how-to articles) and from a small set of explicit **[project decision]**s recorded in each document. The ≤ 15-line **TL;DR** at the top of each guideline is the fast path; the body has the rationale, examples and sources.

## Reading order

| # | Guideline | Owns | Read first when… |
|---|---|---|---|
| 10 | [Unity 6.3 facts, API changes and deprecations](10-unity6-facts.md) | What Unity 6000.3 is; C# 9 limits; old API → new API table; package versions; deprecated packages | your knowledge of Unity is older than Unity 6 (most AI agents) |
| 01 | [C# code style and naming](01-csharp-style.md) | Naming, formatting, file layout, member order, comments, `.editorconfig`, script templates | writing any C# |
| 02 | [Project and asset organization](02-project-structure.md) | The `Assets/` tree, asset naming, reserved folders, assembly definitions, package hygiene | creating files, folders, assets or assemblies |
| 03 | [Architecture and design patterns](03-architecture-patterns.md) | MonoBehaviour vs ScriptableObject vs plain C#, SOLID, event channels, state/command/factory/pool, MVP, dependency wiring | designing a system or adding a class |
| 04 | [Unity scripting rules](04-unity-scripting-rules.md) | Lifecycle, serialization, null checks, finding objects, Awaitable vs coroutines, physics API, input in code, logging, asmdef usage | writing MonoBehaviour/ScriptableObject code |
| 05 | [Performance guidelines](05-performance.md) | Frame/memory budgets, allocation hygiene, pooling, physics, rendering and UI performance, import settings, profiling workflow | writing per-frame code, spawning, importing assets |
| 06 | [Version control with Git](06-version-control.md) | Editor VCS settings, `.meta` rules, what to commit, Git LFS, `.gitattributes`, UnityYAMLMerge, branches and commits, conflict resolution | committing, branching, merging |
| 07 | [Rendering and URP conventions](07-rendering-urp.md) | URP assets/renderers/quality tiers, Render Graph, lighting (APV/lightmaps), post-processing volumes, cameras, materials, Shader Graph, texture import | touching anything that renders |
| 08 | [Testing, tooling and IDE setup](08-testing-tooling.md) | Unity Test Framework, test assemblies, CLI test/build commands, Build Profiles, IDE setup, analyzers, Console hygiene | writing tests, building, setting up a machine |
| 09 | [Packages and game systems](09-packages-systems.md) | Package versions and policy; Input System, Cinemachine, UI Toolkit, physics layers, AI Navigation, animation, audio, Addressables (not used) | using a Unity package or engine subsystem |
| 11 | [Scenes, prefabs and team workflow](11-scenes-prefabs-workflow.md) | Bootstrap + additive level scenes, scene/prefab ownership and coordination, prefab workflow, ScriptableObject tunables, daily routine, build scene list | opening scenes, making prefabs, coordinating work |

## Document structure (all guidelines)

```
# NN. Title
> Scope / Applies to / Status
## TL;DR — rules at a glance        ≤ 15 numbered MUST / SHOULD / MAY / NEVER rules
## <topic sections>                 rule → *Why* → *Source* (link into ../reference/) or [project decision]
## Anti-patterns                    ❌ → ✅
## Review checklist                 what a reviewer or agent verifies
## Sources                          numbered list of reference files with their original URLs
```

## Conventions used in the documents

- **MUST / NEVER** — binding; a reviewer blocks on it. **SHOULD** — default, deviate with a stated reason. **MAY** — allowed.
- **[project decision]** — our choice among options Unity leaves open; change it only with team agreement, then update the guideline.
- Links of the form `../reference/<topic>/<file>.md` point at the offline copy of the Unity page; the file's front matter has the live `source_url`.
- Version facts are pinned to **Unity 6000.3.22f1**; when the project upgrades, re-check guideline 10 first.

## Root config files generated from these guidelines

| File | Generated from |
|---|---|
| `/.editorconfig` | [01 — Appendix: .editorconfig](01-csharp-style.md) |
| `/.gitattributes` | [06 — Appendix: .gitattributes](06-version-control.md) |
| `/.gitignore` | GitHub `Unity.gitignore` + the project additions listed in [06](06-version-control.md) |
| `/Assets/RootsDance/**` folder skeleton, `.asmdef` files | [02 — Appendix: folder tree](02-project-structure.md) |
| `/Assets/ScriptTemplates/*` | [01 — script templates](01-csharp-style.md) |
