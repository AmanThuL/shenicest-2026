# 11. Scenes, prefabs and team workflow

> **Scope:** How the team works inside the Editor without stepping on each other — scene architecture and loading, scene ownership, the prefab-first workflow, ScriptableObject tunables, conflict avoidance at the content level, the daily integration routine, the build scene list, and the end-to-end checklist for a new feature.
> **Applies to:** every `.unity`, `.prefab`, `.asset` and `.scenetemplate` under `Assets/RootsDance/`, the global scene list in `ProjectSettings/EditorBuildSettings.asset`, and every human or agent that opens the Editor.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

Folder names and asset naming are owned by [02 Project structure](./02-project-structure.md); Git commands, LFS, UnityYAMLMerge setup and conflict resolution by [06 Version control](./06-version-control.md); `GameBootstrap`, event channels and ScriptableObject class shapes by [03 Architecture](./03-architecture-patterns.md); lifecycle and `Awaitable` rules by [04 Unity scripting rules](./04-unity-scripting-rules.md); lighting setup by [07 Rendering](./07-rendering-urp.md); build profiles and tests by [08 Testing and tooling](./08-testing-tooling.md); Cinemachine, NavMesh and UI Toolkit placement by [09 Packages](./09-packages-systems.md). This document decides *what goes in which scene, who may touch it, and how content is built so two people can work on one level at the same time*.

## TL;DR — rules at a glance

