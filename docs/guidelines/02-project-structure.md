# 02. Project and asset organization

> **Scope:** Where every file in the Unity project lives — the `Assets/` tree, reserved folder names, asset naming, assembly-definition layout, what `Packages/` contains, and what never goes under `Assets/`.
> **Applies to:** everything under `Assets/` and `Packages/` in `shenicest-2026`; every teammate and every AI agent that creates, moves, renames or imports an asset.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

Related guidelines: [01 C# style](./01-csharp-style.md) (file/class naming), [06 Version control](./06-version-control.md) (git, LFS, `.meta` commits), [07 Rendering](./07-rendering-urp.md) (what the URP assets do), [08 Testing & tooling](./08-testing-tooling.md) (running tests, build profiles), [09 Packages](./09-packages-systems.md) (which packages we use), [11 Scenes & prefabs](./11-scenes-prefabs-workflow.md) (how to work inside scenes and prefabs).

## TL;DR — rules at a glance

1. **MUST** put all project-owned content under `Assets/SheNicest/`, split by asset type exactly as in the [Appendix](#appendix-folder-tree). Only five folders exist at the `Assets/` root: `SheNicest/`, `ThirdParty/`, `Plugins/`, `_Sandbox/`, `ScriptTemplates/` (plus the Unity-generated `TextMesh Pro/` and `UI Toolkit/` folders, untouched, and Unity-forced root folders such as `StreamingAssets/` only when actually needed).
2. **MUST** keep every C# file inside one of the four assembly scopes (`Scripts/Runtime`, `Scripts/Editor`, `Tests/EditMode`, `Tests/PlayMode`). Third-party code stays in `ThirdParty/`; throwaway code stays in `_Sandbox/<username>/`.
3. **MUST** mirror namespaces with folders: `Scripts/Runtime/Player/` ⇢ `namespace SheNicest.Player`.
4. **MUST** move, rename and delete assets inside the Unity Editor (Project window) so the `.meta` file travels with the asset; `.meta` files are always committed.
5. **MUST** name asset files in PascalCase with no spaces; underscore only for variant / texture-map / LOD / level-part suffixes; numeric suffix only for real sequences (`_01`, `_02`).
6. **MUST** use `.fbx` for models and extract embedded materials into `Materials/`; DCC source files (`.blend`, `.psd`, `.ma`) never go under `Assets/`.
7. **MUST** keep `Packages/` to `manifest.json` + `packages-lock.json`, both committed; which packages and versions we use is decided in [09](./09-packages-systems.md).
8. **SHOULD** add a `.gitkeep` (from the shell, not the Editor) to every folder of the tree that is still empty, so the folder and its `.meta` survive in Git (the file is always named `.gitkeep`, never `.keep`).
9. **SHOULD** use Project-window `t:`/`l:` search and labels instead of inventing type prefixes on file names.
10. **NEVER** create a `Resources/` folder or call `Resources.Load`; the only tolerated `Resources` folder is whatever the TMP Essential Resources import itself creates inside `Assets/TextMesh Pro/`, left untouched.
11. **NEVER** put documentation, builds, `.unitypackage` archives, source art, zips or IDE files under `Assets/`.
12. **NEVER** reference anything in `_Sandbox/` from a shipping scene, prefab or `SheNicest.*` assembly; **NEVER** edit files under `ThirdParty/` in place.
13. **NEVER** hand-edit `Packages/packages-lock.json`; **NEVER** rename the template's URP assets in `Settings/`.
14. **NEVER** leave template leftovers (`TutorialInfo/`, its Readme asset, `SampleScene.unity`) in the repository.

## 1. Repository and project root

What is and is not committed (`Assets/`, `Packages/`, `ProjectSettings/` and the repo files in; `Library/`, `Temp/`, `Logs/`, `UserSettings/`, builds out — including the ban on cloud-synced folders) is defined in [06](./06-version-control.md); this document only fixes *where* files live.

**MUST NOT** add folders at the project root other than `docs/` (documentation), `Builds/` (ignored build output, one sub-folder per build profile — see [08](./08-testing-tooling.md)) and, only if needed, `SourceArt/` (DCC source files in mirrored sub-paths, LFS-tracked by extension — see [06](./06-version-control.md)).
- *Why:* Unity recommends keeping content inside `Assets/` and avoiding extra root folders; we make exactly these exceptions because Unity would otherwise import the files (every `.md` becomes a TextAsset; every `.blend`/`.psd` is imported as a model/texture).
- *Source:* [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md) (avoid extra root folders); [Text assets](../reference/project-structure/manual-class-textasset.md) (`.md`, `.txt`, `.json` import as TextAsset); [Authoring scenes and prefabs with version control](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md) (keep source content outside `Assets`). **[project decision]** for the exact folder names.

## 2. The `Assets/` root

`Assets/` contains exactly these folders:

| Folder | Purpose | Rules |
|---|---|---|
| `Assets/SheNicest/` | Everything we author. Named after the project so our work is separated from third-party packages and shows up as one tree. | Section 3. |
| `Assets/ThirdParty/` | Asset Store / external `.unitypackage` content, one subfolder per package, untouched. | Section 5. |
| `Assets/Plugins/` | Native and managed plug-in binaries only (`.dll`, `.dylib`, `.so`, `.bundle`). Reserved folder. | Section 5. |
| `Assets/_Sandbox/<username>/` | Personal experiments and scratch scenes. Leading underscore sorts it first. | Section 6. |
| `Assets/ScriptTemplates/` | Project script templates (Unity reads them only here). Holds exactly the two files defined in [01](./01-csharp-style.md); their Unity-dictated names contain spaces and are exempt from rule 7.2. | [01](./01-csharp-style.md). |

- *Why:* Unity's organization e-book recommends a project-named root folder created by script, a `ThirdParty` folder so external assets can be updated without merge pain, a sandbox area split by username, and an `Assets/ScriptTemplates` folder for project script templates; underscore prefix puts a name alphabetically first.
- *Source:* [Organization e-book (Unity 6 ed.)](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) pp. 13–25; [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md). Folder names are a **[project decision]**.

Unity-forced root folders **MAY** be added later, and only at `Assets/` root because Unity requires that location: `StreamingAssets/` (raw files copied verbatim into builds), `Gizmos/` (icon images for `Gizmos.DrawIcon`), `Editor Default Resources/`. Unity-generated folders stay where Unity puts them and are committed as-is: `Assets/TextMesh Pro/` (from *Window > TextMeshPro > Import TMP Essential Resources*) and `Assets/UI Toolkit/` (Unity writes `UnityThemes/UnityDefaultTheme.tss` there when the first `UIDocument` is added; never move or rename it).
- *Source:* [Reserved folder name reference](../reference/project-structure/manual-specialfolders.md); [StreamingAssets](../reference/project-structure/manual-streamingassets.md); [TextMesh Pro](../reference/packages/ugui-2-0-textmeshpro-index.md); [Theme style sheets](../reference/packages/manual-uie-tss.md).

## 3. `Assets/SheNicest/` — what goes where

| Folder | Contents | Notes |
|---|---|---|
| `Animations/Clips/` | `.anim` clips, avatar masks | Imported FBX clips stay inside their model under `Meshes/`. |
| `Animations/Controllers/` | `.controller`, `.overrideController` | |
| `Animations/Timelines/` | Timeline `.playable` assets | E-book: Timeline assets live with animations. |
| `Audio/Music/`, `Audio/SFX/` | `.wav` / `.ogg` clips | |
| `Audio/Mixers/` | `.mixer` | |
| `Data/` | ScriptableObject **instances**, one subfolder per type, one logical thing per asset | Initial sub-folders: `Events/` (event channels), `Levels/` (`LevelSO` assets), `Config/` (gameplay config), `Enemies/`. Class definitions live in `Scripts/Runtime/Data/`, or in the feature folder that owns them when only that feature uses them. **[project decision]** |
| `Data/Events/` | ScriptableObject event-channel assets | Pattern owned by [03](./03-architecture-patterns.md). |
| `Fonts/` | Source font files (`.ttf`, `.otf`) | Generated SDF font assets go to `UI/Fonts/`. |
| `Input/` | `SheNicest.inputactions` (the project-wide actions asset) | Single asset; see [09](./09-packages-systems.md). |
| `Materials/` | `.mat` URP materials, including materials extracted from FBX | Flat; subfolders only if > ~40 files. |
| `Materials/Physics/` | PhysicsMaterial assets | |
| `Meshes/Characters/`, `Meshes/Environment/`, `Meshes/Props/` | `.fbx` models | Category folders mirror `Textures/` and `Prefabs/`. |
| `Prefabs/Characters/`, `Prefabs/Environment/`, `Prefabs/Props/`, `Prefabs/Systems/`, `Prefabs/UI/`, `Prefabs/VFX/` | `.prefab` and prefab variants | `Systems/` = bootstrap, managers, Cinemachine rigs. |
| `Scenes/` | `Bootstrap.unity` (persistent scene), `MainMenu.unity`, `PrefabStage.unity` (Prefab Mode editing environment) | Scene workflow is [11](./11-scenes-prefabs-workflow.md). |
| `Scenes/Levels/<LevelName>/` | One folder per level holding its additive sub-scenes | e.g. `Levels/Forest/Forest_Environment.unity`, `Forest_Gameplay.unity` (required) and `Forest_Lighting.unity` (optional). |
| `Scripts/Runtime/<Feature>/` | Runtime C# (`SheNicest.Runtime.asmdef` at `Scripts/Runtime/`) | Section 8. |
| `Scripts/Editor/` | Editor-only C# (`SheNicest.Editor.asmdef`) | Section 8. |
| `Settings/` | URP pipeline assets, renderer assets, URP global settings — moved here from the template's `Assets/Settings/` | Keep whatever file names the template created (the Unity 6 template uses `PC_RPAsset` / `Mobile_RPAsset` for the URP assets); the verified names are recorded in [07](./07-rendering-urp.md). Never rename them. Sub-folders: `Settings/Presets/` (`.preset`), `Settings/SceneTemplates/` (`.scenetemplate`), `Settings/BuildProfiles/` (build profile assets, see [08](./08-testing-tooling.md)), `Settings/VolumeProfiles/`, `Settings/Lighting/` (see [07](./07-rendering-urp.md)). **No `.cs` files anywhere under `Settings/`** — a script here would silently compile into the predefined `Assembly-CSharp`. |
| `Shaders/` | `.shadergraph`, hand-written `.shader`/`.hlsl` | |
| `Shaders/SubGraphs/` | `.shadersubgraph` reusable nodes | Sub-graphs are the "prefabs" of shaders: separate files avoid edit conflicts. |
| `Textures/Characters/`, `Textures/Environment/`, `Textures/Props/` | `.png` textures for materials (not UI) | UI sprites go to `UI/Sprites/`. |
| `Tests/EditMode/`, `Tests/PlayMode/` | Test C# with their own asmdefs | Section 8; running tests is [08](./08-testing-tooling.md). |
| `UI/Documents/` | `.uxml` | UI Toolkit is the runtime UI system; the decision and its rationale are in [09](./09-packages-systems.md). |
| `UI/Styles/` | `.uss`, `.tss` theme files | Project theme `SheNicest.tss` imports the generated `Assets/UI Toolkit/UnityThemes/UnityDefaultTheme.tss`. |
| `UI/Sprites/` | UI textures/sprites, icons | |
| `UI/Fonts/` | Generated Font Assets (`*_SDF.asset`) | |
| `UI/` (root) | `PanelSettings.asset`, UITK Text Settings asset | Few files, so no subfolder. |
| `VFX/` | VFX Graph `.vfx` assets, VFX-only materials | Particle/VFX prefabs go to `Prefabs/VFX/`. |

- *Why:* Splitting by asset type is the structure Unity's templates and e-book use; a fixed structure from day one avoids later moves, which most VCS record as delete + add and lose history.
- *Source:* [Organization e-book](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) pp. 15–16 (folder-by-type table: Animations, Audio, Editor, Fonts, Materials, Meshes, Prefabs, Scripts, Scenes, Settings, Shaders, Textures, ThirdParty, UI); [Authoring scenes and prefabs](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md) (sub-graphs as separate files; split scenes by concern). Subfolder names and the `Data/` folder are **[project decision]**.

**MUST** extract embedded FBX materials (Model Import Settings > Materials > **Extract Materials**) into `Materials/` before editing them.
- *Why:* Embedded materials are read-only sub-assets of the model; extracted ones are normal URP materials you can assign, tweak and diff.
- *Source:* [Materials tab (Model Import Settings)](../reference/project-structure/manual-fbximporter-materials.md).

**SHOULD** create new subfolders only when a folder becomes hard to scan; every new folder needs a `.gitkeep` until it holds a tracked file.
- *Why:* Git does not store empty folders, so only the folder `.meta` reaches the next machine; how Unity then reconciles the stray `.meta` differs between the 6000.3 manual (it recreates the folder) and the older how-to (it deletes the `.meta`), and either way the working tree shows a spurious change. A `.gitkeep` makes the folder itself tracked. Files starting with `.` are ignored by the importer, so `.gitkeep` gets no `.meta`.
- *Source:* [Asset metadata — empty folders](../reference/project-structure/manual-assetmetadata.md); [Reserved folder names — hidden assets](../reference/project-structure/manual-specialfolders.md); [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md) (`.keep` workaround).

## 4. Reserved folder names and how we use them

Unity gives special meaning to these `Assets` subfolder names wherever they appear (unless noted):

| Name | Unity behaviour | Our rule |
|---|---|---|
| `Editor` | Scripts compile into `Assembly-CSharp-Editor` (not in builds); allowed anywhere; MonoBehaviours inside cannot be components. An asmdef in the folder overrides this. | Only `Scripts/Editor/` (with `SheNicest.Editor.asmdef`) holds editor code; there is no other `Editor` folder in the project (editor-only *assets* live under `Settings/`, section 3). **NEVER** create an `Editor/` folder under `Scripts/Runtime/` — its scripts would join the runtime assembly and break player builds. |
| `Editor Default Resources` | Assets loadable via `EditorGUIUtility.Load`; root of `Assets` only; max 1. | Not used. |
| `Gizmos` | Icons for `Gizmos.DrawIcon`; root only; max 1. | Create only when needed. |
| `Resources` | Everything inside is always built into the player and indexed at startup, whether referenced or not. | **NEVER** create one. Use serialized direct references (Inspector fields, ScriptableObject catalogs). Whatever `Resources/` sub-folder the TMP Essential Resources import itself creates inside `Assets/TextMesh Pro/` is tolerated and holds only TMP's own assets; our UI Toolkit text settings, font assets and style sheets are direct references from `PanelSettings`/UXML under `UI/` and need no `Resources` folder. |
| `Plugins` | Third-party plug-ins; scripts compile first (`Assembly-CSharp-firstpass`); `Plugins/x86_64` etc. set platform defaults. | `Assets/Plugins/` for binaries only (section 5). |
| `StreamingAssets` | Files copied verbatim into the build; root only; max 1; read via `Application.streamingAssetsPath`. | Create only when a raw file (JSON, video) must ship unprocessed. Never put `.unity`, `.prefab`, `.asset` inside. |

Hidden by the importer: folders/files starting with `.` (except under `StreamingAssets/`, where they are imported and shipped — never put a `.gitkeep` there), ending with `~`, named `cvs`, or with extension `.tmp`. The Editor's *Create > Folder* rewrites a leading `.` to `_`, so create dot-files from the shell.

- *Why:* Reserved names change compilation order and build contents; accidental `Resources` folders bloat builds and slow startup.
- *Source:* [Reserved folder name reference](../reference/project-structure/manual-specialfolders.md); [Predefined assemblies reference](../reference/project-structure/manual-script-compile-order-folders.md); [Introduction to the Resources system](../reference/project-structure/manual-loadingresourcesatruntime.md); [Direct reference asset management](../reference/project-structure/manual-assets-direct-reference.md); [StreamingAssets](../reference/project-structure/manual-streamingassets.md); [Introduction to assemblies — Editor folder](../reference/project-structure/manual-assembly-definitions-intro.md); [TextMesh Pro](../reference/packages/ugui-2-0-textmeshpro-index.md) (Essential Resources import). The manual's [UI Toolkit text tutorial](../reference/packages/manual-uie-get-started-with-text.md) creates a `Resources` folder by hand — we do not. No-`Resources` is also **[project decision]** 8; the UI Toolkit layout is **[project decision]**.

## 5. ThirdParty and Plugins

**MUST** prefer a UPM package (Package Manager, `Packages/manifest.json`) over a `.unitypackage` when both exist.
- *Why:* UPM packages are immutable, versioned in the lock file and never pollute `Assets/`; `.unitypackage` content is copied into `Assets/` and must be managed by hand.
- *Source:* [Manage Asset Store packages](../reference/project-structure/manual-assetstorepackages.md); [Embedded dependencies](../reference/packages/manual-upm-embed.md).

**MUST** import a `.unitypackage` (*Assets > Import Package > Custom Package* or Package Manager *My Assets*), then immediately move its root folder to `Assets/ThirdParty/<PackageName>/` in the Project window, and commit the import as one dedicated `chore:` commit.
- *Why:* Keeps our tree separate from vendor trees; moving in-Editor keeps GUIDs so the vendor's internal references survive. One commit per import makes the next update a readable diff.
- *Source:* [Import local asset packages](../reference/project-structure/manual-assetpackagesimport.md); [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md) (keep internal and third-party assets separate; diff after updates). Exception **[project decision]**: if the vendor's code hard-codes its own path, leave it where the vendor requires and note it in `docs/third-party.md`.

**NEVER** edit files inside `ThirdParty/`. If a change is unavoidable, record file + reason in `docs/third-party.md` so it can be re-applied after an update.
- *Source:* [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md). **[project decision]** for the record location.

**MUST** give third-party code an assembly definition (the vendor's own, or a minimal `.asmdef` added at its root folder) before `SheNicest.Runtime` may reference it.
- *Why:* Scripts without an asmdef compile into the predefined `Assembly-CSharp`, and custom assemblies cannot reference predefined assemblies. Adding an `.asmdef` is the one tolerated edit inside `ThirdParty/`.
- *Source:* [Referencing assemblies — rules and limitations](../reference/project-structure/manual-assembly-definitions-referencing.md).

**MUST** place native/managed plug-in binaries in `Assets/Plugins/` using Unity's platform path patterns (`Plugins/x86_64/` for Windows/Linux/macOS); prefer source packages over DLLs.
- *Why:* Unity treats `.dll`, `.dylib`, `.so`, `.bundle`, `.framework` etc. as plug-ins and applies platform defaults from the path; a forgotten native plug-in only fails at run time.
- *Source:* [Import and configure plug-ins](../reference/project-structure/manual-plug-in-inspector.md); [Integrating third-party code libraries](../reference/project-structure/manual-plug-ins.md). Note `Unity.gitignore` ignores `Assets/Plugins/Editor/JetBrains*` (Rider generates it).

`.unitypackage` archives are never committed ([06](./06-version-control.md)) and **NEVER** stored under `Assets/` — import, then delete the archive.
- *Source:* [Unity.gitignore](../reference/version-control/github-gitignore-unity-gitignore.md) (ignores `*.unitypackage`).

## 6. Sandbox rules

`Assets/_Sandbox/<username>/` (GitHub handle, lowercase) is the only place for experiments, test scenes and spikes.

- **MUST** keep every experiment inside your own subfolder; **MAY** delete anyone's sandbox content that is older than the current milestone after asking once.
- **NEVER** reference a sandbox asset from a shipping scene, prefab, ScriptableObject or `SheNicest.*` assembly; never add a sandbox scene to a build profile.
- Sandbox scripts compile into the predefined `Assembly-CSharp`, which can use `SheNicest.Runtime` (it is auto-referenced) but can never be referenced back — that is the structural guarantee that sandbox code cannot leak into the game. A sandbox must still compile: fix or delete broken sandbox scripts before pushing.
- *Why:* Unity recommends a separate, per-user area for non-production content; keeping it outside the asmdefs makes leakage impossible rather than merely forbidden.
- *Source:* [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md); [Referencing assemblies](../reference/project-structure/manual-assembly-definitions-referencing.md) (predefined assemblies reference auto-referenced custom assemblies; custom assemblies cannot reference predefined ones). **[project decision]** 2 and the leak rule.

## 7. Asset naming conventions

### General rules

1. **MUST** use descriptive, unabbreviated names you will still understand in months (`LargeButton`, not `lBtn`).
2. **MUST** use PascalCase, no spaces (CamelCase replaces spaces). Rename Unity-generated names that contain spaces (e.g. `Inter-Regular SDF` → `Inter_SDF`).
3. **MUST** reserve `_` for: variants (`EnemyHoverBot_Fast`), texture maps (`Crate_Normal`), LODs (`Building_LOD0`), level parts (`Forest_Lighting`), presets (`TextureImporter_Normal`). No hyphens except in vendor-supplied font file names.
4. **MUST** use numeric suffixes only for real sequences, zero-padded to two digits (`Footstep_Grass_01`), never as a tie-breaker.
5. **MUST** use the exact spelling from the design document for named things (characters, places, items).
6. **SHOULD NOT** prefix type codes (`T_`, `M_`, `SM_`): the folder already says the type and the Project window filters by `t:Texture`, `t:Material`, `t:Prefab`.
7. **MAY** add labels (`l:` filter) for cross-cutting sets (e.g. `Vegetation`); labels survive moves/renames and are shared through version control.

- *Source:* [Organization e-book — Naming standards](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) p. 21–22 (descriptive names; Camel/Pascal case; underscores sparingly for variants, texture maps, LOD; numbers only for sequences; follow the design document); [Organizing your project](../reference/project-structure/how-to-organizing-your-project.md) (no spaces); [Project window — search filters](../reference/project-structure/manual-projectview.md); [Organize assets with labels](../reference/project-structure/manual-organizing-assets-with-labels.md). PascalCase choice, zero-padding, no type prefixes: **[project decision]**.

### Per-type patterns

| Asset | Folder | Pattern | Example |
|---|---|---|---|
| Scene (persistent) | `Scenes/` | fixed | `Bootstrap.unity` |
| Scene (menu / standalone) | `Scenes/` | `<Name>` | `MainMenu.unity` |
| Scene (prefab editing environment) | `Scenes/` | fixed | `PrefabStage.unity` |
| Scene (level part) | `Scenes/Levels/<Level>/` | `<Level>_<Part>` | `Forest_Environment.unity`, `Forest_Gameplay.unity` (+ optional `Forest_Lighting.unity`) |
| Prefab | `Prefabs/<Category>/` | `<Noun>` | `EnemyHoverBot.prefab`, `PlayerCharacter.prefab` |
| Prefab variant | same folder as base | `<Base>_<Variant>` | `EnemyHoverBot_Fast.prefab` |
| Model | `Meshes/<Category>/` | `<Noun>[_LOD<n>]` | `Crate.fbx`, `Building_LOD0.fbx` |
| Texture | `Textures/<Category>/` | `<Asset>_<Map>` with Map ∈ `BaseMap`, `Normal`, `Metallic`, `Specular`, `Occlusion`, `Emission`, `Height` | `Crate_BaseMap.png`, `Crate_Normal.png` |
| Material | `Materials/` | `<Asset>[_<Variant>]` | `Crate.mat`, `Crate_Wet.mat` |
| Physics material | `Materials/Physics/` | `<Surface>` | `Ice`, `Rubber` |
| Shader Graph | `Shaders/` | `<Effect>` | `Dissolve.shadergraph` |
| Sub-graph | `Shaders/SubGraphs/` | `<Function>` | `Fresnel.shadersubgraph` |
| ScriptableObject instance | `Data/<Type>/` | `<Instance>` — the folder names the type; the class's `SO` suffix ([01](./01-csharp-style.md)) is never on the asset file | `Data/Enemies/HoverBot.asset` (class `EnemyConfigSO`) |
| Event channel | `Data/Events/` | `<Subject><PastTenseVerb>` | `PlayerDied.asset`, `LevelLoaded.asset` |
| Animation clip | `Animations/Clips/` | `<Character>_<Action>` | `Player_Run.anim` |
| Animator controller | `Animations/Controllers/` | `<Character>` | `Player.controller` |
| Timeline | `Animations/Timelines/` | `<Sequence>` | `IntroCutscene.playable` |
| Audio clip | `Audio/SFX/`, `Audio/Music/` | `<Source>_<Event>[_NN]` / `<Track>` | `Footstep_Grass_01.wav`, `MainTheme.ogg` |
| Audio mixer | `Audio/Mixers/` | `<Name>` | `Main.mixer` |
| UXML document | `UI/Documents/` | `<Screen>` | `MainMenu.uxml`, `Hud.uxml` |
| USS / TSS | `UI/Styles/` | `<Scope>` ; `Common.uss` for shared rules; project theme `SheNicest.tss` (imports Unity's generated default theme) | `MainMenu.uss` |
| Source font | `Fonts/` | vendor file name, no spaces | `Inter-Regular.ttf` |
| Font asset | `UI/Fonts/` | `<Font>_SDF` | `Inter_SDF.asset` |
| Input actions | `Input/` | fixed | `SheNicest.inputactions` |
| URP assets, renderers, global settings | `Settings/` | template names, unchanged; the verified names are recorded in [07](./07-rendering-urp.md) | `PC_RPAsset.asset`, `Mobile_RPAsset.asset` |
| Volume profile | `Settings/VolumeProfiles/` | `<Context>Profile` for new ones; the template's own profile keeps its name and is moved into this folder | `ForestProfile.asset`, `MainMenuProfile.asset` |
| Lighting Settings Asset | `Settings/Lighting/` | fixed | `SheNicest.lighting` — see [07](./07-rendering-urp.md) |
| Build profile | `Settings/BuildProfiles/` | `<Platform>-<Configuration>` — see [08](./08-testing-tooling.md) | `Windows-Release.asset` |
| Preset | `Settings/Presets/` | `<Importer>_<Purpose>` | `TextureImporter_Normal.preset` |
| Scene template | `Settings/SceneTemplates/` | `<Purpose>` | `LevelPart.scenetemplate` |
| Script | `Scripts/…` | file name = class name | `PlayerController.cs` — see [01](./01-csharp-style.md) |
| Assembly definition | assembly root folder | fixed | `SheNicest.Runtime.asmdef` |

Inside UXML/USS, element names and classes are kebab-case BEM (`.main-menu__button--primary`, `#submit-button`); file names follow the PascalCase rule above.

- *Source:* texture-map names follow the URP Lit shader's slots ([Lit shader](../reference/rendering-urp/manual-lit-shader.md)); prefab variants are created next to their base ([Create variations of prefabs](../reference/project-structure/manual-prefabvariants.md)); `.fbx` is Unity's recommended exchange format ([Model file formats](../reference/project-structure/manual-3d-formats.md)) — making it the only accepted one is a **[project decision]**; presets per texture usage (albedo / normal / utility) and kebab-case UXML naming ([Organization e-book](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) pp. 23, 27); BEM for USS ([Best practices for USS](../reference/packages/manual-uie-uss-writingstylesheets.md)); the project-wide actions asset is created as `InputSystem_Actions` and we rename it ([Create project-wide actions](../reference/packages/inputsystem-1-20-create-project-wide-actions.md), **[project decision]** 5). All other patterns are **[project decision]**.

GameObject names inside scenes and prefabs follow the same general rules; hierarchy conventions are in [11](./11-scenes-prefabs-workflow.md).

## 8. Scripts, namespaces and assembly definitions

### Layout

```
Assets/SheNicest/Scripts/Runtime/SheNicest.Runtime.asmdef      → assembly SheNicest.Runtime,      root namespace SheNicest
Assets/SheNicest/Scripts/Editor/SheNicest.Editor.asmdef        → assembly SheNicest.Editor,       root namespace SheNicest.Editor
Assets/SheNicest/Tests/EditMode/SheNicest.Tests.EditMode.asmdef → assembly SheNicest.Tests.EditMode
Assets/SheNicest/Tests/PlayMode/SheNicest.Tests.PlayMode.asmdef → assembly SheNicest.Tests.PlayMode
```

Dependency direction (never reversed, never cyclic):

```
Tests.EditMode ──► Editor ──► Runtime ──► Unity packages (Input System, Cinemachine, …)
Tests.PlayMode ───────────────┘
```

- *Why:* An asmdef turns its folder (and sub-folders without their own asmdef) into one assembly; Unity forbids cycles and references from custom assemblies to the predefined ones; editor code may depend on runtime code but runtime code can never depend on editor code. Four assemblies is the package-standard split (Runtime / Editor / Tests) and is enough for a hackathon — more assemblies cost setup time and buy nothing at this size.
- *Source:* [Introduction to assemblies](../reference/project-structure/manual-assembly-definitions-intro.md); [Creating assembly assets](../reference/project-structure/manual-assembly-definitions-creating.md); [Referencing assemblies](../reference/project-structure/manual-assembly-definitions-referencing.md); [Package asmdef layout](../reference/project-structure/manual-cus-asmdef.md). **[project decision]** 3.

### Initial feature folders

| Folder (namespace) | Holds |
|---|---|
| `App/` (`SheNicest.App`) | `GameBootstrap`, game-flow states, `SceneLoader`, `ScenePaths` |
| `Core/` (`SheNicest.Core`) | shared interfaces, base classes, `Log` ([04](./04-unity-scripting-rules.md)) |
| `Data/` (`SheNicest.Data`) | ScriptableObject class definitions (`…SO`) |
| `Events/` (`SheNicest.Events`) | event-channel classes |
| `Player/`, `Cameras/`, `UI/` | feature code |
| `Rendering/` (`SheNicest.Rendering`) | create only when the first custom render pass is written ([07](./07-rendering-urp.md)) |

Dependency direction inside the assembly: `Core`/`Events`/`Data` ← feature namespaces ← `App`. A feature namespace never references another feature's concrete types (rule owned by [03](./03-architecture-patterns.md)). **[project decision]**

### Rules

**MUST** keep every `.cs` file in a feature subfolder of `Scripts/Runtime/` or `Scripts/Editor/` (or under `Tests/`); no loose files at the assembly root except an optional `AssemblyInfo.cs`.

**MUST** declare the namespace that mirrors the folder path after `Runtime/` or `Editor/`: `Scripts/Runtime/Player/Abilities/Dash.cs` ⇢ `namespace SheNicest.Player.Abilities`; `Scripts/Editor/Tools/` ⇢ `SheNicest.Editor.Tools`; `Tests/EditMode/Player/` ⇢ `SheNicest.Tests.EditMode.Player`. Rider and Visual Studio insert the asmdef's Root Namespace automatically for new files.
- *Why:* Namespaces prevent class-name clashes with third-party code and, when they mirror folders, make any class findable from its full name.
- *Source:* [Organizing your project — code standards](../reference/project-structure/how-to-organizing-your-project.md); [Naming scripts](../reference/csharp-style/manual-naming-scripts.md); [Assembly Definition Inspector — Root Namespace](../reference/project-structure/manual-class-assemblydefinitionimporter.md).

**MUST NOT** name a folder (hence namespace segment) after a Unity type used in that code — `Camera`, `Light`, `Animation`, `Animator`, `Physics`, `Random`, `Object`, `Debug`, `Input`, `Resources`. Use `Cameras`, `Lighting`, `Animations`, etc. The one exception we keep is `SheNicest.Editor`: inside it, write `UnityEditor.Editor` in full.
- *Why:* Inside `namespace SheNicest.Cameras` the bare identifier `Camera` still means `UnityEngine.Camera`; inside `namespace SheNicest.Camera` it would mean the namespace and every `Camera` usage fails to compile. The same happens with `Editor` in `SheNicest.Editor`.
- *Source:* C# name resolution; **[project decision]**.

```csharp
// ❌ Assets/SheNicest/Scripts/Editor/Tools/EnemyConfigSOEditor.cs
using SheNicest.Data;
using UnityEditor;

namespace SheNicest.Editor.Tools
{
    [CustomEditor(typeof(EnemyConfigSO))]
    public class EnemyConfigSOEditor : Editor   // error: 'SheNicest.Editor' is a namespace
    {
    }
}

// ✅
using SheNicest.Data;
using UnityEditor;

namespace SheNicest.Editor.Tools
{
    [CustomEditor(typeof(EnemyConfigSO))]
    public class EnemyConfigSOEditor : UnityEditor.Editor
    {
    }
}
```

**MUST** reference other assemblies by **name** in the JSON (`"references": ["SheNicest.Runtime"]`), never by GUID, and never mix both forms in one file. When editing an asmdef in the Inspector, leave **Use GUIDs** unticked — ticking it rewrites every entry as `GUID:…` on Apply.
- *Why:* Names are fixed by this document and make the files below copy-pasteable on any machine; Unity requires one form per list and infers the Inspector's **Use GUIDs** state from the form found in the file. (Unity notes GUIDs survive renames — we never rename these assemblies.)
- *Source:* [Assembly Definition file format](../reference/project-structure/manual-assembly-definition-file-format.md). **[project decision]**.

**MUST** add a package assembly to `references` before using its API from `SheNicest.Runtime`: `Unity.InputSystem`, `Unity.Cinemachine` are in from the start; add `Unity.AI.Navigation`, `Unity.RenderPipelines.Universal.Runtime`, `Unity.TextMeshPro` only when first used. UI Toolkit (`UnityEngine.UIElements`) ships with the Editor, not as a package ([09](./09-packages-systems.md)), and needs no entry.
- *Source:* assembly names from the package API pages ([PlayerInput](../reference/packages/inputsystem-1-20-unityengine-inputsystem-playerinput.md), [CinemachineCamera](../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md), [NavMeshSurface](../reference/packages/ai-navigation-2-0-unity-ai-navigation-navmeshsurface.md)); [Automated tests how-to](../reference/testing-tooling/how-to-automated-tests-unity-test-framework.md) (adding `Unity.InputSystem` as an asmdef reference).

**MUST** create the four files with exactly this content (create the two test folders with the Test Runner window's **Create a new Test Assembly Folder in the active path** — *Window > General > Test Runner* — or *Assets > Create > Testing > Test Assembly Folder*, the two code asmdefs with *Assets > Create > Scripting > Assembly Definition*, then edit the JSON to match exactly; the Inspector validates the result):

`Assets/SheNicest/Scripts/Runtime/SheNicest.Runtime.asmdef`
```json
{
    "name": "SheNicest.Runtime",
    "rootNamespace": "SheNicest",
    "references": [
        "Unity.InputSystem",
        "Unity.Cinemachine"
    ],
    "includePlatforms": [],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": false,
    "precompiledReferences": [],
    "autoReferenced": true,
    "defineConstraints": [],
    "versionDefines": [],
    "noEngineReferences": false
}
```

`Assets/SheNicest/Scripts/Editor/SheNicest.Editor.asmdef`
```json
{
    "name": "SheNicest.Editor",
    "rootNamespace": "SheNicest.Editor",
    "references": [
        "SheNicest.Runtime"
    ],
    "includePlatforms": [
        "Editor"
    ],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": false,
    "precompiledReferences": [],
    "autoReferenced": true,
    "defineConstraints": [],
    "versionDefines": [],
    "noEngineReferences": false
}
```

`Assets/SheNicest/Tests/EditMode/SheNicest.Tests.EditMode.asmdef`
```json
{
    "name": "SheNicest.Tests.EditMode",
    "rootNamespace": "SheNicest.Tests.EditMode",
    "references": [
        "SheNicest.Runtime",
        "SheNicest.Editor",
        "UnityEngine.TestRunner",
        "UnityEditor.TestRunner"
    ],
    "includePlatforms": [
        "Editor"
    ],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": true,
    "precompiledReferences": [
        "nunit.framework.dll"
    ],
    "autoReferenced": false,
    "defineConstraints": [
        "UNITY_INCLUDE_TESTS"
    ],
    "versionDefines": [],
    "noEngineReferences": false
}
```

`Assets/SheNicest/Tests/PlayMode/SheNicest.Tests.PlayMode.asmdef`
```json
{
    "name": "SheNicest.Tests.PlayMode",
    "rootNamespace": "SheNicest.Tests.PlayMode",
    "references": [
        "SheNicest.Runtime",
        "UnityEngine.TestRunner"
    ],
    "includePlatforms": [],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": true,
    "precompiledReferences": [
        "nunit.framework.dll"
    ],
    "autoReferenced": false,
    "defineConstraints": [
        "UNITY_INCLUDE_TESTS"
    ],
    "versionDefines": [],
    "noEngineReferences": false
}
```

- *Why:* `includePlatforms: ["Editor"]` is what makes an assembly editor-only (and what makes a test assembly an Edit-mode one); a test assembly is any assembly referencing `nunit.framework.dll` plus the TestRunner assemblies; the manual states the `UnityEditor.TestRunner` reference is only available for Edit-mode tests, so the Play-mode assembly omits it and targets any platform; `UNITY_INCLUDE_TESTS` keeps tests out of player builds; `autoReferenced: false` on tests stops `Assembly-CSharp` from recompiling when tests change. Test assemblies cannot reference `Assembly-CSharp`, which is one more reason all game code lives in `SheNicest.Runtime`.
- *Source:* [Assembly Definition file format](../reference/project-structure/manual-assembly-definition-file-format.md) (keys and the `UnityEngine.TestRunner` / `UnityEditor.TestRunner` / `nunit.framework.dll` / `UNITY_INCLUDE_TESTS` example); [Create a test assembly](../reference/testing-tooling/manual-workflow-create-test-assembly.md); [Edit mode and Play mode tests](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md); [Creating assembly assets — test assemblies](../reference/project-structure/manual-assembly-definitions-creating.md); [Conditionally including assemblies](../reference/project-structure/manual-assembly-definition-includes.md); `rootNamespace` key verified against Unity's own 6000.3 `Unity.RenderPipelines.Universal.Runtime.asmdef` (github.com/Unity-Technologies/Graphics, branch `6000.3/staging`).

**SHOULD** verify placement by selecting a script: the Inspector's **Assembly Information** shows which assembly it compiles into. Anything showing `Assembly-CSharp` outside `_Sandbox/` or `ThirdParty/` is misplaced.
- *Source:* [Introduction to assemblies — finding which assembly a script belongs to](../reference/project-structure/manual-assembly-definitions-intro.md).

## 9. Template leftovers — first-commit cleanup

The Universal 3D template creates `Assets/InputSystem_Actions.inputactions`, `Assets/Scenes/SampleScene.unity`, `Assets/Settings/` (URP assets, renderer, volume profile, global settings, build profiles) and `Assets/TutorialInfo/` (plus its Readme asset at the `Assets/` root). Do all of the following **inside the Editor**, in this order, as one `chore: apply project structure` commit:

1. Create the folder tree from the [Appendix](#appendix-folder-tree) (shell `mkdir -p` is fine for *new* folders; open the Editor afterwards so it generates their `.meta` files).
2. Delete the Readme asset at the `Assets/` root, then `Assets/TutorialInfo/` (the Readme's scripts live there).
3. Delete `Assets/Scenes/SampleScene.unity`, then the empty `Assets/Scenes/`. Remove it from the global scene list (*File > Build Profiles*, platform entry) and add `Bootstrap.unity` at index 0 ([11](./11-scenes-prefabs-workflow.md)).
4. In the Project window, drag every asset inside `Assets/Settings/` into `Assets/SheNicest/Settings/` (created in step 1): the URP assets, renderers and global settings go to its root, the template's volume profile to `Settings/VolumeProfiles/`, and the contents of the template's `Build Profiles/` folder to `Settings/BuildProfiles/` (no space in the name). Then delete the empty `Assets/Settings/`. If any URP settings asset sits elsewhere under `Assets/`, move it into `Settings/` too. Do not rename any file.
5. Drag `Assets/InputSystem_Actions.inputactions` into `Assets/SheNicest/Input/` and rename it `SheNicest.inputactions`.
6. Verify *Project Settings > Graphics* still shows the URP asset (`PC_RPAsset`) and *Project Settings > Input System Package* still shows the project-wide actions asset — both references are GUID-based and survive in-Editor moves.
7. Add `.gitkeep` files to every still-empty folder, then commit `Assets/`, `Packages/`, `ProjectSettings/` together with all `.meta` files.

- *Why:* Moving in the Editor keeps the `.meta` (GUID) with the file, so every reference to the URP assets and the actions asset stays intact; moving in Finder/Explorer without the `.meta` breaks them and Unity re-creates the asset as new.
- *Source:* [Default project directories — Assets contents](../reference/project-structure/manual-default-directories.md); [Asset metadata — moving and renaming](../reference/project-structure/manual-assetmetadata.md); [Introduction to importing assets](../reference/project-structure/manual-importingassets.md); [URP e-book — Graphics settings show `PC_RPAsset`](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md); [Create project-wide actions](../reference/packages/inputsystem-1-20-create-project-wide-actions.md). Target paths are **[project decision]** 2 and 5.

## 10. `Packages/` contents

Package selection, versions, Git-URL dependencies, `pinnedPackages` and embedding are owned by [09 Packages](./09-packages-systems.md#package-manager-rules); what is committed is owned by [06](./06-version-control.md). Structural facts that matter for this document:

**MUST** keep `Packages/` to `manifest.json` and `packages-lock.json` only (embedding a package is forbidden by [09](./09-packages-systems.md)); **NEVER** hand-edit `packages-lock.json` — the Package Manager overwrites it.
- *Why:* The manifest lists direct dependencies; the lock file records the resolved graph so every machine gets the identical package set.
- *Source:* [Project manifest file](../reference/packages/manual-upm-manifestprj.md); [Lock files](../reference/version-control/manual-upm-conflicts-auto.md).

**SHOULD** leave `resolutionStrategy` at its default (`lowest`) and `scopedRegistries`/`testables` empty until a concrete need appears (e.g. `"testables": ["com.unity.inputsystem"]` for `Unity.InputSystem.TestFramework`).
- *Source:* [Project manifest file](../reference/packages/manual-upm-manifestprj.md); [Automated tests how-to](../reference/testing-tooling/how-to-automated-tests-unity-test-framework.md).

## 11. What must never be under `Assets/`

| Content | Where it goes instead | Why |
|---|---|---|
| Documentation (`.md`, `.txt` notes, design docs) | `docs/` at the repo root | Unity imports `.md/.txt/.json/.xml/.yaml` as TextAssets and they end up in searches and the Asset Database. |
| Builds (`.app`, `.exe`, `Build/` folders) | `Builds/` at the repo root (gitignored) | Derived output; huge; `Unity.gitignore` already ignores `/Builds/`, `*.app`, `*.apk`. |
| `.unitypackage` archives, zips, installers | Import, then delete the archive | Ignored by git; not an asset. |
| DCC source files (`.blend`, `.psd`, `.ma`, `.max`, `.c4d`) | `SourceArt/<mirrored path>/` at the repo root, or a separate repo; export `.fbx` / `.png` into `Assets/` | Unity imports them automatically and `.blend/.ma/.max` fail to import on machines without the DCC app installed. |
| Memory captures, recordings, logs, profiler data | `MemoryCaptures/`, `Recordings/` at root (gitignored) | Large and sometimes sensitive. |
| IDE/solution files (`.csproj`, `.sln`, `.vs/`, `.idea/`) | Generated by Unity; never committed | Machine-specific. |
| Experiments | `Assets/_Sandbox/<username>/` | Section 6. |
| Editor-generated files (`InitTestScene*.unity` from the Test Runner, `SceneDependencyCache*`) | Nowhere — ignored | Auto-generated. |

- *Source:* [Text assets](../reference/project-structure/manual-class-textasset.md); [Unity.gitignore](../reference/version-control/github-gitignore-unity-gitignore.md); [Model file formats](../reference/project-structure/manual-3d-formats.md); [Introduction to importing assets](../reference/project-structure/manual-importingassets.md) (Unity converts every supported file dropped into `Assets`); [Authoring scenes and prefabs with version control — source content](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md). Folder names are **[project decision]**.

## 12. Presets (optional, recommended for textures)

**SHOULD** save import presets in `Settings/Presets/` (e.g. `TextureImporter_BaseMap`, `TextureImporter_Normal`) and apply them from the importer's preset icon, or register them as defaults in *Project Settings > Preset Manager*. The per-folder `AssetPostprocessor` approach from the manual **MAY** be adopted later; it is not required for the hackathon.
- *Why:* Presets make commonly-forgotten import settings consistent across the team without scripting.
- *Source:* [Reusing settings with preset assets](../reference/project-structure/manual-presets.md); [Apply default presets by folder](../reference/project-structure/manual-defaultpresetsbyfolder.md); [Organization e-book — Presets](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) p. 23–24. Folder is **[project decision]**.

## Anti-patterns

- ❌ Moving or renaming a file in Finder/Explorer, then "fixing" the orphaned `.meta` → ✅ move it in the Project window (or move the `.meta` together with the file and commit both).
- ❌ `Assets/Scripts/…` or `Assets/MyFeature/…` at the root → ✅ `Assets/SheNicest/Scripts/Runtime/<Feature>/`.
- ❌ A `Resources/` folder "to load the prefab by name" → ✅ a `[SerializeField] private GameObject m_prefab;` reference, or a ScriptableObject catalog in `Data/`.
- ❌ An `Editor/` subfolder inside `Scripts/Runtime/Player/` → ✅ `Scripts/Editor/Player/` (namespace `SheNicest.Editor.Player`).
- ❌ A script dropped into `Assets/SheNicest/Settings/` or any other asset folder → ✅ `Scripts/Editor/` or `Scripts/Runtime/<Feature>/`.
- ❌ `class CameraRig` in `namespace SheNicest.Camera` → ✅ `namespace SheNicest.Cameras`.
- ❌ `T_Crate_D.png`, `crate normal.png`, `Crate2.png` → ✅ `Crate_BaseMap.png`, `Crate_Normal.png`, and a variant name instead of `2`.
- ❌ Editing a vendor shader inside `ThirdParty/` → ✅ copy it to `Shaders/` under our name, or subclass/override; note it in `docs/third-party.md`.
- ❌ Keeping `SampleScene.unity` "for reference" → ✅ delete it; reference scenes belong in `_Sandbox/<username>/`.
- ❌ Committing `packages-lock.json` edits made in a text editor → ✅ let the Package Manager regenerate it.
- ❌ `docs/` content, GDD PDFs or screenshots under `Assets/` → ✅ `docs/` at the repo root.
- ❌ An empty folder committed without `.gitkeep` (only its `.meta` lands in git) → ✅ add `.gitkeep`.

## Review checklist

- [ ] Every new file is under `Assets/SheNicest/<type folder>/`, `Assets/ThirdParty/<Package>/`, `Assets/Plugins/`, `Assets/ScriptTemplates/`, or `Assets/_Sandbox/<username>/`; the Unity-generated `TextMesh Pro/` and `UI Toolkit/` folders are untouched.
- [ ] Every new `.cs` file is inside `Scripts/Runtime/<Feature>/`, `Scripts/Editor/…`, `Tests/EditMode/…` or `Tests/PlayMode/…`, and its namespace mirrors the folder.
- [ ] No `.cs` outside `Scripts/` and `Tests/`, no `Editor/` folder under `Scripts/Runtime/`, no namespace segment named after a Unity type.
- [ ] No `Resources/` folder was added (outside the TMP import's own); no `Resources.Load` call.
- [ ] Every moved/renamed asset has its `.meta` moved/renamed in the same commit; no "new" `.meta` for an existing asset.
- [ ] File names: PascalCase, no spaces, underscores only for variant / map / LOD / level-part, numbers only for sequences.
- [ ] Textures use the `_BaseMap/_Normal/_Metallic/_Specular/_Occlusion/_Emission/_Height` suffixes; models are `.fbx` with materials extracted to `Materials/`.
- [ ] New folders contain a `.gitkeep` if otherwise empty.
- [ ] Nothing in a shipping scene/prefab/asmdef references `_Sandbox/`.
- [ ] `ThirdParty/` files are unmodified (except an added `.asmdef`), and any import is its own commit.
- [ ] `Packages/` holds only `manifest.json` and `packages-lock.json`; any change to them follows [09](./09-packages-systems.md).
- [ ] No docs, builds, `.unitypackage`, `.blend/.psd`, zips or IDE files under `Assets/`.
- [ ] Template leftovers are absent; `Settings/` file names match the template.

## Appendix: folder tree

Every directory below is created verbatim on the first structure commit, except the two Unity-generated ones (`TextMesh Pro/`, `UI Toolkit/`), which appear on their own when the TMP Essential Resources are imported and the first `UIDocument` is added. Directories that are still empty get a `.gitkeep`. Files shown in comments are the initial assets each folder holds (they are not directories).

```
Assets/
├── SheNicest/
│   ├── Animations/
│   │   ├── Clips/
│   │   ├── Controllers/
│   │   └── Timelines/
│   ├── Audio/
│   │   ├── Mixers/
│   │   ├── Music/
│   │   └── SFX/
│   ├── Data/
│   │   ├── Config/
│   │   ├── Enemies/
│   │   ├── Events/
│   │   └── Levels/                  # LevelSO assets
│   ├── Fonts/
│   ├── Input/                       # SheNicest.inputactions
│   ├── Materials/
│   │   └── Physics/
│   ├── Meshes/
│   │   ├── Characters/
│   │   ├── Environment/
│   │   └── Props/
│   ├── Prefabs/
│   │   ├── Characters/
│   │   ├── Environment/
│   │   ├── Props/
│   │   ├── Systems/
│   │   ├── UI/
│   │   └── VFX/
│   ├── Scenes/                      # Bootstrap.unity, MainMenu.unity, PrefabStage.unity
│   │   └── Levels/
│   ├── Scripts/
│   │   ├── Runtime/                 # SheNicest.Runtime.asmdef
│   │   │   ├── App/                 # bootstrap, game-flow states, SceneLoader
│   │   │   ├── Cameras/
│   │   │   ├── Core/
│   │   │   ├── Data/
│   │   │   ├── Events/
│   │   │   ├── Player/
│   │   │   └── UI/
│   │   └── Editor/                  # SheNicest.Editor.asmdef
│   ├── Settings/                    # moved from the template's Assets/Settings/ (URP assets, renderers, global settings)
│   │   ├── BuildProfiles/           # moved from the template's Assets/Settings/Build Profiles/
│   │   ├── Cinemachine/             # CustomBlends.asset (see 09)
│   │   ├── Lighting/                # SheNicest.lighting
│   │   ├── Presets/
│   │   ├── SceneTemplates/          # LevelPart.scenetemplate
│   │   └── VolumeProfiles/
│   ├── Shaders/
│   │   └── SubGraphs/
│   ├── Tests/
│   │   ├── EditMode/                # SheNicest.Tests.EditMode.asmdef
│   │   └── PlayMode/                # SheNicest.Tests.PlayMode.asmdef
│   ├── Textures/
│   │   ├── Characters/
│   │   ├── Environment/
│   │   └── Props/
│   ├── UI/                          # PanelSettings.asset, text settings
│   │   ├── Documents/
│   │   ├── Fonts/
│   │   ├── Sprites/
│   │   └── Styles/
│   └── VFX/
├── ThirdParty/
├── Plugins/
├── ScriptTemplates/                 # 1-Scripting__MonoBehaviour Script-NewMonoBehaviourScript.cs.txt, 2-Scripting__ScriptableObject Script-NewScriptableObjectScript.cs.txt
├── TextMesh Pro/                    # generated by the TMP import, untouched
├── UI Toolkit/                      # generated by the first UIDocument, untouched
└── _Sandbox/
```

Shell one-liner (bash/zsh) for an agent creating the tree from the repository root (then open the project once so Unity writes the folder `.meta` files, and commit them together):

```sh
cd Assets && mkdir -p \
  SheNicest/Animations/{Clips,Controllers,Timelines} \
  SheNicest/Audio/{Mixers,Music,SFX} \
  SheNicest/Data/{Config,Enemies,Events,Levels} \
  SheNicest/Fonts SheNicest/Input \
  SheNicest/Materials/Physics \
  SheNicest/Meshes/{Characters,Environment,Props} \
  SheNicest/Prefabs/{Characters,Environment,Props,Systems,UI,VFX} \
  SheNicest/Scenes/Levels \
  SheNicest/Scripts/Runtime/{App,Cameras,Core,Data,Events,Player,UI} \
  SheNicest/Scripts/Editor \
  SheNicest/Settings/{BuildProfiles,Cinemachine,Lighting,Presets,SceneTemplates,VolumeProfiles} \
  SheNicest/Shaders/SubGraphs \
  SheNicest/Tests/{EditMode,PlayMode} \
  SheNicest/Textures/{Characters,Environment,Props} \
  SheNicest/UI/{Documents,Fonts,Sprites,Styles} \
  SheNicest/VFX ThirdParty Plugins ScriptTemplates _Sandbox \
&& find . -type d -empty -exec touch '{}/.gitkeep' \;
```

Add your own `_Sandbox/<username>/` folder on first use; it is not pre-created for anyone.

## Sources

1. [manual-specialfolders.md](../reference/project-structure/manual-specialfolders.md) — Reserved folder name reference — https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html
2. [manual-assetmetadata.md](../reference/project-structure/manual-assetmetadata.md) — Asset metadata — https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html
3. [how-to-organizing-your-project.md](../reference/project-structure/how-to-organizing-your-project.md) — Best practices for organizing your Unity project — https://unity.com/how-to/organizing-your-project
4. [ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) — Best practices for project organization and version control (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/hnnjs88z588fn62jggh9br6/Best_practices_for_project_organization_and_version_control_Unity_6_edition.pdf
5. [manual-default-directories.md](../reference/project-structure/manual-default-directories.md) — Default project directories — https://docs.unity3d.com/6000.3/Documentation/Manual/default-directories.html
6. [manual-importingassets.md](../reference/project-structure/manual-importingassets.md) — Introduction to importing assets — https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html
7. [manual-assembly-definitions-intro.md](../reference/project-structure/manual-assembly-definitions-intro.md) — Introduction to assemblies in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-intro.html
8. [manual-assembly-definitions-creating.md](../reference/project-structure/manual-assembly-definitions-creating.md) — Creating assembly assets — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html
9. [manual-assembly-definitions-referencing.md](../reference/project-structure/manual-assembly-definitions-referencing.md) — Referencing assemblies — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html
10. [manual-assembly-definition-file-format.md](../reference/project-structure/manual-assembly-definition-file-format.md) — Assembly Definition file format reference — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html
11. [manual-class-assemblydefinitionimporter.md](../reference/project-structure/manual-class-assemblydefinitionimporter.md) — Assembly Definition Inspector window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html
12. [manual-assembly-definition-includes.md](../reference/project-structure/manual-assembly-definition-includes.md) — Conditionally including assemblies — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-includes.html
13. [manual-script-compile-order-folders.md](../reference/project-structure/manual-script-compile-order-folders.md) — Predefined assemblies reference — https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html
14. [manual-cus-asmdef.md](../reference/project-structure/manual-cus-asmdef.md) — Create or edit the assembly definitions (package development) — https://docs.unity3d.com/6000.3/Documentation/Manual/cus-asmdef.html
15. [manual-workflow-create-test-assembly.md](../reference/testing-tooling/manual-workflow-create-test-assembly.md) — Create a test assembly — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html
16. [manual-edit-mode-vs-play-mode-tests.md](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md) — Edit mode and Play mode tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/edit-mode-vs-play-mode-tests.html
17. [how-to-automated-tests-unity-test-framework.md](../reference/testing-tooling/how-to-automated-tests-unity-test-framework.md) — How to set up automated tests with Unity Test Framework — https://unity.com/how-to/automated-tests-unity-test-framework
18. [manual-naming-scripts.md](../reference/csharp-style/manual-naming-scripts.md) — Naming scripts — https://docs.unity3d.com/6000.3/Documentation/Manual/naming-scripts.html
19. [manual-loadingresourcesatruntime.md](../reference/project-structure/manual-loadingresourcesatruntime.md) — Introduction to the Resources system — https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html
20. [manual-assets-direct-reference.md](../reference/project-structure/manual-assets-direct-reference.md) — Direct reference asset management — https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html
21. [manual-streamingassets.md](../reference/project-structure/manual-streamingassets.md) — Include additional files in a build — https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html
22. [manual-plug-in-inspector.md](../reference/project-structure/manual-plug-in-inspector.md) — Import and configure plug-ins — https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html
23. [manual-plug-ins.md](../reference/project-structure/manual-plug-ins.md) — Integrating third-party code libraries (plug-ins) — https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins.html
24. [manual-assetstorepackages.md](../reference/project-structure/manual-assetstorepackages.md) — Manage Asset Store packages in the Editor — https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html
25. [manual-assetpackagesimport.md](../reference/project-structure/manual-assetpackagesimport.md) — Import local asset packages — https://docs.unity3d.com/6000.3/Documentation/Manual/AssetPackagesImport.html
26. [manual-3d-formats.md](../reference/project-structure/manual-3d-formats.md) — Model file formats reference — https://docs.unity3d.com/6000.3/Documentation/Manual/3D-formats.html
27. [manual-fbximporter-materials.md](../reference/project-structure/manual-fbximporter-materials.md) — Materials tab (Model Import Settings) — https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html
28. [manual-class-textasset.md](../reference/project-structure/manual-class-textasset.md) — Text assets — https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextAsset.html
29. [manual-presets.md](../reference/project-structure/manual-presets.md) — Reusing settings with preset assets — https://docs.unity3d.com/6000.3/Documentation/Manual/Presets.html
30. [manual-defaultpresetsbyfolder.md](../reference/project-structure/manual-defaultpresetsbyfolder.md) — Apply default presets to assets by folder — https://docs.unity3d.com/6000.3/Documentation/Manual/DefaultPresetsByFolder.html
31. [manual-organizing-assets-with-labels.md](../reference/project-structure/manual-organizing-assets-with-labels.md) — Organize assets with labels — https://docs.unity3d.com/6000.3/Documentation/Manual/organizing-assets-with-labels.html
32. [manual-projectview.md](../reference/project-structure/manual-projectview.md) — Project window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html
33. [manual-prefabvariants.md](../reference/project-structure/manual-prefabvariants.md) — Create variations of prefabs — https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html
34. [blog-author-scenes-and-prefabs-with-verson-control.md](../reference/project-structure/blog-author-scenes-and-prefabs-with-verson-control.md) — How to author Scenes and Prefabs with a focus on version control — https://unity.com/blog/author-scenes-and-prefabs-with-verson-control
35. [manual-upm-manifestprj.md](../reference/packages/manual-upm-manifestprj.md) — Project manifest file — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html
36. [manual-upm-conflicts-auto.md](../reference/version-control/manual-upm-conflicts-auto.md) — Lock files — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts-auto.html
37. [manual-upm-lifecycle.md](../reference/packages/manual-upm-lifecycle.md) — Package states and lifecycle — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-lifecycle.html
38. [manual-upm-embed.md](../reference/packages/manual-upm-embed.md) — Embedded dependencies — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html
39. [github-gitignore-unity-gitignore.md](../reference/version-control/github-gitignore-unity-gitignore.md) — GitHub gitignore templates: Unity.gitignore — https://raw.githubusercontent.com/github/gitignore/main/Unity.gitignore
40. [inputsystem-1-20-create-project-wide-actions.md](../reference/packages/inputsystem-1-20-create-project-wide-actions.md) — Create and assign a default project-wide actions asset — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-project-wide-actions.html
41. [inputsystem-1-20-unityengine-inputsystem-playerinput.md](../reference/packages/inputsystem-1-20-unityengine-inputsystem-playerinput.md) — PlayerInput API (assembly `Unity.InputSystem`) — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.PlayerInput.html
42. [cinemachine-3-1-unity-cinemachine-cinemachinecamera.md](../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md) — CinemachineCamera API (assembly `Unity.Cinemachine`) — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCamera.html
43. [ai-navigation-2-0-unity-ai-navigation-navmeshsurface.md](../reference/packages/ai-navigation-2-0-unity-ai-navigation-navmeshsurface.md) — NavMeshSurface API (assembly `Unity.AI.Navigation`) — https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/api/Unity.AI.Navigation.NavMeshSurface.html
44. [ugui-2-0-textmeshpro-index.md](../reference/packages/ugui-2-0-textmeshpro-index.md) — TextMesh Pro (Essential Resources import) — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/index.html
45. [manual-uie-get-started-with-text.md](../reference/packages/manual-uie-get-started-with-text.md) — UI Toolkit: Get started with text — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-text.html
46. [manual-uie-uss-writingstylesheets.md](../reference/packages/manual-uie-uss-writingstylesheets.md) — Best practices for USS (BEM) — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-WritingStyleSheets.html
47. [manual-lit-shader.md](../reference/rendering-urp/manual-lit-shader.md) — URP Lit shader (texture slot names) — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lit-shader.html
48. [ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md](../reference/rendering-urp/ebook-introduction-to-the-universal-render-pipeline-for-advanced-unity-creat.md) — Introduction to the Universal Render Pipeline for advanced Unity creators (Unity 6 edition; template `PC_RPAsset` / `Mobile_RPAsset`) — https://cdn.bfldr.com/S5BC9Y64/at/whp9vmcbhz45k7vrx6pchh/Introduction_to_the_Universal_Render_Pipeline_for_advanced_Unity_creators_Unity_6_edition.pdf
49. [manual-uie-tss.md](../reference/packages/manual-uie-tss.md) — Theme style sheets (TSS; generated `Assets/UI Toolkit/UnityThemes/UnityDefaultTheme.tss`) — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-tss.html