1. **MUST** keep `Scenes/Bootstrap.unity` at build index 0 as the only persistent scene and load every other scene additively through `SceneLoader`; **NEVER** use `LoadSceneMode.Single` or call `SceneManager` from gameplay code.
2. **MUST** split every level into at least `<Level>_Environment.unity` (static geometry, sun, APV, Volume, NavMesh — the *active* scene) and `<Level>_Gameplay.unity` (spawns, triggers, enemies, Cinemachine cameras); one `LevelSO` asset lists a level's part scenes.
3. **MUST** avoid concurrent edits by splitting scenes, not by locking: each person works in their own part scene (split a level further if two people need it at once). Every scene, every *shared* prefab (`Prefabs/Systems/`, `Prefabs/Characters/`, `Prefabs/UI/`), `Input/RootsDance.inputactions` and every `ProjectSettings` file still has a default owner — give the team channel a heads-up before editing one you do not own or merging content into a shared scene; props/VFX prefabs and `.asset` data need no coordination.
4. **MUST** make a prefab out of anything placed more than once, anything spawned at runtime, and anything two people work on; unique, scene-bound objects (the level's terrain, one-off trigger) may stay plain GameObjects.
5. **MUST** edit prefab *assets* in Prefab Mode (double-click the asset; `P` on an instance); instance overrides are limited to Transform, name, active state and per-placement designer fields — structural changes happen in Prefab Mode or become a variant.
6. **MUST** resolve the Overrides dropdown before committing a scene — apply only to prefabs you own, revert everything else; **NEVER** "Apply All" without reading the list.
7. **MUST** keep tunables (speeds, health, prices, timings, spawn tables) in ScriptableObject assets under `Data/<Type>/`, never as numbers on scene objects; designers edit `.asset` files, not scenes.
8. **MUST** commit a scene or prefab only when you changed it on purpose (a file that only *opened* dirty gets the scene's **Discard changes**, not a save); one scene/prefab per commit, named in the message.
9. **MUST** bake lighting and NavMesh only as the owner of `<Level>_Environment`, with that scene open and active; commit the generated data in its own commit right after the scene commit, in the same pull request.
10. **MUST** run the daily routine: pull `develop` → open Editor → Play from `Bootstrap.unity` → work on a task branch in your own scenes → push; merge `develop` into your branch at least daily (branch model and commands in [06](./06-version-control.md)).
11. **MUST** treat the global scene list (`ProjectSettings/EditorBuildSettings.asset`) as owned by the integration owner: `Bootstrap` first, then `MainMenu`, then level parts, added through the pull request that adds the level; build profiles inherit it and never add a **Scene List** override.
12. **MUST** load scenes by full asset path constants in `ScenePaths` / `LevelSO`, awaited with `Awaitable.FromAsyncOperation(op, cancellationToken)`, then `SetActiveScene` the environment part.
13. **SHOULD** test a level by opening its parts additively and pressing Play there — `BootstrapLoader` adds `Bootstrap.unity` and `GameBootstrap` adopts the open level.
14. **SHOULD** create new level parts from the `Settings/SceneTemplates/LevelPart.scenetemplate` template, never from the Basic template (it adds a Camera the bootstrap already owns).
15. **NEVER** put `DontDestroyOnLoad` objects, a Unity `Camera` or an `AudioListener` in a content scene, nor geometry, lights, an APV or a Volume in `Bootstrap.unity`; **NEVER** reference `_Sandbox/` from a shipping scene or hand-edit/hand-merge `.unity`/`.prefab` YAML.

## Scene architecture

### The scene set

| Scene | Path | Loaded | Contains | Owner |
|---|---|---|---|---|
| Bootstrap | `Assets/RootsDance/Scenes/Bootstrap.unity` | always (build index 0) | `GameBootstrap` root with `SceneLoader` and persistent services; `Main Camera` (tag `MainCamera`: Camera + `CinemachineBrain` + `AudioListener`, per [09](./09-packages-systems.md)); `UI` root with the `UIDocument` screens (menu, HUD, pause) | integration owner |
| MainMenu | `Assets/RootsDance/Scenes/MainMenu.unity` | additive, after boot | menu backdrop, its sun/APV/Volume, a `CM_Menu_Static` camera | UI owner |
| PrefabStage | `Assets/RootsDance/Scenes/PrefabStage.unity` | never at runtime; not in the scene list | Prefab Mode editing environment (see [Editing](#editing-prefab-mode-not-the-scene)): sun, APV, Volume and a ground plane — no gameplay, no Camera | integration owner |
| Level environment | `Assets/RootsDance/Scenes/Levels/<Level>/<Level>_Environment.unity` | additive, **active scene** while the level runs | static geometry and props, Directional sun (Mixed), APV, Global Volume, Environment settings, reflection probes, `_NavMesh` with `NavMeshSurface`, baked lighting data | level artist |
| Level gameplay | `Assets/RootsDance/Scenes/Levels/<Level>/<Level>_Gameplay.unity` | additive, with its environment | player spawn, enemy spawners, triggers, interactables, pickups, `CinemachineCamera`s, level-specific `UIDocument` (rare) | level designer |
| Level lighting (optional) | `…/<Level>_Lighting.unity` | additive; becomes the active scene when present | sun, APV, Volume, Environment settings moved out of `_Environment` | lighting artist |
| Sandbox | `Assets/_Sandbox/<username>/*.unity` | never in a build | anything; opened by its author only | its author |

- **MUST** use this layout. A level is a folder of additive *part* scenes, never one "mega-scene". **[project decision — consistent with [02](./02-project-structure.md) and decision 13]**
- *Why:* "Large, single Unity scenes do not lend themselves well to collaboration. Break your levels into many smaller scenes so that artists and designers can collaborate better on a single level while minimizing the risk of conflicts." Two GameObjects in one scene file means two people's changes land in one file; Smart Merge handles simple cases, "more elaborate changes can result in unresolvable conflicts". The studio example in the scaling blog is the same shape: a main scene holding critical systems plus additively loaded title and play scenes.
- *Source:* [Organization e-book, "Split up your assets"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Organizing your project, "Split up your assets"](../reference/project-structure/how-to-organizing-your-project.md), [Authoring scenes and prefabs, "Scenes"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md), [Scaling workflows, "Keep scenes simple"](../reference/version-control/blog-scaling-workflows-lessons-from-medium-to-large-projects.md), [Work with multiple scenes](../reference/project-structure/manual-multisceneediting.md).

- **MUST** keep scene-dependent data in the scene that owns it: lights, lighting settings, lightmaps/APV data, environment (skybox, fog) and the Volume live in `<Level>_Environment` (or `_Lighting` if split out). Almost everything else lives in prefabs.
- *Why:* Unity's guidance is "storing scene-dependent data in scenes … Almost everything else can be stored in Prefabs." `RenderSettings` and `LightmapSettings` are per scene and, with several scenes open, Unity uses the *active* scene's settings — so the part that holds them must be the one `SceneLoader` activates.
- *Source:* [Authoring scenes and prefabs, "Scenes"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md), [Set up multiple scenes, "Scene-specific settings"](../reference/project-structure/manual-setupmultiplescenes.md); lighting rules in [07](./07-rendering-urp.md).

- **MUST** keep the bootstrap scene free of content: no geometry, no lights, no APV, no Volume. It holds only the persistent services, the single Unity `Camera` and the persistent UI. Persistence comes from the scene never being unloaded; `DontDestroyOnLoad` inside `PersistentSingleton` (see [03](./03-architecture-patterns.md)) is only a guard against an accidental `Single` load and is used on root objects only.
- *Source:* [Object.DontDestroyOnLoad](../reference/scripting/scriptref-object-dontdestroyonload.md) ("only works for root GameObjects"), [Set up multiple scenes, "Multiple scenes in Play mode"](../reference/project-structure/manual-setupmultiplescenes.md); camera/listener placement in [09](./09-packages-systems.md), bootstrap lighting rule in [07](./07-rendering-urp.md). **[project decision]**

### Hierarchy conventions inside a scene

- **MUST** group scene content under root GameObjects named with a leading underscore, identity transform, never moved or animated: in `_Environment` → `_Lighting`, `_Geometry`, `_Props`, `_NavMesh`; in `_Gameplay` → `_Cameras`, `_Spawns`, `_Triggers`, `_Interactables`. Characters and other animated prefab instances sit at the scene root, not under a group. **[project decision on names]**
- *Why:* Grouping by parenting is the Hierarchy's organisational tool; a leading underscore sorts the group first. Unity recommends "placing all animated hierarchies at the root node of the scene" because deep hierarchies cost CPU.
- *Source:* [Manage GameObjects in the Hierarchy, "Group items using parenting"](../reference/project-structure/manual-hierarchy.md), [Organization e-book, naming (underscore prefix)](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Authoring scenes and prefabs, "Avoid deep hierarchies"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

### Scene templates

- **MUST** create new level parts from `Assets/RootsDance/Settings/SceneTemplates/LevelPart.scenetemplate` (New Scene dialog: **File > New Scene**, pick the template, tick **Load Additively**). The template contains the group roots above and nothing else — no Camera, no Directional Light. To create or update the template, open a clean part scene and use **File > Save As Scene Template** (or right-click a scene asset → **Create > Scene Template From Scene**). **[project decision]**
- *Why:* "Unity creates every new scene from a scene template"; the Basic template used by **Assets > Create > Scene** adds a Camera and Light, which in our architecture belong to the bootstrap scene and to `_Environment` respectively. A project template "standardize[s] new scene creation".
- *Source:* [Creating, loading, and saving scenes](../reference/project-structure/manual-scenes-working-with.md), [Introduction to scenes, "Scene Templates"](../reference/project-structure/manual-creatingscenes.md), [Scene templates](../reference/project-structure/manual-scene-templates.md); creation menu paths verified on [Creating scene templates (6000.3 manual)](https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates-creating.html). Folder per [02](./02-project-structure.md).

### Loading conventions

- **MUST** route every scene change through the `SceneLoader` component on the `GameBootstrap` root. Gameplay code raises a `LevelEventChannelSO` (`Data/Events/LoadLevelRequested.asset`, payload `LevelSO`) and never references `SceneManager`. **[project decision — the channel base class is defined in [03](./03-architecture-patterns.md)]**
- **MUST** load with `SceneManager.LoadSceneAsync(path, LoadSceneMode.Additive)` by **full asset path** (`"Assets/RootsDance/Scenes/…​.unity"`), never by build index or bare name; before loading, unload every loaded scene except `Bootstrap` by walking `SceneManager.sceneCount` / `GetSceneAt(i)` and calling `SceneManager.UnloadSceneAsync(scene)` — not a list the loader keeps, so a level adopted from the Editor (see [Testing a scene in isolation](#testing-a-scene-in-isolation)) is unloaded too.
- *Why:* `Single` "closes all current loaded Scenes" — including the bootstrap. The synchronous `LoadScene` loads "in the next frame", stutters and forces pending async operations to complete. Unity's own notes: "Loading Scenes by index can be fragile due to potential reordering; the recommended best practice is to load scenes by path", and bare names are ambiguous when two scenes share a name (our `_Environment` parts do). `GetSceneAt` enumerates every loaded scene, so the unload loop needs no bookkeeping that an Editor-adopted level would bypass.
- *Source:* [LoadSceneMode](../reference/scripting/scriptref-scenemanagement-loadscenemode.md), [SceneManager.LoadScene](../reference/scripting/scriptref-scenemanagement-scenemanager-loadscene.md), [SceneManager.LoadSceneAsync](../reference/scripting/scriptref-scenemanagement-scenemanager-loadsceneasync.md), [SceneManager, "Notes"](../reference/scripting/scriptref-scenemanagement-scenemanager.md), [SceneManager.UnloadSceneAsync](../reference/scripting/scriptref-scenemanagement-scenemanager-unloadsceneasync.md).

- **MUST** call `SceneManager.SetActiveScene` on the level's first part (`_Environment`, or `_Lighting` when it exists) once loaded, and `Resources.UnloadUnusedAssets()` after unloading the previous level.
- *Why:* The active scene is "the target for new GameObjects created through scripts" and supplies the rendering/lighting settings. `UnloadSceneAsync` does not unload assets: "In order to free up asset memory call Resources.UnloadUnusedAssets" (a `Single` load would do this automatically; additive loads do not).
- *Source:* [Set up multiple scenes, "Set Active Scene"](../reference/project-structure/manual-setupmultiplescenes.md), [SceneManager.UnloadSceneAsync](../reference/scripting/scriptref-scenemanagement-scenemanager-unloadsceneasync.md), [Resources.UnloadUnusedAssets](../reference/scripting/scriptref-resources-unloadunusedassets.md).

- **MUST** await scene operations through `Awaitable.FromAsyncOperation(op, cancellationToken)` with the loader's `destroyCancellationToken`, following the `Awaitable` rules in [04](./04-unity-scripting-rules.md) (token on every async method, `async void` entry point with `try/catch`).
- *Source:* [Awaitable.FromAsyncOperation](../reference/scripting/scriptref-awaitable-fromasyncoperation.md), [AsyncOperation](../reference/scripting/scriptref-asyncoperation.md) ("can be … awaited with the await operator"), [MonoBehaviour.destroyCancellationToken](../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md), [Awaitable code examples](../reference/scripting/manual-async-awaitable-examples.md).

```csharp
// Assets/RootsDance/Scripts/Runtime/App/ScenePaths.cs — the only place scene paths are spelled out.
namespace RootsDance.App
{
    public static class ScenePaths
    {
        public const string k_Bootstrap = "Assets/RootsDance/Scenes/Bootstrap.unity";
        public const string k_MainMenu = "Assets/RootsDance/Scenes/MainMenu.unity";
    }
}
```

```csharp
// Assets/RootsDance/Scripts/Runtime/Data/LevelSO.cs — one asset per level under Data/Levels/.
using System.Collections.Generic;
using UnityEngine;

namespace RootsDance.Data
{
    [CreateAssetMenu(fileName = "Level", menuName = "RootsDance/Levels/Level")]
    public class LevelSO : ScriptableObject
    {
        [Tooltip("Full asset paths in load order. The FIRST entry becomes the active scene, so list the _Environment (or _Lighting) part first.")]
        [SerializeField] private string[] m_scenePaths;

        public IReadOnlyList<string> ScenePaths => m_scenePaths;
    }
}
```

```csharp
// Assets/RootsDance/Scripts/Runtime/App/SceneLoader.cs — lives on the GameBootstrap root in Bootstrap.unity.
using System;
using System.Collections.Generic;
using System.Threading;
using RootsDance.Core;
using RootsDance.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    public class SceneLoader : MonoBehaviour
    {
        private bool m_isLoading;

        public bool IsLoading => m_isLoading;

        // Fire-and-forget entry point (called by the LoadLevelRequested channel listener).
        public void RequestLoad(LevelSO level)
        {
            LoadLevelEntryAsync(level, destroyCancellationToken);
        }

        public async Awaitable LoadLevelAsync(LevelSO level, CancellationToken cancellationToken)
        {
            if (m_isLoading)
            {
                Log.Warning("Scene load already in progress; request ignored.", this);
                return;
            }

            m_isLoading = true;

            try
            {
                // Unload every loaded scene except Bootstrap — including a level adopted from the Editor.
                List<Scene> scenesToUnload = new List<Scene>();

                for (int i = 0; i < SceneManager.sceneCount; i++)
                {
                    Scene scene = SceneManager.GetSceneAt(i);

                    if (scene.isLoaded && scene.path != ScenePaths.k_Bootstrap)
                    {
                        scenesToUnload.Add(scene);
                    }
                }

                for (int i = 0; i < scenesToUnload.Count; i++)
                {
                    AsyncOperation unload = SceneManager.UnloadSceneAsync(scenesToUnload[i]);
                    await Awaitable.FromAsyncOperation(unload, cancellationToken);
                }

                await Awaitable.FromAsyncOperation(Resources.UnloadUnusedAssets(), cancellationToken);

                IReadOnlyList<string> paths = level.ScenePaths;

                for (int i = 0; i < paths.Count; i++)
                {
                    AsyncOperation load = SceneManager.LoadSceneAsync(paths[i], LoadSceneMode.Additive);
                    await Awaitable.FromAsyncOperation(load, cancellationToken);
                }

                // First part = the one holding lighting/environment settings.
                SceneManager.SetActiveScene(SceneManager.GetSceneByPath(paths[0]));
            }
            finally
            {
                m_isLoading = false;
            }
        }

        private async void LoadLevelEntryAsync(LevelSO level, CancellationToken cancellationToken)
        {
            try
            {
                await LoadLevelAsync(level, cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Loader destroyed (Play mode exit): nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }
    }
}
```

- **SHOULD** react to `SceneManager.sceneLoaded` only inside `SceneLoader` (subscribe in `OnEnable`, unsubscribe in `OnDisable`); gameplay objects learn about level state through event channels, not by listening to `SceneManager`.
- *Source:* [SceneManager.sceneLoaded](../reference/scripting/scriptref-scenemanagement-scenemanager-sceneloaded.md) (raised after `OnEnable`, before `Start`).

### Testing a scene in isolation

Pressing Play in a content scene must "just work" without first opening `Bootstrap.unity`.

- **MUST** ship the `BootstrapLoader` below in `RootsDance.Runtime`. At `RuntimeInitializeLoadType.AfterSceneLoad` it checks whether the bootstrap scene is loaded and, if not, loads it additively. In a Player build `Bootstrap` is already index 0, so the method is a no-op. **[project decision]**
- **MUST** make `GameBootstrap.Start` *adopt* an already-open level: if any loaded scene other than `Bootstrap` exists, it leaves the Editor's active scene as is and skips loading `MainMenu`; otherwise it requests the main menu. **[project decision]**
- **MUST NOT** depend on `GameBootstrap` or its services inside `Awake`, `OnEnable` or `Start` of content-scene components. They reach the bootstrap through event channels (assets that always exist) and resolve `GameBootstrap.Instance`, if they really need it, lazily at first use. When Play starts in a content scene the bootstrap arrives one frame later; code that follows [03](./03-architecture-patterns.md) and [04](./04-unity-scripting-rules.md) does not notice.
- Note: `BootstrapLoader` also runs for every PlayMode test run — the Test Runner's generated `InitTestScene*` scene is a non-bootstrap scene — so PlayMode tests always execute with `Bootstrap.unity` loaded additively and `GameBootstrap` in adopt mode; write PlayMode tests accordingly ([08](./08-testing-tooling.md)).
- *Why:* "The SceneManager API should only be used in Play mode", and in Play mode "only scenes listed in EditorBuildSettings are available to load" — `Bootstrap` is always listed, sandbox scenes need not be. `AfterSceneLoad` is the first callback where "objects of the scene are considered fully loaded", so `Scene.isLoaded` ("set to true after loading has completed and objects have been enabled") is reliable there; `LoadScene` then adds the bootstrap "in the next frame". The adopt check also tests `isLoaded` because `GetSceneAt` "includes scenes that are currently loading or unloading" and scenes Alt/Option-dragged into the Hierarchy "without loading" them.
- *Source:* [RuntimeInitializeOnLoadMethodAttribute](../reference/scripting/scriptref-runtimeinitializeonloadmethodattribute.md), [SceneManager, "Scene management in the Editor", `sceneCount`/`GetSceneAt`](../reference/scripting/scriptref-scenemanagement-scenemanager.md), [SceneManager.LoadScene](../reference/scripting/scriptref-scenemanagement-scenemanager-loadscene.md), [Set up multiple scenes (Alt-drag tip)](../reference/project-structure/manual-setupmultiplescenes.md); `Scene.isLoaded` verified on [Scene.isLoaded (6000.3 API)](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene-isLoaded.html).

```csharp
// Assets/RootsDance/Scripts/Runtime/App/BootstrapLoader.cs
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.App
{
    public static class BootstrapLoader
    {
        [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
        private static void EnsureBootstrapScene()
        {
            if (SceneManager.GetSceneByPath(ScenePaths.k_Bootstrap).isLoaded)
            {
                return; // normal start: Bootstrap is build index 0
            }

            SceneManager.LoadScene(ScenePaths.k_Bootstrap, LoadSceneMode.Additive);
        }
    }
}
```

```csharp
// Inside GameBootstrap (see 03 for the PersistentSingleton base).
private void Start()
{
    for (int i = 0; i < SceneManager.sceneCount; i++)
    {
        Scene scene = SceneManager.GetSceneAt(i);

        // isLoaded excludes scenes Alt/Option-dragged into the Hierarchy for reference only.
        if (scene.isLoaded && scene.path != ScenePaths.k_Bootstrap)
        {
            return; // a level is already open in the Editor: adopt it, keep its active scene
        }
    }

    m_loadLevelRequested.RaiseEvent(m_mainMenuLevel); // LevelEventChannelSO + LevelSO for MainMenu
}
```

- **SHOULD** open a level for editing as: open `<Level>_Environment.unity`, then right-click `<Level>_Gameplay.unity` → **Open Scene Additive**, and set the environment part active (scene **⋮ > Set Active Scene**) before touching lighting. Press Play there. Use **Alt/Option-drag** to add a scene to the Hierarchy without loading it when you only need it for reference.
- *Source:* [Set up multiple scenes](../reference/project-structure/manual-setupmultiplescenes.md).
- Scene-level automated checks use `EditorSceneManager` in EditMode tests with a `[TearDown]` that restores a clean scene — rules in [08](./08-testing-tooling.md). *Source:* [Course 11. Scene-based tests](../reference/testing-tooling/manual-scene-based-tests.md).

## Scene ownership and coordination

Git has no file locking for our YAML files (we deliberately do not use `git lfs lock`, see [06](./06-version-control.md)), so conflicts are avoided structurally — by the multi-scene split — plus a lightweight heads-up for the few genuinely shared files.

- **MUST** treat the following as **single-owner files**: every `.unity`; every prefab under `Prefabs/Systems/`, `Prefabs/Characters/` and `Prefabs/UI/`; `Input/RootsDance.inputactions`; everything in `ProjectSettings/`; the URP assets, Lighting Settings and Volume Profiles under `Settings/`; `Packages/manifest.json`. Everything else (props, VFX, ScriptableObject data assets, scripts) is multi-owner and relies on Smart Merge plus small commits. **[project decision]**
- **MUST** rely on the multi-scene split as the primary conflict defence: work in your own part scenes. If two people need the same level at the same time, split it further (another part scene — `_Lighting`, a second gameplay part) instead of taking turns on one file. **[project decision]**
- **MUST** give the team channel a heads-up before editing a single-owner file you do not own, and before merging content into a shared scene (`Bootstrap.unity`, `MainMenu.unity`, another owner's level part) — a short "editing `<path>` now" / "merged into `<scene>`, pushed on `<branch>`" message is enough. Push the same session; **NEVER** sit on unpushed scene edits overnight. **[project decision]**
- **MUST** request changes to a file you do not own instead of editing it: message the owner, or move the change into something you own — a new prefab, a prefab variant, or a ScriptableObject. If you need to *place* your prefab in someone's scene, send them the prefab path and the position.
- **MAY** open any scene read-only at any time to look around; close it with **Discard changes** if it became dirty.
- *Why:* Unity's scaling guidance: "Define who can modify specific scenes or prefabs. Then team members request changes outside their ownership instead of editing assets directly." Unity's e-book: "If you accidentally commit a change to a scene that someone else is working on, that could cause a headache for them." Unity also suggests a "semaphore system" (a shared LOCK/UNLOCK log); for a team this small we chose scene splitting plus a heads-up instead — a lock log is more bookkeeping than it saves. True locking is what UVCS/Perforce offer; with Git it would need LFS, which we reserve for binaries.
- *Source:* [Scaling workflows, "Master the human element"](../reference/version-control/blog-scaling-workflows-lessons-from-medium-to-large-projects.md), [Organization e-book, "Avoid indiscriminate commits", "Locking files"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Authoring scenes and prefabs, "File locking"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md); `.inputactions` single-owner rule also in [09](./09-packages-systems.md).

Default owners by role (pin the actual names in the team channel): **integration owner** — `Bootstrap.unity`, `ProjectSettings/`, `Packages/`, scene list, build profiles; **level artist** — `<Level>_Environment` (+ `_Lighting`), environment prefabs; **level designer** — `<Level>_Gameplay`, `LevelSO` assets, spawn/trigger prefabs; **gameplay owner** — character/system prefabs and their configs; **UI owner** — `MainMenu.unity`, `Prefabs/UI/`, UXML/USS. One person can hold several roles; a role never has two people at once. **[project decision]**

## Prefab-first workflow

### What becomes a prefab

- **MUST** make a prefab for: anything placed more than once (props, enemies, pickups, lights that repeat); anything instantiated at runtime (projectiles, VFX, pooled objects — see [03](./03-architecture-patterns.md)/[05](./05-performance.md)); the player, every character, every camera rig, every UI screen, every system root (`GameBootstrap`); and anything two people need to edit at the same time.
- **MAY** keep as plain GameObjects: objects unique to one scene that only that scene's owner edits (the terrain, a one-off trigger volume, the group roots).
- *Why:* The prefab system keeps all copies in sync and lets you "change the Prefab rather than the scene it's used in to avoid conflicts with anyone working on the scene. Prefab changes can often be easier to read when doing a diff." Unity also warns "Everything does not need to be a Prefab … If an object is unique to a scene or Prefab, there is no need to create a Prefab for it."
- *Source:* [Introduction to prefabs](../reference/project-structure/manual-prefabs-introduction.md), [Organization e-book, "Split up your assets"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Authoring scenes and prefabs, "Prefabs"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

- **MUST** give every GameObject inside a prefab a unique name and avoid two components of the same type on one GameObject.
- *Why:* Replacing a prefab asset or an instance's asset matches children and components **by name**; duplicates make the matching "unpredictable".
- *Source:* [Create prefabs, "Replace a prefab asset"](../reference/project-structure/manual-creatingprefabs.md).

### Editing: Prefab Mode, not the scene

- **MUST** edit prefab assets in Prefab Mode: double-click the asset (isolation) or select an instance and press **P** (in context). Use **isolation** when changing the root Transform (it cannot be edited in context) or when the prefab must be seen against the editing environment scene. Leave **Auto Save** on; if you turn it off for a heavy prefab, save before leaving Prefab Mode.
- *Why:* "Editing Prefab properties in the scene view can result in overrides residing in the wrong Prefab or in the scene itself. This can have unintended consequences and cause merge conflicts." Prefab Mode "lets you decide whether you want to make changes to a Prefab instance or make changes directly to a Prefab Asset".
- *Source:* [Edit prefab assets](../reference/project-structure/manual-editinginprefabmode.md), [Authoring scenes and prefabs, "Prefabs"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md), [Introducing new Prefab workflows, "Prefab Mode"](../reference/project-structure/blog-introducing-new-prefab-workflows.md).

- **SHOULD** set **Edit > Project Settings > Editor > Prefab Mode > Editing Environments** to a small sandbox-free lighting scene (`Scenes/PrefabStage.unity`, owned by the integration owner) so prefabs are authored under the project's lighting. **[project decision]**
- *Source:* [Edit prefab assets, "Edit a prefab asset in isolation"](../reference/project-structure/manual-editinginprefabmode.md).

### Nested prefabs and variants

- **MUST** compose big things from small prefabs (a house from wall/roof/door prefabs; an enemy from body + weapon prefabs) by dragging prefabs into the open Prefab Mode hierarchy, and keep nesting **at most 4 levels deep**. **[project decision on the limit]**
- *Why:* Nested prefabs keep their link to their own asset while forming part of the parent; Unity recommends keeping hierarchies "below 5–7 levels of depth" because depth costs performance and makes overrides confusing.
- *Source:* [Nest prefab instances in other prefabs](../reference/project-structure/manual-nestedprefabs.md), [Authoring scenes and prefabs, "Prefabs"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md), [Productivity e-book, "Leverage nested prefabs"](../reference/project-structure/ebook-tips-to-increase-productivity-with-unity-6.md).

- **MUST** use a **Prefab Variant** (right-click the base asset → **Create > Prefab Variant**; it is created next to its base) when the functionality is identical and only values or visuals differ — enemy tiers, coloured pickups, themed props. **NEVER** build a complex character-customisation or skinning system out of variants.
- **MUST** derive art prefabs from the imported model as a variant (drag the `.fbx` into the scene, then drag the instance into `Prefabs/<Category>/` and choose **Prefab Variant**) and keep structural edits to the variant minimal; the gameplay prefab then nests that art variant. **[project decision]**
- *Why:* A variant "inherits properties from a base prefab. Overrides in the variant take precedence"; Unity advises variants "with care … when the core building blocks of an object are identical with only simple differences". Converting an FBX straight into a normal prefab "will break the prefab if changes are made to the FBX file"; a variant of the model prefab updates when the artist re-exports.
- *Source:* [Create variations of prefabs](../reference/project-structure/manual-prefabvariants.md), [Authoring scenes and prefabs, "Prefabs", "FBX and prefabs"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md), [Productivity e-book, "Use Prefab Variants for more efficient team work"](../reference/project-structure/ebook-tips-to-increase-productivity-with-unity-6.md).

### Override discipline (apply / revert rules)

- **MUST** limit overrides on prefab instances placed in scenes to: Transform, GameObject name, active state, and serialized fields that are genuinely per placement (patrol points, a spawner's `EnemyConfigSO` reference, a portal's `LevelSO`, a door's target). Adding or removing components or children on an instance is a structural change → do it in Prefab Mode, or create a variant.
- **MUST** open the instance's **Overrides** dropdown before saving a scene and leave only intended overrides. Per property: right-click → **Apply to Prefab '<X>'** (changes every instance of X), **Apply as Override in Prefab '<Parent>'** (changes only this parent's nested copy), or **Revert**. Apply only to assets you own (ownership section); otherwise revert and ask.
- **NEVER** use **Apply All** on an instance with more than one override without reading the list; **NEVER** apply a "quick fix" from a scene instance into a shared prefab that someone else owns.
- *Why:* Applying at the wrong level silently changes other prefabs or leaks data into the scene file. The three apply targets have exactly these semantics in Unity's tutorial; the 2018 Apply button problem ("you could accidentally apply changes to the Prefab Asset that you had no good way of getting an overview of") is what the Overrides dropdown fixes — if you use it.
- *Source:* [Introduction to Nested Prefabs, step 4](../reference/project-structure/tutorial-introduction-to-nested-prefabs.md) (the three apply targets), [Overriding prefab instance data (index)](../reference/project-structure/manual-prefabs-override.md), [Create variations of prefabs, "Edit a prefab variant"](../reference/project-structure/manual-prefabvariants.md), [Introducing new Prefab workflows](../reference/project-structure/blog-introducing-new-prefab-workflows.md); the **Overrides** dropdown and **Apply All** labels are on [Override prefab instances (6000.3 manual)](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabInstanceOverrides.html), which the local index links but does not contain.

- **NEVER** unpack a shared prefab instance in a scene. Unpacking is for the deliberate "standard prefab out of an exploded model" workflow only, done by the prefab owner in `Prefabs/`.
- *Source:* [Prefabs (index: "Revert a prefab instance to a GameObject")](../reference/project-structure/manual-prefabs.md), [Authoring scenes and prefabs, "FBX and prefabs"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md).

- **SHOULD** keep occasionally-used visuals (hit VFX, death effects, detachable parts) *out* of the character prefab and spawn them from a pool; everything inside a prefab is instantiated with it.
- *Source:* [Authoring scenes and prefabs, "Prefabs"](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md); pooling in [05](./05-performance.md).

```text
✅ Prefab layout for an enemy
Prefabs/Characters/EnemyHoverBot.prefab            (gameplay root: controller, health, colliders, Rigidbody)
  └─ HoverBotArt (nested: Prefabs/Characters/Art/HoverBotArt.prefab, variant of Meshes/Characters/HoverBot.fbx)
  └─ WeaponBlaster (nested: Prefabs/Props/WeaponBlaster.prefab)
Prefabs/Characters/EnemyHoverBot_Elite.prefab      (variant: different EnemyConfigSO + material override)
Scene Forest_Gameplay: 6 instances, overrides = Transform + patrol points only

❌ Six hand-edited HoverBot copies in the scene, one with an extra collider, one with a tweaked speed field
```

## ScriptableObject assets for tunables

- **MUST** keep every tunable value in a ScriptableObject asset under `Assets/RootsDance/Data/<Type>/` (class shapes in [03](./03-architecture-patterns.md), the `SO` suffix rule in [01](./01-csharp-style.md), folder in [02](./02-project-structure.md)). Scene objects and prefabs hold a *reference* to the asset, never the number itself. Level definitions (`LevelSO`), spawn tables, enemy/weapon/pickup configs and event channels are all `.asset` files.
- **MUST** create assets through the `[CreateAssetMenu]` entries (`Assets > Create > RootsDance > …`) and edit them in the Inspector, one logical group per file — `Data/Enemies/HoverBot.asset`, `Data/Enemies/HoverBot_Elite.asset` — so two designers editing two enemies touch two files.
- **MUST** remember that Inspector edits to a ScriptableObject made **during Play mode are kept** (they are assets, not scene state). Tune in Play mode on purpose, then either commit the asset or revert it in Git; never assume Play-mode exit resets it.
- **SHOULD** guard designer-edited fields with `[Range]`/`[Min]` and `OnValidate` clamping (rules in [04](./04-unity-scripting-rules.md)).
- **MUST** give content assets (investigation objects, plants, puzzles, journal/report entries) the Odin layout from [12](./12-odin-inspector.md): five standard `[TitleGroup]` sections, `[Required]` references, `[ValidateInput]` IDs, `[AssetSelector]` pickers — so a designer can fill in `FL-001` without opening a script. Optional: the `RootsDance > Content Browser` window described there once two content types exist.
- *Why:* ScriptableObjects are "useful when you're collaborating with non-programmers like artists and designers; they can edit game data without touching code". "If two people change different parts of the same prefab or scene, this results in a time-wasting merge conflict. Breaking off shared data into smaller files and assets reduces these problems" and "can also help with version control and prevent merge conflicts when teammates work on the same scene or prefab." Play-mode persistence: "changes to their values are saved regardless of whether Unity is in Play mode … This can, however, also be a liability if you want to revert those changes."
- *Source:* [Manual: ScriptableObject](../reference/scripting/manual-class-scriptableobject.md), [Productivity e-book, "Use ScriptableObjects to separate data from logic"](../reference/project-structure/ebook-tips-to-increase-productivity-with-unity-6.md), [SO e-book, "Architectural benefits"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md), [6 ways ScriptableObjects can benefit your team](../reference/design-patterns/blog-6-ways-scriptableobjects-can-benefit-your-team-and-your-code.md), [Direct reference asset management](../reference/project-structure/manual-assets-direct-reference.md).

Division of labour **[project decision]**: programmers create the SO *class* and the first asset with sane defaults in the same PR as the feature; designers own the asset values from then on and never need a code change to add a variant (new `.asset`, new variant prefab referencing it).

## Avoiding merge conflicts at the content level

Git-level defences (Force Text, UnityYAMLMerge, LFS, branch model) are in [06](./06-version-control.md). The content-level rules that keep those tools from ever being needed:

| File kind | Who edits | How to keep it mergeable |
|---|---|---|
| `.unity` | its owner | small part scenes; prefabs for content; no tunables; Discard instead of saving accidental dirt |
| `.prefab` (shared) | its owner | edit in Prefab Mode; variants for differences; unique child names |
| `.prefab` (props, VFX) | anyone | one prefab per commit; Smart Merge handles disjoint property edits |
| `.asset` (SO data) | designers | one asset per logical thing; announce bulk re-tunes |
| `.asset` (Lighting Data, NavMesh data) | scene owner only | regenerated, never merged: bake, commit in its own commit in the scene's PR |
| `.inputactions`, `ProjectSettings/*`, `Packages/*.json` | integration owner (or with a heads-up) | own `chore:` commit, announced |
| `.scenetemplate`, build profiles | integration owner | rare, own commit |

- Staging rules are in [06](./06-version-control.md) (TL;DR 8: stage by name, never `git add -A`). Content-level addition **[project decision]**: one scene or prefab per commit, message naming the asset (`content(forest): place spawn points in Forest_Gameplay`). Unity warns that scenes, prefabs and sprite atlases can be marked changed "even though you didn't intend to make any changes to them" — use the scene **⋮ > Discard changes** or leave the file unstaged.
- *Source:* [Best practices for version control, "Commit little, commit often", "Avoid indiscriminate commits"](../reference/version-control/how-to-version-control-systems.md), [Organization e-book, same sections](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Set up multiple scenes, "Discard changes"](../reference/project-structure/manual-setupmultiplescenes.md); commit-message format in [06](./06-version-control.md).

- Moving, renaming and deleting assets follows [06](./06-version-control.md) TL;DR 3 (inside the Editor so the `.meta` follows).

- **MUST** bake lighting only as the owner of `<Level>_Environment` (or `_Lighting`), with that scene active, and commit the resulting Lighting Data Asset and NavMesh data in their own commit (per [06](./06-version-control.md)) inside the same pull request as the scene change they belong to. **NEVER** bake someone else's scene "to see it properly" and commit the result.
- *Why:* Baked data is a separate asset "so that changes to the precomputed lighting data do not result in changes to the Scene file", but it is regenerated output: two bakes never merge, and a bake on a stale scene ships wrong lighting. Lighting settings come from the active scene.
- *Source:* [Lighting Data Assets](../reference/version-control/manual-lightmapsnapshot.md), [Set up multiple scenes, "Scene-specific settings"](../reference/project-structure/manual-setupmultiplescenes.md); bake settings in [07](./07-rendering-urp.md), NavMesh in [09](./09-packages-systems.md).

- **MUST** keep a scene conflict out of the Editor: if `git merge develop` reports a conflict in a `.unity`/`.prefab`, follow the procedure in [06](./06-version-control.md) (UnityYAMLMerge, else the owner's side wins and the other person redoes the smaller change in the Editor). Scene files are never hand-merged. **[project decision 13]**
- *Source:* [Smart merge](../reference/version-control/manual-smartmerge.md), [Scaling workflows, "Master the human element"](../reference/version-control/blog-scaling-workflows-lessons-from-medium-to-large-projects.md) ("Preventing the conflicts is usually a better strategy than trying to solve them").

## Daily integration routine

Editor-side routine for every teammate and agent; the branch model (`main` = release line, `develop` = integration branch, task branches `<type>/<kebab-name>` from `develop`) and the matching Git commands are the "Branches, commits and cadence" section of [06](./06-version-control.md). **[project decision]**

1. **Start of session** — pull `develop`; open the project; wait for the import to finish; open `Bootstrap.unity` and press Play: the main menu must appear and a level must load. If it does not, fix or report *before* starting new work (`develop` must open and play after every merge; `main` always does).
2. **Claim** — if you will touch a shared scene or a single-owner file outside your own, give the team channel a heads-up first; create your task branch from `develop` (or switch to it and merge `develop` in).
3. **Work in small loops** — edit prefab → save → Play in the open level → commit that prefab. Place instances in a scene you own → resolve Overrides → save → commit that scene. Tune → commit the `.asset`.
4. **Integrate at least once a day** — merge `develop` into your branch, reopen the Editor if scripts changed, Play from `Bootstrap.unity` again, push, open/refresh the pull request against `develop`.
5. **End of session** — nothing uncommitted in a scene or shared prefab; push (announce it if you touched a shared scene); if the PR is green and reviewed, merge it into `develop` (merge commit, per [06](./06-version-control.md)).
6. **Integration owner, once a day** — after the last PR of the day has merged: pull `develop`, Play from `Bootstrap.unity`, run the EditMode/PlayMode suites, fast-forward `main` to `develop` (integration owner's loop in [06](./06-version-control.md)), produce the Dev build from `main` with the build profile ([08](./08-testing-tooling.md)), and post the build link. This is the build the team plays and the one demoed if the hackathon ended today.

- *Why:* "As often as it makes sense, pull the latest changes … It's not good to work off in isolation, as this only increases the likelihood of merge conflicts"; "Daily merges from main … reduce the size and complexity of final merges" (Unity's "main" is our integration branch `develop`); small commits make a bad change "much more easily" revertible.
- *Source:* [Best practices for version control, "Get the latest, first"](../reference/version-control/how-to-version-control-systems.md), [Organization e-book, "Get the latest"](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md), [Scaling workflows, "Master the human element"](../reference/version-control/blog-scaling-workflows-lessons-from-medium-to-large-projects.md).

## Build Profiles scene list ownership

- **MUST** keep the **global scene list** (`ProjectSettings/EditorBuildSettings.asset`, shown under **File > Build Profiles** on the platform entries) in this order: `Bootstrap` (index 0), `MainMenu`, then every level part grouped by level (`Forest_Environment`, `Forest_Gameplay`, …). Nothing from `_Sandbox/`. **[project decision]**
- **MUST** let build profiles inherit that list: do not add the **Scene List** override via **Add Settings** on `Windows-Release`, `macOS-Release`, `Web-Release` or the `-Dev` profiles ([08](./08-testing-tooling.md)) unless a profile genuinely needs a different set (a demo build that ships one level). An overridden list is a second list to keep in sync.
- **MUST** change the scene list only in the pull request that adds or removes the level (new `LevelSO` + part scenes + scene-list entry together), and only the integration owner merges it. Temporarily disabling a level = untick its checkbox (**Exclude**), not removing it, so the path stays visible in review.
- *Why:* "The first enabled scene in the Scene list (with a build index of 0) loads automatically when the Player starts"; `LoadSceneAsync` can only load scenes in that list, in Play mode too; earlier scenes "load faster due to optimized assignment of their dependent content". Build profiles "do not override the scene list unless you add it"; the file "should be included in source control" and is one shared YAML file — the classic conflict magnet.
- *Source:* [SceneManager, "The scene list"](../reference/scripting/scriptref-scenemanagement-scenemanager.md), [Manage scenes in a build](../reference/testing-tooling/manual-build-profile-scene-list.md), [Introduction to build profiles](../reference/testing-tooling/manual-build-profiles.md), [Build Profiles window reference, "Add Settings"](../reference/testing-tooling/manual-build-profiles-reference.md), [EditorBuildSettings](../reference/testing-tooling/scriptref-editorbuildsettings.md).

## Checklist: adding a feature end-to-end

Example: "patrolling enemy that drops a key in the Forest level".

- [ ] **Claim**: `Forest_Gameplay.unity` is your scene as level designer; give the channel a heads-up for any shared prefab you will change; branch `feat/forest-patrol-enemy` from `develop`.
- [ ] **Code**: scripts in `Scripts/Runtime/<Feature>/` in the right assembly and namespace ([02](./02-project-structure.md), [03](./03-architecture-patterns.md)); logic that can be unit-tested is a plain class with an EditMode test ([08](./08-testing-tooling.md)).
- [ ] **Data**: `EnemyConfigSO` class + `Data/Enemies/Patroller.asset`; a `LevelSO` already exists for Forest; any new message is an event-channel asset in `Data/Events/`.
- [ ] **Prefab**: build `Prefabs/Characters/EnemyPatroller.prefab` in Prefab Mode (nested art variant + weapon prefab); unique child names; no tunables on components, only SO references; spawned VFX come from a pool, not nested.
- [ ] **Variant**: a second tier is `EnemyPatroller_Elite.prefab` (variant) + `Patroller_Elite.asset`, not a second hand-built prefab.
- [ ] **Placement**: instances (or a spawner prefab) in `Forest_Gameplay` under `_Spawns`; overrides = Transform + patrol points only; Overrides dropdown clean; `_Environment` untouched (if the level geometry must change, ask its owner).
- [ ] **Isolation test**: open `Forest_Environment` + `Forest_Gameplay` additively, Play there — the bootstrap auto-loads, the enemy patrols, the key drops. Then Play from `Bootstrap.unity` → MainMenu → Forest.
- [ ] **No bootstrap coupling**: nothing in the feature touches `GameBootstrap` in `Awake`/`Start`; communication is via channels.
- [ ] **New scene?** Created from `LevelPart.scenetemplate`, in `Scenes/Levels/<Level>/`, added to the global scene list and to the level's `LevelSO` in the same PR; lighting baked by the environment owner before merge.
- [ ] **Commits**: scripts, data asset, prefab, scene each in their own commit; only intentional files staged; `develop` merged in; PR opened against `develop`.

## Anti-patterns

- ❌ One `Forest.unity` with geometry, lights, spawns and UI → ✅ `Forest_Environment` + `Forest_Gameplay` (+ `_Lighting` when needed), loaded through a `LevelSO`.
- ❌ `SceneManager.LoadScene("Forest")` from a door trigger → ✅ raise `LoadLevelRequested` with the `LevelSO`; only `SceneLoader` calls `SceneManager`, additively, by full path.
- ❌ A Camera, `AudioListener` or `DontDestroyOnLoad` manager inside a level scene → ✅ they exist once, in `Bootstrap.unity`; levels contain `CinemachineCamera`s only.
- ❌ Opening a teammate's scene "just to move one thing" and committing it → ✅ ask the owner (or give a heads-up first), or send them the prefab + position.
- ❌ Tweaking a HoverBot's speed on the instance in the scene → ✅ edit `Data/Enemies/HoverBot.asset`; if only this one differs, a variant with its own config asset.
- ❌ Editing a prefab by selecting its instance in the Hierarchy and clicking **Apply All** → ✅ open Prefab Mode (`P`), edit the asset, leave instances override-free.
- ❌ Adding a collider to one instance so "just this enemy" blocks the player → ✅ structural change = variant or Prefab Mode edit; instances override values, not structure.
- ❌ Dragging `HoverBot.fbx` into every scene and adding components there → ✅ one art variant prefab of the model, nested in the gameplay prefab.
- ❌ Baking lighting while reviewing someone's level, then committing the `LightingData.asset` → ✅ only the environment owner bakes and commits.
- ❌ `git add -A` after a Play session that dirtied three scenes → ✅ Discard the scenes you did not mean to change; stage files by name.
- ❌ Renaming `Forest_Gameplay.unity` in Finder → ✅ rename in the Project window so the `.meta` follows.
- ❌ Adding a **Scene List** override to `Windows-Dev` to include a test scene → ✅ sandbox scenes are opened directly in the Editor and never built.

## Review checklist

- [ ] No scene other than `Bootstrap.unity` contains a `Camera`, `AudioListener`, `DontDestroyOnLoad` object, or persistent UI; no content scene calls `SceneManager` directly.
- [ ] Every level has `_Environment` + `_Gameplay` part scenes in `Scenes/Levels/<Level>/`, a `LevelSO` in `Data/Levels/` listing them (environment/lighting part first), and the parts appear in the global scene list after `Bootstrap` and `MainMenu`.
- [ ] Scene loads are `LoadSceneAsync(path, Additive)` by full asset path, awaited with `Awaitable.FromAsyncOperation(op, token)`; `SceneLoader` unloads every loaded non-bootstrap scene (`sceneCount`/`GetSceneAt`, not a private list) and calls `SetActiveScene` and `UnloadUnusedAssets`.
- [ ] Pressing Play in the level's part scenes works without opening `Bootstrap.unity` (`BootstrapLoader` + adopt logic); no feature component touches `GameBootstrap` in `Awake`/`Start`.
- [ ] Every touched `.unity`/shared `.prefab`/`.inputactions`/`ProjectSettings` file was changed by its owner, or with a heads-up in the team channel.
- [ ] Repeated, spawned or co-edited content is a prefab; prefab edits were made in Prefab Mode; nesting ≤ 4 levels; child names unique.
- [ ] Scene instances carry only Transform/name/active/per-placement overrides; the Overrides dropdown is clean; no instance-applied changes landed in a prefab the author does not own; no unpacked shared prefabs.
- [ ] Tunables live in `Data/<Type>/*.asset`; no gameplay numbers on scene objects; Play-mode tuning was committed or reverted deliberately.
- [ ] Each commit contains one scene or prefab plus what it needs; no accidental dirty scenes; assets were moved/renamed inside the Editor (no orphan `.meta` changes).
- [ ] Lighting Data / NavMesh data committed by the environment owner, in its own commit, in the PR that changed the scene; the scene-list change (if any) is in the PR that adds the level; build profiles do not override the scene list.
- [ ] New scenes were created from `LevelPart.scenetemplate` and contain the standard group roots.

## Sources

1. [../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md) — How to author Scenes and Prefabs with a focus on version control — https://unity.com/blog/author-scenes-and-prefabs-with-verson-control
2. [../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) — Best practices for project organization and version control (Unity 6 edition) — https://unity.com/resources/best-practices-version-control-unity-6
3. [../reference/project-structure/how-to-organizing-your-project.md](../reference/project-structure/how-to-organizing-your-project.md) — Best practices for organizing your Unity project — https://unity.com/how-to/organizing-your-project
4. [../reference/project-structure/manual-multisceneediting.md](../reference/project-structure/manual-multisceneediting.md) — Work with multiple scenes in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/MultiSceneEditing.html
5. [../reference/project-structure/manual-setupmultiplescenes.md](../reference/project-structure/manual-setupmultiplescenes.md) — Set up multiple scenes — https://docs.unity3d.com/6000.3/Documentation/Manual/setupmultiplescenes.html
6. [../reference/project-structure/manual-scenes-working-with.md](../reference/project-structure/manual-scenes-working-with.md) — Creating, loading, and saving scenes — https://docs.unity3d.com/6000.3/Documentation/Manual/scenes-working-with.html
7. [../reference/project-structure/manual-creatingscenes.md](../reference/project-structure/manual-creatingscenes.md) — Introduction to scenes — https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingScenes.html
8. [../reference/project-structure/manual-scene-templates.md](../reference/project-structure/manual-scene-templates.md) — Scene templates — https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates.html
9. [../reference/project-structure/manual-hierarchy.md](../reference/project-structure/manual-hierarchy.md) — Manage GameObjects in the Hierarchy window — https://docs.unity3d.com/6000.3/Documentation/Manual/Hierarchy.html
10. [../reference/project-structure/manual-prefabs.md](../reference/project-structure/manual-prefabs.md) — Prefabs — https://docs.unity3d.com/6000.3/Documentation/Manual/Prefabs.html
11. [../reference/project-structure/manual-prefabs-introduction.md](../reference/project-structure/manual-prefabs-introduction.md) — Introduction to prefabs — https://docs.unity3d.com/6000.3/Documentation/Manual/prefabs-introduction.html
12. [../reference/project-structure/manual-creatingprefabs.md](../reference/project-structure/manual-creatingprefabs.md) — Create prefabs — https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html
13. [../reference/project-structure/manual-editinginprefabmode.md](../reference/project-structure/manual-editinginprefabmode.md) — Edit prefab assets — https://docs.unity3d.com/6000.3/Documentation/Manual/EditingInPrefabMode.html
14. [../reference/project-structure/manual-nestedprefabs.md](../reference/project-structure/manual-nestedprefabs.md) — Nest prefab instances in other prefabs — https://docs.unity3d.com/6000.3/Documentation/Manual/NestedPrefabs.html
15. [../reference/project-structure/manual-prefabvariants.md](../reference/project-structure/manual-prefabvariants.md) — Create variations of prefabs — https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html
16. [../reference/project-structure/manual-prefabs-override.md](../reference/project-structure/manual-prefabs-override.md) — Overriding prefab instance data — https://docs.unity3d.com/6000.3/Documentation/Manual/prefabs-override.html
17. [../reference/project-structure/tutorial-introduction-to-nested-prefabs.md](../reference/project-structure/tutorial-introduction-to-nested-prefabs.md) — Introduction to Nested Prefabs (Unity Learn) — https://learn.unity.com/tutorial/introduction-to-nested-prefabs
18. [../reference/project-structure/blog-introducing-new-prefab-workflows.md](../reference/project-structure/blog-introducing-new-prefab-workflows.md) — Introducing new Prefab workflows — https://unity.com/blog/technology/introducing-new-prefab-workflows
19. [../reference/project-structure/ebook-tips-to-increase-productivity-with-unity-6.md](../reference/project-structure/ebook-tips-to-increase-productivity-with-unity-6.md) — Tips to increase productivity with Unity 6 — https://unity.com/resources/tips-improve-productivity-workflow-unity-6
20. [../reference/project-structure/manual-assetmetadata.md](../reference/project-structure/manual-assetmetadata.md) — Asset metadata — https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html
21. [../reference/project-structure/manual-assets-direct-reference.md](../reference/project-structure/manual-assets-direct-reference.md) — Direct reference asset management — https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html
22. [../reference/version-control/how-to-version-control-systems.md](../reference/version-control/how-to-version-control-systems.md) — Best practices for version control systems — https://unity.com/how-to/version-control-systems
23. [../reference/version-control/blog-scaling-workflows-lessons-from-medium-to-large-projects.md](../reference/version-control/blog-scaling-workflows-lessons-from-medium-to-large-projects.md) — Scaling Unity workflows: lessons from medium to large projects — https://unity.com/blog/scaling-workflows-lessons-from-medium-to-large-projects
24. [../reference/version-control/manual-smartmerge.md](../reference/version-control/manual-smartmerge.md) — Smart merge (UnityYAMLMerge) — https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html
25. [../reference/version-control/manual-lightmapsnapshot.md](../reference/version-control/manual-lightmapsnapshot.md) — Lighting Data Assets — https://docs.unity3d.com/6000.3/Documentation/Manual/LightmapSnapshot.html
26. [../reference/scripting/scriptref-scenemanagement-scenemanager.md](../reference/scripting/scriptref-scenemanagement-scenemanager.md) — Scripting API: SceneManager — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html
27. [../reference/scripting/scriptref-scenemanagement-scenemanager-loadsceneasync.md](../reference/scripting/scriptref-scenemanagement-scenemanager-loadsceneasync.md) — SceneManager.LoadSceneAsync — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadSceneAsync.html
28. [../reference/scripting/scriptref-scenemanagement-scenemanager-loadscene.md](../reference/scripting/scriptref-scenemanagement-scenemanager-loadscene.md) — SceneManager.LoadScene — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html
29. [../reference/scripting/scriptref-scenemanagement-scenemanager-unloadsceneasync.md](../reference/scripting/scriptref-scenemanagement-scenemanager-unloadsceneasync.md) — SceneManager.UnloadSceneAsync — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html
30. [../reference/scripting/scriptref-scenemanagement-loadscenemode.md](../reference/scripting/scriptref-scenemanagement-loadscenemode.md) — LoadSceneMode — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html
31. [../reference/scripting/scriptref-scenemanagement-scenemanager-sceneloaded.md](../reference/scripting/scriptref-scenemanagement-scenemanager-sceneloaded.md) — SceneManager.sceneLoaded — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html
32. [../reference/scripting/scriptref-asyncoperation.md](../reference/scripting/scriptref-asyncoperation.md) — AsyncOperation — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html
33. [../reference/scripting/scriptref-awaitable-fromasyncoperation.md](../reference/scripting/scriptref-awaitable-fromasyncoperation.md) — Awaitable.FromAsyncOperation — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.FromAsyncOperation.html
34. [../reference/scripting/manual-async-awaitable-examples.md](../reference/scripting/manual-async-awaitable-examples.md) — Awaitable code example reference — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html
35. [../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md](../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md) — MonoBehaviour.destroyCancellationToken — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html
36. [../reference/scripting/scriptref-runtimeinitializeonloadmethodattribute.md](../reference/scripting/scriptref-runtimeinitializeonloadmethodattribute.md) — RuntimeInitializeOnLoadMethodAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html
37. [../reference/scripting/scriptref-resources-unloadunusedassets.md](../reference/scripting/scriptref-resources-unloadunusedassets.md) — Resources.UnloadUnusedAssets — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.UnloadUnusedAssets.html
38. [../reference/scripting/scriptref-object-dontdestroyonload.md](../reference/scripting/scriptref-object-dontdestroyonload.md) — Object.DontDestroyOnLoad — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html
39. [../reference/scripting/manual-class-scriptableobject.md](../reference/scripting/manual-class-scriptableobject.md) — ScriptableObject (Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html
40. [../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md) — Create modular game architecture with ScriptableObjects (Unity 6) — https://unity.com/resources/create-modular-game-architecture-scriptableobjects-unity-6
41. [../reference/design-patterns/blog-6-ways-scriptableobjects-can-benefit-your-team-and-your-code.md](../reference/design-patterns/blog-6-ways-scriptableobjects-can-benefit-your-team-and-your-code.md) — 6 ways ScriptableObjects can benefit your team and your code — https://unity.com/blog/engine-platform/6-ways-scriptableobjects-can-benefit-your-team-and-your-code
42. [../reference/testing-tooling/manual-build-profiles.md](../reference/testing-tooling/manual-build-profiles.md) — Introduction to build profiles — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html
43. [../reference/testing-tooling/manual-build-profile-scene-list.md](../reference/testing-tooling/manual-build-profile-scene-list.md) — Manage scenes in a build — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html
44. [../reference/testing-tooling/manual-build-profiles-reference.md](../reference/testing-tooling/manual-build-profiles-reference.md) — Build Profiles window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html
45. [../reference/testing-tooling/scriptref-editorbuildsettings.md](../reference/testing-tooling/scriptref-editorbuildsettings.md) — EditorBuildSettings — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html
46. [../reference/testing-tooling/manual-scene-based-tests.md](../reference/testing-tooling/manual-scene-based-tests.md) — Test Framework course 11: Scene-based tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/scene-based-tests.html
47. (web, no local copy) Creating scene templates — https://docs.unity3d.com/6000.3/Documentation/Manual/scene-templates-creating.html
48. (web, no local copy) Scripting API: Scene.isLoaded — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene-isLoaded.html
49. (web, no local copy; linked from source 16) Override prefab instances — https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabInstanceOverrides.html
