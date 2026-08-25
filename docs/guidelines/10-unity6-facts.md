# 10. Unity 6.3 facts, API changes and deprecations

> **Scope:** A fact sheet of what Unity 6000.3 (Unity 6.3 LTS) is, what changed since 2022 LTS / 6.0 / 6.2 that affects code, the old-API → new-API mapping, package versions, deprecations and system requirements — for agents whose training data predates Unity 6.
> **Applies to:** every agent and human writing C#, shaders, package manifests or build settings for this project. Usage rules live in [04](./04-unity-scripting-rules.md), [07](./07-rendering-urp.md) and [09](./09-packages-systems.md); this document only states facts and diffs.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

## TL;DR — rules at a glance

1. **MUST** target **Unity 6000.3.22f1 = Unity 6.3 LTS** (released 2026-08-13). "Unity 6" is the new name for what would have been 2023 LTS; `6000.x` is the version scheme, not a typo.
2. **MUST** write **C# 9.0** (Roslyn). **NEVER** use `record`, `init` setters, covariant return types or module initializers — they do not compile or are unsupported in 6.3.
3. **MUST** compile against **.NET Standard 2.1** (the default API Compatibility Level). .NET 5+/Core-only APIs and .NET Core plug-ins are not available.
4. **MUST** put `[SerializeField]` on **fields only**; an auto-property needs `[field: SerializeField]`. Anything else is a compile error in 6.3.
5. **MUST**, when a lookup is unavoidable (bootstrap, tests, editor tooling — [03](./03-architecture-patterns.md)/[04](./04-unity-scripting-rules.md)), use `FindFirstObjectByType` / `FindAnyObjectByType` / `FindObjectsByType(FindObjectsSortMode.None)`; **NEVER** the obsolete `FindObjectOfType` / `FindObjectsOfType` (rule owned by [04](./04-unity-scripting-rules.md)).
6. **MUST** use `Rigidbody.linearVelocity`, `linearDamping`, `angularDamping` and the `PhysicsMaterial` type; the pre-Unity-6 names `velocity` / `drag` / `angularDrag` still compile but are `[Obsolete]` (UnityUpgradable) — treat the warning as an error; `PhysicMaterial` is a compile error (rule: [04](./04-unity-scripting-rules.md)).
7. **MUST** use `UnityEngine.Awaitable` for async work (not `Task`) and pass `destroyCancellationToken` / `Application.exitCancellationToken`; DOTween `Sequence` for multi-tween composition; UniTask only to `WhenAll`/`WhenAny` a tween together with a non-tween async op (rule: [04](./04-unity-scripting-rules.md)).
8. **MUST** read input through the **Input System 1.20** (`UnityEngine.InputSystem`); **NEVER** `UnityEngine.Input` (rule: [09](./09-packages-systems.md)).
9. **MUST** write any custom URP pass against the **Render Graph** API. URP **Compatibility Mode is removed** in 6.3 — `SetupRenderPasses`, the legacy `AddRenderPass()` and `_FORWARD_PLUS` are gone or deprecated (rule: [07](./07-rendering-urp.md)).
10. **MUST** use the **Build Profiles** window and `BuildProfile` API; the "Build Settings" window no longer exists.
11. **NEVER** add `com.unity.ide.vscode`, Netcode for GameObjects 1.x, `com.unity.multiplayer.widgets`, `com.havok.physics`, Post Processing Stack v2 (`com.unity.postprocessing`) or a standalone TextMeshPro package — they are unsupported, deprecated or superseded in 6000.3.
12. **MUST** install only the package versions in the [package table](#packages-shipped-or-released-for-60003); versions are locked by `Packages/packages-lock.json` (policy in [09](./09-packages-systems.md)). `pinnedPackages` is **MAY** — only to hold back a package that auto-updates undesirably, committed as `chore(packages):`.
13. **SHOULD** prefer the new `EntityId`-based overloads in Editor code (`EditorUtility.EntityIdToObject`, `Selection.entityIds`); the `int` instance-ID overloads are obsolete since 6.3.
14. **SHOULD** accept the API Updater's offer when it reports **(UnityUpgradable)** warnings, and fix the rest by hand using the table below.
15. **NEVER** cite a `docs.unity3d.com` Manual/ScriptReference page that is not under `/6000.3/`, or a package page for a version not in the table; unity.com release notes, UnityCsReference on the `6000.3` branch and docs.unity.com service pages are acceptable when dated/branched for 6000.3. Older tutorials routinely use removed APIs.

## Versioning and support lifecycle

State the exact version in every bug report, commit message that touches `ProjectSettings/ProjectVersion.txt`, and CI config.

- **Editor:** `6000.3.22f1`, changeset `1c726e1fb402`, released 2026-08-13. It is a patch of the **6.3 LTS** line (`6000.3`).
  *Why:* the exact patch decides which package versions and known issues apply.
  *Source:* [releases-6000-3-22f1](../reference/unity6-release/releases-6000-3-22f1.md)
- **Naming:** "Unity 6" is the official name for what was previously referred to as Unity 2023 LTS; 6.0 was released 2024-10-17. Update releases follow the `6.x` nomenclature (6.1, 6.2), and 6.3 is the first LTS since 6.0.
  *Why:* agents trained on `2022.3`/`2023.x` version strings otherwise misread `6000.3` as a typo or a far-future release.
  *Source:* [blog-unity-6-features-announcement](../reference/unity6-release/blog-unity-6-features-announcement.md), [blog-introducing-unity-6-launch](../reference/unity6-release/blog-introducing-unity-6-launch.md), [blog-unity-6-3-lts-is-now-available](../reference/unity6-release/blog-unity-6-3-lts-is-now-available.md)
- **Support:** LTS releases ship once a year and are supported for two years (three for Enterprise/Industry). **6.3 LTS is supported until December 2027**; 6.0 LTS through October 2026; **6.2 is no longer supported**. Update releases are supported only until the next release.
  *Why:* staying on a supported LTS is what makes patch upgrades inside the jam safe; 6.2 tutorials describe an unsupported Editor.
  *Source:* [releases-support](../reference/unity6-release/releases-support.md), [blog-unity-6-3-lts-is-now-available](../reference/unity6-release/blog-unity-6-3-lts-is-now-available.md)
- **What comes next:** Unity 6.6 makes Fast Enter Play Mode the default for new projects and ships WebGPU as production-ready; Unity 7 (preview planned December 2026) brings CoreCLR, .NET 10 and C# 14 and is announced as "a direct continuation of Unity 6" with no breaking changes. None of that is available in 6.3 — do not write C# 10+ syntax "for later".
  *Why:* roadmap blog posts are easy to mistake for current capabilities; everything in this list is a future version.
  *Source:* [blog-unite-seoul-keynote-2026-recap](../reference/scripting/blog-unite-seoul-keynote-2026-recap.md), [blog-unity-engine-2025-roadmap](../reference/unity6-release/blog-unity-engine-2025-roadmap.md)
- **Upgrading:** upgrade guides are cumulative and must be read in release order (6.0 → 6.1 → 6.2 → 6.3); the manual index for 6000.3 is the root for every link in this document.
  *Why:* each guide only lists the changes since the previous release, so a 2022-era snippet needs all four.
  *Source:* [manual-upgradeguides](../reference/unity6-release/manual-upgradeguides.md), [manual-upgrade-project](../reference/unity6-release/manual-upgrade-project.md), [manual-index](../reference/unity6-release/manual-index.md)

## Templates and Hub workflow

- The project was created from the Hub's **Universal 3D** template: "an empty project for 3D applications. URP is pre-configured with 3D renderer." Hub path: **Projects → New project → Universal 3D → Create project**. URP projects are not compatible with HDRP or the Built-in pipeline.
  *Why:* shaders, renderer features and lighting advice written for HDRP or Built-in will not work in this project.
  *Source:* [manual-creating-a-new-project-with-urp](../reference/rendering-urp/manual-creating-a-new-project-with-urp.md); layout of what the template leaves behind and what we delete is in [02 Project structure](./02-project-structure.md).
- The template ships URP 17.3 as a **core package** (fixed to the Editor version, cannot be changed in Package Manager) with **Render Graph enabled by default**.
  *Why:* nobody can "upgrade URP" independently of the Editor, and every custom pass must target Render Graph from day one.
  *Source:* [manual-pack-core](../reference/packages/manual-pack-core.md), [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md)
- Builds are configured in **File → Build Profiles** (the window "was previously named Build Settings"). A profile can own its scene list, scripting defines, Player/Quality/Graphics overrides, and since 6.3 you pick which of those sections to configure with **Add Settings**; `BuildProfile.AddComponent/CreateComponent/GetComponent` manage one ScriptableObject per type per profile.
  *Why:* older instructions ("open Build Settings, tick the scene") point at a window that no longer exists; profiles are assets and belong in version control ([08](./08-testing-tooling.md)).
  *Source:* [manual-buildsettings](../reference/testing-tooling/manual-buildsettings.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md), [manual-whatsnewunity6preview](../reference/unity6-release/manual-whatsnewunity6preview.md)
- The Hub is the recommended way to install Editors and open projects; Windows-on-Arm Editors need Hub 3.7.0 Beta 1+, Editor deeplinks need Hub 3.15+. Installing the same modules (Web Build Support, IL2CPP, …) on every teammate's machine avoids "wrong Editor version" prompts.
  *Why:* every mismatch in Editor build or installed modules costs the team an upgrade prompt or a failed build on somebody else's machine.
  *Source:* [manual-upgrade-project](../reference/unity6-release/manual-upgrade-project.md), [manual-system-requirements](../reference/unity6-release/manual-system-requirements.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md)
- Editor menu paths changed in 6.1: Package Manager, Asset Store, Services and My Assets live under **Window → Package Management**; Undo History moved to **Window → General**; **Assets → Create** was re-categorised in 6.0 and the C# Script item became **MonoBehaviour Script / ScriptableObject Script / Blank Script**.
  *Why:* agents that quote pre-6.1 menu paths send teammates to menus that do not exist.
  *Source:* [manual-whatsnewunity61](../reference/unity6-release/manual-whatsnewunity61.md), [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md), [manual-whatsnewunity6](../reference/unity6-release/manual-whatsnewunity6.md)

## Language, runtime and .NET profile

| Fact | Value in 6000.3 | Source |
|:-----|:----------------|:-------|
| C# compiler / language | Roslyn, **C# 9.0** | [manual-csharp-compiler](../reference/csharp-style/manual-csharp-compiler.md) |
| Unsupported C# 9 features (compile errors) | suppress `localsinit`, **covariant return types**, **module initializers**, extensible calling conventions for unmanaged function pointers, **init-only setters** | same |
| Records | need `System.Runtime.CompilerServices.IsExternalInit` (absent — .NET 5+ only) unless you declare it yourself; Unity serialization does not support records | same; project rule: **no records, no `init`** — [01 C# style](./01-csharp-style.md) |
| API Compatibility Level | **.NET Standard 2.1** (default, recommended) or .NET Framework 4.8 + Std 2.1 extras; `.NET Core` plug-ins are *not supported* at either level | [manual-dotnet-profile-support](../reference/scripting/manual-dotnet-profile-support.md) |
| Scripting back ends | **Mono** (JIT) and **IL2CPP** (AOT, C++ output; required where JIT is not allowed). No .NET 5+ runtime in 6.x | [manual-scripting-backends](../reference/scripting/manual-scripting-backends.md), [manual-overview-of-dot-net-in-unity](../reference/scripting/manual-overview-of-dot-net-in-unity.md) |
| Garbage collector | Boehm-Demers-Weiser, **incremental mode by default**, on both back ends | [manual-csharp-compiler](../reference/csharp-style/manual-csharp-compiler.md) |
| `System.Drawing` | explicitly unsupported; no perf guarantees for `System.*` across versions | [manual-dotnet-profile-support](../reference/scripting/manual-dotnet-profile-support.md) |
| IL2CPP Code Generation setting | renamed in 6.2: **Optimize for runtime speed** / **Optimize for code size and build time** | [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md) |
| Desktop build modules | Windows/Mac/Linux Build Support exist in **Mono** and **IL2CPP** variants; Windows IL2CPP needs Visual Studio 2019 C++ tools + Windows SDK 10.0.19041.0+, macOS IL2CPP needs Xcode | [releases-6000-3-22f1](../reference/unity6-release/releases-6000-3-22f1.md), [manual-system-requirements](../reference/unity6-release/manual-system-requirements.md) |

*Why it matters:* every sample that uses `record`, `init`, `required`, file-scoped namespaces, raw string literals, `global using`, list patterns or `ArgumentNullException.ThrowIfNull` was written for C# 10+ / .NET 6+ and will not compile here.

## What changed since 2022 LTS that affects code

Introduced = first Unity 6 release that has it (everything listed is inherited by 6.3). In these tables the *Change* / *Consequence for this project* cells carry the fact and its *Why*; the *Source* column is the *Source* for that row.

### Scripting and Editor

| Change | Introduced | Consequence for this project | Source |
|:-------|:-----------|:-----------------------------|:-------|
| `UnityEngine.Awaitable` (+ `Awaitable<T>`, `AwaitableCompletionSource`, `NextFrameAsync`, `WaitForSecondsAsync`, `EndOfFrameAsync`, `FixedUpdateAsync`, `BackgroundThreadAsync`, `MainThreadAsync`, `FromAsyncOperation`) | Present in the 6000.3 manual (pre-dates 6.3) | Pooled, single-await, main-thread-aware async primitive; all `AsyncOperation`s and UnityEvents are awaitable. Rules in [04](./04-unity-scripting-rules.md) | [manual-async-awaitable-introduction](../reference/scripting/manual-async-awaitable-introduction.md), [scriptref-awaitable](../reference/scripting/scriptref-awaitable.md) |
| `MonoBehaviour.destroyCancellationToken`, `Application.exitCancellationToken` | Present in 6000.3 (pre-dates 6.3) | Cancel async work when the object is destroyed / Play Mode exits | [scriptref-monobehaviour-destroycancellationtoken](../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md), [scriptref-application-exitcancellationtoken](../reference/scripting/scriptref-application-exitcancellationtoken.md) |
| `Object.FindObjectOfType` / `FindObjectsOfType` obsolete → `FindFirstObjectByType`, `FindAnyObjectByType`, `FindObjectsByType(FindObjectsSortMode)` | 6.0 (2022 LTS → 6.0 guide) | Old calls sorted by InstanceID (slow); pass `FindObjectsSortMode.None` unless order matters | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md), [scriptref-object-findobjectoftype](../reference/scripting/scriptref-object-findobjectoftype.md), [scriptref-object-findobjectsbytype](../reference/scripting/scriptref-object-findobjectsbytype.md) |
| `Object.InstantiateAsync` returning `AsyncInstantiateOperation<T>` | Present in 6000.3 (pre-dates 6.3) | Batch spawning without frame hitches | [scriptref-object-instantiateasync](../reference/scripting/scriptref-object-instantiateasync.md) |
| `[SerializeField]` restricted to fields; misuse is a compile error; auto-properties use `[field: SerializeField]` | **6.3** | See example below | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md), [scriptref-serializefield](../reference/scripting/scriptref-serializefield.md) |
| `EntityId` replaces `int` instance IDs across Editor/engine APIs (`EditorUtility.EntityIdToObject`, `Selection.entityIds`, `AssetDatabase.*(EntityId)`, `RaycastHit.colliderEntityId`, `RenderParams.entityId`, `TransformAccessArray.Add(EntityId)`); `Scene.handle` is now `SceneHandle`. Both types implicitly convert to/from `int`; precompiled DLLs built against `int` may throw `MissingFieldException` | **6.3** | Source code keeps compiling; recompile any third-party DLL that touches these | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md), [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| Input System package is the default/recommended input solution; the legacy Input Manager is documented as "deprecated built-in Input Manager"; **Active Input Handling** lives in Player → Other Settings and needs an Editor restart | 6.x manual | Project uses Input System 1.20 only — [09](./09-packages-systems.md) | [manual-input](../reference/scripting/manual-input.md), [manual-input-introduction](../reference/scripting/manual-input-introduction.md), [inputsystem-1-20-installation](../reference/packages/inputsystem-1-20-installation.md) |
| Unity Test Framework became a **core package** (1.6) with its manual inside the Unity manual; **UI Test Framework** (core, 6.3) adds UI Toolkit interaction simulation | 6.2 / 6.3 | See [08 Testing](./08-testing-tooling.md) | [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md), [manual-pack-core](../reference/packages/manual-pack-core.md) |
| Adaptive Performance core functionality moved from a package to a **built-in Editor module**; the package is now core and only provides samples/visual-scripting nodes | **6.3** | Nothing to install; do not add the old package | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| Unity AI (Assistant `/ask` `/run` `/code`, Generators, Sentis = `com.unity.ai.inference`) accessible from an **AI** menu; can be disabled org-wide from the Dashboard | 6.2 | Optional tooling; generated code must still pass these guidelines | [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md), [manual-unity-ai](../reference/unity6-release/manual-unity-ai.md) |
| **Multiplayer Center** (core package, **Window → Multiplayer → Multiplayer Center**) recommends packages per game spec; Multiplayer Widgets deprecated in favour of Unity Building Blocks | 6.0 / 6.3 | Not used (single-player jam); listed so agents don't add widgets | [manual-whatsnewunity6](../reference/unity6-release/manual-whatsnewunity6.md), [en-us-multiplayer-center](../reference/packages/en-us-multiplayer-center.md), [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| **Unity Behavior** 1.0.16 — graph-based behaviour trees ("behavior graphs") for NPC logic, released for 6000.3 | 6.x | Candidate for NPC AI — see [09](./09-packages-systems.md) | [behavior-1-0-index](../reference/packages/behavior-1-0-index.md), [manual-com-unity-behavior](../reference/packages/manual-com-unity-behavior.md) |
| Editor no longer forces GC + asset unload on scene load (opt-in **Force GC on Scene Loads**); new projects collect engine diagnostics data by default (configurable in Project Settings / Build Profiles) | 6.2 | Be aware when profiling in-Editor; decide on diagnostics in Player settings | [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md) |
| `UnityWebRequest` defaults to HTTP/2 on desktop/Android; `Animator.ResetControllerState` for pooling; `MeshRenderer.SetShaderUserValue` per-renderer int; scriptable audio processors; `Physics.autoSyncTransforms` deprecated → `Physics.SyncTransforms()` | **6.3** | New capabilities; no migration needed except `autoSyncTransforms` | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md), [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| API Updater rewrites obsolete code it can handle (marked **UnityUpgradable**); runs on compile; `-accept-apiupdate` in batch mode | all | Accept it, then fix the rest manually | [manual-apiupdater](../reference/unity6-release/manual-apiupdater.md) |

### Physics

| Change | Introduced | Source |
|:-------|:-----------|:-------|
| `Rigidbody` API in the 6000.3 bindings exposes `linearVelocity`, `angularVelocity`, `linearDamping`, `angularDamping`, `maxLinearVelocity`; the Inspector shows **Linear Damping / Angular Damping**. The pre-6 members `velocity`, `drag`, `angularDrag` live in the companion `Rigidbody.deprecated.cs` as `[Obsolete("… (UnityUpgradable) -> linearVelocity / linearDamping / angularDamping")]` forwarding properties: they compile with a warning and the API Updater rewrites them. | Before 6.3 (present in 6000.3) | [github-unitycsreference-rigidbody-bindings-cs](../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md), [github-unitycsreference-rigidbody-deprecated-cs](../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md), [scriptref-rigidbody-linearvelocity](../reference/scripting/scriptref-rigidbody-linearvelocity.md), [scriptref-rigidbody-lineardamping](../reference/scripting/scriptref-rigidbody-lineardamping.md), [manual-class-rigidbody](../reference/scripting/manual-class-rigidbody.md) |
| Physics material asset/class is `PhysicsMaterial` (**Assets → Create → Physics Material**); the old `PhysicMaterial` class and `PhysicMaterialCombine` enum remain only as `[Obsolete(…, true)]` UnityUpgradable stubs — a compile error the API Updater rewrites | 6.0 line | [manual-class-physicsmaterial](../reference/scripting/manual-class-physicsmaterial.md), [scriptref-physicsmaterial](../reference/scripting/scriptref-physicsmaterial.md), [github-unitycsreference-physicsmaterial-deprecated-cs](../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md) |
| `AddForceAtPosition` / `AddExplosionForce` with `ForceMode.VelocityChange` / `Acceleration` now scale torque by the inertia tensor (different from 2022). To reproduce the old result multiply by `mass` and use `Force` / `Impulse` | 6.0 | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| `Rigidbody.SetDensity` deprecated → set `Rigidbody.mass` | 6.1 | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md) |
| Physics back end can be disabled/stripped from a build; low-level 2D physics (Box2D v3) under `UnityEngine.LowLevelPhysics2D` | 6.3 | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) |

### Rendering (facts only — conventions are in [07 Rendering](./07-rendering-urp.md))

| Change | Introduced | Source |
|:-------|:-----------|:-------|
| **Render Graph** is the URP rendering path; custom passes must be written with the render graph API (`ScriptableRenderPass` + `AddRenderPasses`, `AddRasterRenderPass/ComputePass/UnsafePass`, imported textures). Legacy `AddRenderPass()` and the shared-texture workflow are deprecated in 6.3 | URP 17 / 6.0 | [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md), [manual-urp-whats-new](../reference/unity6-release/manual-urp-whats-new.md), [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| URP **Compatibility Mode (Render Graph disabled)** deprecated in 6.0, **removed in 6.3**: code stripped, `RenderGraphSettings.enableRenderCompatibilityMode` is read-only `false`; `URP_COMPATIBILITY_MODE` define re-adds it for conversion only and stops working in 6.4 | 6.3 | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| `ScriptableRendererFeature.SetupRenderPasses` deprecated; `AfterRendering` injection point now always runs after the final back-buffer blit (use `AfterRenderingPostProcessing` to keep rendering into an intermediate texture) | 6.2 | [manual-upgradeguideunity62](../reference/unity6-release/manual-upgradeguideunity62.md) |
| Shader keyword `_FORWARD_PLUS` → `_CLUSTER_LIGHT_LOOP`; **Deferred+** rendering path; PVRTC deprecated | 6.1 | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md), [manual-whatsnewunity61](../reference/unity6-release/manual-whatsnewunity61.md) |
| **GPU Resident Drawer** (BatchRendererGroup-based instancing) and **GPU occlusion culling**; **STP** upscaler; camera history API; 8192 shadow resolution; Alpha Processing in post-processing | 6.0 | [manual-urp-whats-new](../reference/unity6-release/manual-urp-whats-new.md), [manual-whatsnewunity6](../reference/unity6-release/manual-whatsnewunity6.md) |
| **DirectX 12** is the default Auto Graphics API for new Windows projects (upgraded projects keep their setting); per-device **D3D12 Device Filter Asset** in 6.3 | 6.1 / 6.3 | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) |
| URP and HDRP share one Render Graph compiler; Render Graph Viewer can attach to players; `AddBlitPass` returns a builder; Bloom gains **Kawase**/**Dual** filters; Shader Graph templates, custom lighting via URP Unlit target, terrain and **UI (URP UI)** material types | 6.3 | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) |
| Lighting: **Enlighten baked GI removed**; **Auto Generate** lighting removed (use the Lighting window's **Generate Lighting**, `Lightmapping.Bake` / `BakeAsync`); ambient probe and skybox reflection are no longer baked automatically; Light Probes are now as bright as lightmaps (they were 94 % as bright before) | 6.0 | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| **GPU Lightmapper** is the default baking back end; **xAtlas** packing for new scenes; CPU lightmapping unsupported on Apple silicon and Windows-on-Arm | 6.3 / Editor limitation | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md), [manual-system-requirements](../reference/unity6-release/manual-system-requirements.md) |
| Runtime-created `Texture2D` no longer follow mipmap limits by default (opt-in via `MipmapLimitDescriptor`); `GraphicsFormat.DepthAuto/ShadowAuto/VideoAuto` are compile errors (use `GraphicsFormat.None` + `depthStencilFormat`); Metal buffer layout changes for `half`/`min16float` | 6.0 | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| Shader Build Settings (Graphics settings) can limit/strip keywords project-wide without code | 6.3 | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) |

### UI Toolkit and uGUI

| Change | Introduced | Source |
|:-------|:-----------|:-------|
| Custom controls use `[UxmlElement]` / `[UxmlAttribute]` (source-generated `UxmlSerializedData`) instead of `UxmlFactory` / `UxmlTraits` | 6.0 | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| Event handling: `ExecuteDefaultAction(AtTarget)` → `HandleEventTrickleDown` / `HandleEventBubbleUp`; `PreventDefault` → `StopPropagation`; `AtTarget` phase deprecated | 6.0 | same |
| Runtime data binding system; new controls (`Tab`, `TabView`, `ToggleButtonGroup`); native Advanced Text Generator; `VisualElement.transform` deprecated → `style.translate/rotate/scale` (write) and `resolvedStyle.*` (read) | 2023.2 / 6.0 / 6.2 | [manual-whatsnewunity6](../reference/unity6-release/manual-whatsnewunity6.md), [manual-upgradeguideunity62](../reference/unity6-release/manual-upgradeguideunity62.md) |
| **World Space UI**, `TextElement.PostProcessTextVertices`, Best Fit in ATG | 6.2 | [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md) |
| Stricter **USS parser**: malformed selectors/brackets/semicolons and unsupported CSS now block import (configurable **Unsupported Selector Action**); USS `filter` (blur, tint, grayscale…), `aspect-ratio`, UXML `source` attribute on `Image`, SVG import as Vector Image built in (package only for SVG sprites / uGUI), UI Shader Graph | 6.3 | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) |
| TextMeshPro documentation lives inside **uGUI 2.0** (`com.unity.ugui@2.0/manual/TextMeshPro`); no separate TMP package appears in the 6000.3 core or released lists | 6.x | [ugui-2-0-textmeshpro-index](../reference/packages/ugui-2-0-textmeshpro-index.md), [manual-pack-core](../reference/packages/manual-pack-core.md), [manual-pack-safe](../reference/packages/manual-pack-safe.md) |

### Platforms

| Change | Introduced | Source |
|:-------|:-----------|:-------|
| The platform is called **Web** (previously WebGL): WebAssembly 2023, up to 4 GB heap, mobile browsers supported; **WebGPU** experimental in 6.1 (production-ready only from 6.6); Web profiling over IP and native Apple-silicon Emscripten in 6.3; preconfigured Web build profiles (6.2); **Publish to Play** (6.1) | 6.0–6.3 | [manual-whatsnewunity6](../reference/unity6-release/manual-whatsnewunity6.md), [manual-whatsnewunity61](../reference/unity6-release/manual-whatsnewunity61.md), [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) |
| Facebook Instant Games platform deprecated (use Web); Magic Leap deprecated; Multiplay Hosting removed (service shut down 2026-03-31) | 6.3 | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| Android: min version 7.1 (API 25), Gradle 9.1.0 / AGP 9.0.0, round/legacy icons deprecated, **App Category** replaces `PlayerSettings.Android.androidIsGame` | 6.3 | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) (API 25), [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) (Gradle/AGP, icons, App Category) |
| Package Manager: `pinnedPackages` property in `manifest.json`; `overrideBuiltIns` removed; package signatures; `UPM_CACHE_PATH` / `UPM_NPM_CACHE_PATH` unsupported (use `UPM_CACHE_ROOT`) | 6.0–6.3 | [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md), [manual-whatsnewunity62](../reference/unity6-release/manual-whatsnewunity62.md), [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |

### Minimal example of the 6.3 idioms

```csharp
using UnityEngine;

namespace RootsDance.Player
{
    public class JumpPad : MonoBehaviour
    {
        // ✅ 6.3: [SerializeField] is field-only; an auto-property needs the field: target.
        [SerializeField] private float m_launchSpeed = 8f;
        [SerializeField] private ScoreBoard m_scoreBoard; // wired in the Inspector — gameplay code never uses Find* (03)
        [field: SerializeField] public int UsesLeft { get; private set; } = 3;

        private Rigidbody m_rigidbody;

        private void Awake()
        {
            m_rigidbody = GetComponent<Rigidbody>();
        }

        private void Launch()
        {
            // ✅ Unity 6 names: linearVelocity / linearDamping (not velocity / drag).
            m_rigidbody.linearVelocity = new Vector3(0f, m_launchSpeed, 0f);
            m_rigidbody.linearDamping = 0.1f;
        }

        // ✅ Unity 6: Awaitable instead of Task; token stops it on destroy.
        private async Awaitable CooldownAsync()
        {
            await Awaitable.WaitForSecondsAsync(0.5f, destroyCancellationToken);
            UsesLeft -= 1;
        }
    }
}
```

```csharp
// ❌ Pre-Unity-6 code that no longer compiles or is obsolete in 6000.3
[SerializeField] public int UsesLeft { get; private set; }   // compile error in 6.3
var board = FindObjectOfType<ScoreBoard>();                    // obsolete; lookups belong only in bootstrap/tests/editor code — see 03/04
                                                               // bootstrap-only replacement: FindFirstObjectByType<ScoreBoard>() (04)
m_rigidbody.velocity = Vector3.up * 8f;                         // obsolete warning (UnityUpgradable) — API Updater rewrites
m_rigidbody.drag = 0.1f;                                        // obsolete warning (UnityUpgradable) — API Updater rewrites
public record Stats(int Hp);                                    // needs IsExternalInit; not serializable
```

*Source:* [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md), [scriptref-object-findobjectoftype](../reference/scripting/scriptref-object-findobjectoftype.md), [github-unitycsreference-rigidbody-bindings-cs](../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md), [github-unitycsreference-rigidbody-deprecated-cs](../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md), [scriptref-awaitable-waitforsecondsasync](../reference/scripting/scriptref-awaitable-waitforsecondsasync.md), [manual-csharp-compiler](../reference/csharp-style/manual-csharp-compiler.md); wiring rule: [03](./03-architecture-patterns.md)

## Old API → Unity 6 API

Use this table to fix training-data habits and third-party snippets. "Removed" = not present in 6000.3; "Compile error" = rejected by the compiler (an `[Obsolete(…, true)]` stub or a hard rule change); "Obsolete" = compiles with a warning (the API Updater rewrites it when marked UnityUpgradable); "Deprecated" = still works, scheduled for removal.

| Old (2022 LTS and earlier) | Unity 6000.3 | Status | Source |
|:---------------------------|:-------------|:-------|:-------|
| `Object.FindObjectOfType<T>()` | `Object.FindFirstObjectByType<T>()` or `Object.FindAnyObjectByType<T>()` (faster, any instance) | Obsolete | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md), [scriptref-object-findfirstobjectbytype](../reference/scripting/scriptref-object-findfirstobjectbytype.md) |
| `Object.FindObjectsOfType<T>()` | `Object.FindObjectsByType<T>(FindObjectsSortMode.None)` (+ `FindObjectsInactive.Include` if needed) | Obsolete | [scriptref-object-findobjectsbytype](../reference/scripting/scriptref-object-findobjectsbytype.md), [github-unitycsreference-unityengineobject-bindings-cs](../reference/scripting/github-unitycsreference-unityengineobject-bindings-cs.md) |
| `Rigidbody.velocity` | `Rigidbody.linearVelocity` | Obsolete (UnityUpgradable) | [github-unitycsreference-rigidbody-deprecated-cs](../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md), [github-unitycsreference-rigidbody-bindings-cs](../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md) |
| `Rigidbody.drag` / `Rigidbody.angularDrag` | `Rigidbody.linearDamping` / `Rigidbody.angularDamping` | Obsolete (UnityUpgradable) | same, [scriptref-rigidbody-lineardamping](../reference/scripting/scriptref-rigidbody-lineardamping.md) |
| `PhysicMaterial` / `PhysicMaterialCombine` | `PhysicsMaterial` / `PhysicsMaterialCombine` | Compile error (`[Obsolete(…, true)]`, UnityUpgradable) | [github-unitycsreference-physicsmaterial-deprecated-cs](../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md), [manual-class-physicsmaterial](../reference/scripting/manual-class-physicsmaterial.md) |
| `Rigidbody.SetDensity(float)` | set `Rigidbody.mass` | Deprecated (6.1) | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md) |
| `Physics.autoSyncTransforms = true` | call `Physics.SyncTransforms()` when needed | Deprecated (6.3) | [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| `RaycastHit.colliderInstanceID`, `ContactPair.colliderInstanceID` | `colliderEntityId` | Deprecated (6.3) | same |
| `AddForceAtPosition(f, p, ForceMode.Acceleration)` | `AddForceAtPosition(f * body.mass, p, ForceMode.Force)` — only if you need the 2022 torque result | Behaviour change | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| `[SerializeField] public T Prop { get; set; }` | `[field: SerializeField] public T Prop { get; private set; }` | Compile error (6.3) | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| `Input.GetAxis("Horizontal")`, `Input.GetButton("Jump")` | `InputSystem.actions.FindAction("Move").ReadValue<Vector2>()`, `FindAction("Jump").IsPressed()` (cache the `InputAction`) | Legacy Input Manager | [inputsystem-1-20-corresponding-old-new-api](../reference/packages/inputsystem-1-20-corresponding-old-new-api.md) |
| `Task`-returning async methods | `async Awaitable` / `Awaitable<T>`; `AwaitableCompletionSource` instead of `TaskCompletionSource` | Project rule | [manual-async-awaitable-introduction](../reference/scripting/manual-async-awaitable-introduction.md) **[project decision]** |
| Wrapping an `Awaitable` in `Task` (`AsTask`) just to `WhenAll` it with a DOTween tween | `tween.ToUniTask()` + `operation.ToUniTask()` + `UniTask.WhenAll`/`WhenAny` | Project rule, see [04](./04-unity-scripting-rules.md#async-awaitable-dotween-sequence-and-unitask) | [github.com/Cysharp/UniTask](https://github.com/Cysharp/UniTask) **[project decision, 2026-08-25]** |
| `yield return null` / `new WaitForSeconds(t)` inside async code | `await Awaitable.NextFrameAsync(token)` / `await Awaitable.WaitForSecondsAsync(t, token)` (coroutines themselves remain valid) | Alternative | [scriptref-awaitable](../reference/scripting/scriptref-awaitable.md) |
| `Instantiate` in a loop for many copies | `Object.InstantiateAsync` (`AsyncInstantiateOperation<T>`) | Addition | [scriptref-object-instantiateasync](../reference/scripting/scriptref-object-instantiateasync.md) |
| Lighting window **Auto Generate**, `Lightmapping.giWorkflowMode` | **Generate Lighting**, `Lightmapping.Bake()` / `BakeAsync()` | Removed | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| `LightingSettings.filteringGaussRadius*` (`int`) | `LightingSettings.filteringGaussianRadius*` (`float`) | Deprecated | same |
| `GraphicsFormat.DepthAuto` / `ShadowAuto` / `VideoAuto` | `GraphicsFormat.None` + `RenderTextureDescriptor.depthStencilFormat` | Compile error | same |
| `CustomEditorForRenderPipelineAttribute`, `VolumeComponentMenuForRenderPipelineAttribute` | `CustomEditor` / `VolumeComponentMenu` + `SupportedOnRenderPipelineAttribute` | Deprecated | same |
| **Build Settings** window | **Build Profiles** window (**File → Build Profiles**), `UnityEditor.Build.Profile.BuildProfile` API. `EditorBuildSettings` still exists: `globalScenes` is the global scene list (`ProjectSettings/EditorBuildSettings.asset`), which profiles inherit unless they add a **Scene List** override; `scenes` resolves to the active profile's list ([11](./11-scenes-prefabs-workflow.md)) | Renamed / extended | [manual-buildsettings](../reference/testing-tooling/manual-buildsettings.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md), [scriptref-build-profile-buildprofile](../reference/testing-tooling/scriptref-build-profile-buildprofile.md), [scriptref-editorbuildsettings](../reference/testing-tooling/scriptref-editorbuildsettings.md), [manual-build-profile-scene-list](../reference/testing-tooling/manual-build-profile-scene-list.md) |
| `ScriptableRendererFeature.SetupRenderPasses`, `ScriptableRenderer.cameraColorTarget` | render graph pass via `AddRenderPasses`; `RTHandle` targets (`cameraColorTargetHandle`) | Deprecated / Obsolete | [manual-upgradeguideunity62](../reference/unity6-release/manual-upgradeguideunity62.md), [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md) |
| `RenderPassEvent.AfterRendering` (expecting an intermediate texture) | `RenderPassEvent.AfterRenderingPostProcessing` | Behaviour change (6.2) | [manual-upgradeguideunity62](../reference/unity6-release/manual-upgradeguideunity62.md) |
| Render Graph `AddRenderPass()` + shared textures | `AddRasterRenderPass` / `AddComputePass` / `AddUnsafePass` + imported textures | Deprecated (6.3) | [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| `#pragma multi_compile _FORWARD_PLUS` | `_CLUSTER_LIGHT_LOOP` | Replaced (6.1) | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md) |
| `SHADER_QUALITY_LOW/MEDIUM/HIGH`, `SHADER_HINT_NICE_QUALITY` | `SHADER_API_MOBILE` / `SHADER_API_GLES` | Removed (URP 13) | [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md) |
| Post Processing Stack v2 (`com.unity.postprocessing`) | URP **Volume** components and Volume profiles | Unsupported in URP | [manual-integration-with-post-processing](../reference/rendering-urp/manual-integration-with-post-processing.md), [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md) |
| `VisualElement.transform.position/rotation/scale` | `style.translate/rotate/scale` (set), `resolvedStyle.translate/rotate/scale` (get) | Deprecated (6.2) | [manual-upgradeguideunity62](../reference/unity6-release/manual-upgradeguideunity62.md) |
| `ExecuteDefaultAction`, `ExecuteDefaultActionAtTarget`, `PreventDefault` | `HandleEventBubbleUp` / `HandleEventTrickleDown`, `StopPropagation` | Deprecated (6.0) | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| `UxmlFactory<T>` + `UxmlTraits` nested classes | `[UxmlElement] partial class` + `[UxmlAttribute]` properties | Superseded (6.0) | same |
| `using Cinemachine;` `CinemachineVirtualCamera`, `CinemachineFreeLook` | `using Unity.Cinemachine;` `CinemachineCamera` | Deprecated (CM 3) | [cinemachine-3-1-whats-new](../reference/packages/cinemachine-3-1-whats-new.md) |
| `CinemachineTransposer` / `CinemachineOrbitalTransposer` / `CinemachineFramingTransposer` | `CinemachineFollow` / `CinemachineOrbitalFollow` / `CinemachinePositionComposer` | Deprecated (CM 3) | same |
| `CinemachineComposer`, `CinemachinePOV`, `CinemachineCollider`, `Cinemachine3rdPersonFollow`, `CinemachineTrackedDolly` | `CinemachineRotationComposer`, `CinemachinePanTilt`, `CinemachineDeoccluder`, `CinemachineThirdPersonFollow`, `CinemachineSplineDolly` | Deprecated (CM 3) | same |
| `EditorUtility.InstanceIDToObject(int)`, `Selection.instanceIDs`, `AssetDatabase.GetAssetPath(int)` | `EditorUtility.EntityIdToObject`, `Selection.entityIds`, `AssetDatabase.GetAssetPath(EntityId)` | Obsolete (6.3) | [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| `TreeView` / `TreeViewItem` / `TreeViewState` (IMGUI) | `TreeView<int>` / `TreeView<EntityId>` | Obsolete (6.3) | same |
| `NetworkTransform.Update` override (NGO 1.x) | `NetworkTransform.OnUpdate` (NGO 2.x) | NGO 1.x deprecated | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| `Window → Package Manager` shortcut/menu path | `Window → Package Management → Package Manager` | Moved (6.1) | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md) |

## Packages shipped or released for 6000.3

"Core" = distributed with the Editor, version fixed to the Editor; "Released" = tested and supported for this Editor, version chosen by us. Package-choice rules and the installed set/versions are owned by [09 Packages](./09-packages-systems.md); this table records what Unity ships or lists as released for 6000.3 (facts only — if it ever disagrees with 09, fix 09 first).

| Package | ID | Version for 6000.3 | State | Source |
|:--------|:---|:-------------------|:------|:-------|
| Universal Render Pipeline | `com.unity.render-pipelines.universal` | 17.3 | Core | [manual-pack-core](../reference/packages/manual-pack-core.md) |
| SRP Core / Shader Graph / VFX Graph | `com.unity.render-pipelines.core` / `com.unity.shadergraph` / `com.unity.visualeffectgraph` | 17.3 | Core | same |
| uGUI (includes TextMeshPro) | `com.unity.ugui` | 2.0 | Core | same, [manual-com-unity-ugui](../reference/packages/manual-com-unity-ugui.md) |
| Test Framework | `com.unity.test-framework` | 1.6 | Core | same, [manual-com-unity-test-framework](../reference/packages/manual-com-unity-test-framework.md) |
| UI Test Framework | `com.unity.ui.test-framework` | 6.3 (Editor-bound) | Core | same |
| Multiplayer Center | `com.unity.multiplayer.center` | 1.0 | Core | same |
| Adaptive Performance (+ Android provider) | `com.unity.adaptiveperformance` | 6.0 | Core (module + samples) | same |
| UI Toolkit | built into the Editor (`UnityEngine.UIElements`) | — | Built-in | [manual-uielements](../reference/packages/manual-uielements.md) |
| Input System | `com.unity.inputsystem` | **1.20.0** | Released | [manual-com-unity-inputsystem](../reference/packages/manual-com-unity-inputsystem.md) |
| Cinemachine | `com.unity.cinemachine` | **3.1.7** (2.10.7 is still listed as compatible — we do not use it **[project decision]**) | Released | [manual-com-unity-cinemachine](../reference/packages/manual-com-unity-cinemachine.md) |
| AI Navigation | `com.unity.ai.navigation` | 2.0.14 | Released | [manual-com-unity-ai-navigation](../reference/packages/manual-com-unity-ai-navigation.md) |
| Behavior | `com.unity.behavior` | 1.0.16 | Released | [manual-com-unity-behavior](../reference/packages/manual-com-unity-behavior.md) |
| Addressables | `com.unity.addressables` | **2.9.1 released**; 2.10.x, 2.11.1, 3.0/3.1, **4.0.x** also available (the released-packages list links 4.0). Not used by default | Released | [manual-com-unity-addressables](../reference/packages/manual-com-unity-addressables.md), [manual-pack-safe](../reference/packages/manual-pack-safe.md) |
| Timeline | `com.unity.timeline` | 1.8 | Released | [manual-pack-safe](../reference/packages/manual-pack-safe.md) |
| ProBuilder | `com.unity.probuilder` | 6.1 | Released | same |
| Code Coverage | `com.unity.testtools.codecoverage` | 1.3.0 | Released | [manual-com-unity-testtools-codecoverage](../reference/packages/manual-com-unity-testtools-codecoverage.md) |
| Memory Profiler | `com.unity.memoryprofiler` | 1.1 | Released | [manual-pack-safe](../reference/packages/manual-pack-safe.md) |
| Profile Analyzer | `com.unity.performance.profile-analyzer` | 1.4 | Released | same |
| Project Auditor | `com.unity.project-auditor` | 3.0.x available (page lists 1.0.2 as "released") | Released | [manual-com-unity-project-auditor](../reference/packages/manual-com-unity-project-auditor.md) |
| Visual Studio Editor (VS **and VS Code**) | `com.unity.ide.visualstudio` | 2.0.28 | Released | [manual-com-unity-ide-visualstudio](../reference/packages/manual-com-unity-ide-visualstudio.md) |
| JetBrains Rider Editor | `com.unity.ide.rider` | 3.0.40 | Released | [manual-com-unity-ide-rider](../reference/packages/manual-com-unity-ide-rider.md) |
| Netcode for GameObjects (not used) | `com.unity.netcode.gameobjects` | 2.13.1 | Released | [manual-com-unity-netcode-gameobjects](../reference/packages/manual-com-unity-netcode-gameobjects.md) |
| Unity Version Control (not used — Git) | `com.unity.collab-proxy` | 2.13 | Released | [manual-pack-safe](../reference/packages/manual-pack-safe.md) |
| Burst / Mathematics / Collections | `com.unity.burst` / `com.unity.mathematics` / `com.unity.collections` | 1.8 / 1.3 / 2.6 | Released | same |
| Character Controller (**ECS only**, not the classic `CharacterController` component) | `com.unity.charactercontroller` | 1.4.5 | Released | [manual-com-unity-charactercontroller](../reference/packages/manual-com-unity-charactercontroller.md) |

Package updates inside the 6.3 line (e.g. 6000.3.22f1 bumped `com.unity.netcode.gameobjects` 2.13.0 → 2.13.1 and `com.unity.recorder` 5.1.6 → 5.1.7) are listed per patch in the release notes.
*Source:* [releases-6000-3-22f1](../reference/unity6-release/releases-6000-3-22f1.md)

### Deprecated, removed or superseded — do not add

| Item | Status in 6000.3 | Use instead | Source |
|:-----|:-----------------|:------------|:-------|
| `com.unity.ide.vscode` (Visual Studio Code Editor package) | "no longer supported and should not be used" | `com.unity.ide.visualstudio` 2.0.20+ with the *Unity for Visual Studio Code* extension | [manual-scripting-ide-support](../reference/testing-tooling/manual-scripting-ide-support.md) |
| Netcode for GameObjects **1.x** | Deprecated, replaced by 2.x | NGO 2.13.1 (if multiplayer is ever needed) | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| `com.unity.multiplayer.widgets` | Deprecated "in favor of Unity Building Blocks"; "no longer supported on this editor version" | Unity Building Blocks (see the 6000.3 manual section) | [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md), [manual-index](../reference/unity6-release/manual-index.md) |
| `com.havok.physics` | "no longer supported on this editor version" | built-in PhysX / `com.unity.physics` 1.4 (ECS) | same |
| Standalone Lobby / Matchmaker / Multiplay / Relay SDKs; Multiplay Hosting | Deprecated; hosting removed and shut down 2026-03-31 | Multiplayer Services 2.x | same, [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| Cloud Diagnostics (`com.unity.services.cloud-diagnostics`) | Deprecated 2025-08-13 (still in the released list) | Diagnostics (Developer Data framework) | [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| Advertisement Legacy (`com.unity.ads`) | Migrate | Ads Mediation / LevelPlay (`com.unity.services.levelplay`) | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| `com.unity.adaptiveperformance` as a *standalone* package, Samsung provider | Core module now; Samsung provider deprecated | nothing to install | same, [releases-6000-3-0f1](../reference/unity6-release/releases-6000-3-0f1.md) |
| Post Processing Stack v2 (`com.unity.postprocessing` 3.5) | Listed as released, but "URP is not compatible with the Post Processing Stack v2 package" | URP Volume framework | [manual-integration-with-post-processing](../reference/rendering-urp/manual-integration-with-post-processing.md), [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md) |
| URP Compatibility Mode | Removed (6.3) | Render Graph | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| Cinemachine 2.x components (`CinemachineVirtualCamera`, …) | Deprecated in CM 3 | `CinemachineCamera` + CM 3 components | [cinemachine-3-1-whats-new](../reference/packages/cinemachine-3-1-whats-new.md) |
| Legacy Input Manager (`UnityEngine.Input`) | "deprecated built-in Input Manager" | Input System 1.20 | [manual-input](../reference/scripting/manual-input.md) |
| Enlighten baked GI; Lighting **Auto Generate** | Removed (6.0) | Progressive GPU/CPU lightmapper; manual Generate Lighting | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |
| PVRTC texture compression; Legacy ETC compressor | Deprecated (6.1) / removed (6.3) | ASTC / ETC2; default ETC compressor | [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md), [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| Experimental `AdditionalBakedProbes`, `Lightmapping.CustomBake` | Removed / obsolete (6.3) | `LightTransport.IProbeIntegrator` | [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md) |
| Facebook Instant Games platform; Magic Leap XR plugin | Deprecated (6.3) | Web platform; — | same |
| 7-Zip zstandard archives | Not supported since 6.0 | `.zip` deflate or `.7z` LZMA/LZMA2 | [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md) |

## System requirements (6000.3)

Relevant rows for a desktop-first team with an optional Web build; full tables incl. mobile/console/XR are in the source.
*Source:* [manual-system-requirements](../reference/unity6-release/manual-system-requirements.md)

| Target | Requirement |
|:-------|:------------|
| **Editor — Windows** | Windows 10 21H1 (build 19043)+ x64, or Windows 11 21H2+ Arm64; SSE2; DX10/11/12 or Vulkan GPU (no Vulkan on Windows-on-Arm) |
| **Editor — macOS** | Ventura 13+; Intel x64 or Apple M1+; Metal GPU; **Rosetta 2 required on Apple silicon** (both Editor builds); no CPU lightmapping on Apple silicon |
| **Editor — Linux** | Ubuntu 22.04 / 24.04, x64, OpenGL 3.2+ or Vulkan, Gnome on X11/Wayland; case-sensitive file system; VP8 video import only |
| **Editor RAM / disk** | minimum 8 GB RAM recommended; high-IOPS drive recommended for builds |
| **Player — Windows** | Windows 10 21H1+; x86/x64/Arm64; DX10+ or Vulkan; IL2CPP builds need VS 2019 C++ tools + Windows SDK 10.0.19041.0+ |
| **Player — macOS** | Monterey 12+; Apple silicon or x64; Metal; IL2CPP builds need Xcode |
| **Player — Linux** | Ubuntu 22.04 / 24.04, 64-bit only |
| **Player — Web** | Desktop Chrome / Firefox / Safari / Edge that are WebGL 2.0-capable, HTML5, 64-bit, WebAssembly-capable; mobile iOS Safari 15+ / Chrome 58+ (Safari 18.2+ for the higher memory limit) |
| **Player — Android / iOS** (not targeted) | Android 7.1 (API 25)+, ARMv7 Neon or ARM64, GLES 3.0+/Vulkan; iOS 15+, A8+, Metal, Xcode 16+ |

The Editor is supported only on physical workstations/laptops — "without emulation, container or compatibility layer".

## Upgrade-guide highlights (cumulative 2022 LTS → 6.3)

Read these when a teammate pastes code or a prefab from an older project.

- **2022 LTS → 6.0:** Render Graph URP; `FindObjectOfType` family obsolete; Enlighten baked GI and Auto Generate removed; ambient/skybox no longer auto-baked; torque change for `VelocityChange`/`Acceleration`; `DepthAuto/ShadowAuto/VideoAuto` errors; runtime mipmap limits opt-in; UI Toolkit event-handling and UXML custom-control rewrite; **Assets/Create** menu and ScriptTemplates reorganised; Android `UnityPlayer` → `UnityPlayerForActivityOrService`; Metal half/min16float buffer layout; `UPM_CACHE_PATH` gone; 7-Zip zstd gone.
  *Why:* this is the release most training data and Asset Store samples predate; nearly every "it compiled in 2022" failure traces back to one of these items.
  *Source:* [manual-upgradeguideunity6](../reference/unity6-release/manual-upgradeguideunity6.md), [manual-upgrade-guide-unity-6](../reference/unity6-release/manual-upgrade-guide-unity-6.md)
- **6.0 → 6.1:** Window menu reshuffle (breaks custom shortcuts); `_FORWARD_PLUS` → `_CLUSTER_LIGHT_LOOP`; PVRTC deprecated; `Rigidbody.SetDensity` deprecated; DX12 default Auto Graphics API for new Windows projects; Android Gradle 8.11 / AGP 8.7.2 / NDK r27c.
  *Why:* shader snippets and menu paths from 6.0-era tutorials silently stop matching here.
  *Source:* [manual-upgradeguideunity61](../reference/unity6-release/manual-upgradeguideunity61.md)
- **6.1 → 6.2:** a set of shader APIs deprecated (full list in the 6.2 release notes); `AfterRendering` timing; `SetupRenderPasses` deprecated; `VisualElement.transform` deprecated.
  *Why:* renderer features and UI Toolkit animations copied from 6.0/6.1 projects compile with warnings or render at the wrong time.
  *Source:* [manual-upgradeguideunity62](../reference/unity6-release/manual-upgradeguideunity62.md)
- **6.2 → 6.3:** `[SerializeField]` fields-only; `EntityId` / `SceneHandle` types (recompile DLLs); URP Compatibility Mode removed (`URP_COMPATIBILITY_MODE` define, dies in 6.4); Legacy ETC compressor removed; experimental lightmapping API removed; NGO 1.x deprecated (`NetworkTransform.OnUpdate`); Multiplay Hosting removed; Multiplayer Play Mode 2.0.1 drops remote instances; Adaptive Performance core module; `UPM_NPM_CACHE_PATH` unsupported; Android API 25 minimum, Gradle 9.1.0 / AGP 9.0.0, App Category; stricter USS parser; Magic Leap and Facebook Instant Games deprecated; Search Index Manager removed (use **Preferences → Search → Indexing**).
  *Why:* these are the breaks that even a fresh 6.2 project hits on opening in 6.3 — the `[SerializeField]` and USS changes are compile/import errors, not warnings.
  *Source:* [manual-upgradeguideunity63](../reference/unity6-release/manual-upgradeguideunity63.md), [manual-whatsnewunity63](../reference/unity6-release/manual-whatsnewunity63.md) (Android API 25)
- **Procedure:** back up via Git, upgrade packages first, open in the new Editor through the Hub, accept Safe Mode if there are compile errors, accept the API Updater, then fix the console and run the tests.
  *Why:* Safe Mode and the API Updater do the mechanical part; skipping the backup turns a failed upgrade into lost work.
  *Source:* [manual-upgrade-project](../reference/unity6-release/manual-upgrade-project.md), [manual-apiupdater](../reference/unity6-release/manual-apiupdater.md)
- **Known issues in 6000.3.22f1 worth knowing:** TMP Font Asset Creator can crash when generating a multi-threaded atlas; Editor can crash in `WriteObjectToVector` when entering Play Mode (asset importers); Metal command-buffer timeout freezes. Check the release notes before blaming project code.
  *Why:* an hour spent debugging a known Editor crash is an hour the jam does not have.
  *Source:* [releases-6000-3-22f1](../reference/unity6-release/releases-6000-3-22f1.md)

## Anti-patterns

- ❌ Pasting a 2021/2022-era controller with `rb.velocity`, `rb.drag`, `FindObjectOfType`, `Input.GetAxis` → ✅ translate with the [old → new table](#old-api--unity-6-api) before committing.
- ❌ `public record PlayerStats(...)` or `{ get; init; }` in gameplay/data code → ✅ `[System.Serializable]` class/struct with `[SerializeField] private` fields ([01](./01-csharp-style.md)).
- ❌ `[SerializeField] public float Speed { get; set; }` → ✅ `[field: SerializeField] public float Speed { get; private set; }` or a plain private field.
- ❌ `async Task` methods, `Task.Delay`, `.Result` on the main thread → ✅ `async Awaitable` + `Awaitable.WaitForSecondsAsync(t, destroyCancellationToken)`.
- ❌ Awaiting the same `Awaitable` twice or storing it for later → ✅ await once; wrap in a `Task` only if fan-out is unavoidable.
- ❌ Reaching for UniTask to sequence several DOTween tweens → ✅ DOTween `Sequence`; UniTask is only for mixing a tween with a non-tween async op.
- ❌ Enabling "Compatibility Mode (Render Graph Disabled)" or defining `URP_COMPATIBILITY_MODE` to make an old renderer feature work → ✅ rewrite the pass with the render graph API ([07](./07-rendering-urp.md)).
- ❌ Adding `com.unity.ide.vscode`, `com.unity.textmeshpro`, `com.unity.postprocessing`, Cinemachine 2.10, NGO 1.x or Multiplayer Widgets to `manifest.json` → ✅ only packages from the version table; versions are locked by `packages-lock.json` — no `pinnedPackages` unless [09](./09-packages-systems.md)'s exception applies.
- ❌ Using `EditorUtility.InstanceIDToObject(int)` in new Editor tooling → ✅ `EditorUtility.EntityIdToObject`.
- ❌ Relying on automatic lightmap baking or ambient probe baking → ✅ press **Generate Lighting** (or `Lightmapping.BakeAsync`) and commit the Lighting Data Asset ([11](./11-scenes-prefabs-workflow.md)).
- ❌ Following a docs.unity3d.com page without `/6000.3/` in the URL, or a package page for a different major version → ✅ re-open the 6000.3 manual / the package version from the table.

## Review checklist

- [ ] Project opens in **6000.3.22f1** (`ProjectSettings/ProjectVersion.txt`) and nobody upgraded the Editor without a team decision.
- [ ] No `record`, `init`, covariant returns, module initializers, or C# 10+ syntax; code compiles without an `IsExternalInit` shim.
- [ ] API Compatibility Level is **.NET Standard 2.1**; no managed DLL built for .NET Core / .NET 5+ anywhere under `Assets/` (third-party DLLs live in `Assets/ThirdParty/`, see [02](./02-project-structure.md)).
- [ ] `[SerializeField]` appears only on fields; auto-properties use `[field: SerializeField]`.
- [ ] No `FindObjectOfType` / `FindObjectsOfType`; `FindObjectsByType` passes `FindObjectsSortMode.None` unless ordering is required; no `Find*` at all in gameplay code ([03](./03-architecture-patterns.md)).
- [ ] No `Rigidbody.velocity` / `drag` / `angularDrag`, no `PhysicMaterial`, no `SetDensity`, no `Physics.autoSyncTransforms`.
- [ ] No `UnityEngine.Input` calls; `Active Input Handling` is **Input System Package (New)**.
- [ ] Async code returns `Awaitable` / `Awaitable<T>` and takes a `CancellationToken`; no `Task.Run` wrappers. UniTask, if present, only composes a tween with a non-tween async op.
- [ ] Custom renderer features use the render graph API; no `SetupRenderPasses`, no `URP_COMPATIBILITY_MODE`, no `_FORWARD_PLUS`.
- [ ] `Packages/manifest.json` lists only packages/versions from the table (Input System 1.20.0, Cinemachine 3.1.7, AI Navigation 2.0.14, …) and none from the deprecated list.
- [ ] Console shows no **(UnityUpgradable)** warnings and no deprecation warnings introduced by the change.
- [ ] Any new Editor script uses `EntityId` overloads, not `int` instance IDs.
- [ ] Third-party sample code was checked against the old → new table before being merged.

## Sources

1. [../reference/unity6-release/manual-whatsnewunity63.md](../reference/unity6-release/manual-whatsnewunity63.md) — New in Unity 6.3 — https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html
2. [../reference/unity6-release/manual-upgradeguideunity63.md](../reference/unity6-release/manual-upgradeguideunity63.md) — Upgrade to Unity 6.3 — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html
3. [../reference/unity6-release/manual-upgradeguideunity62.md](../reference/unity6-release/manual-upgradeguideunity62.md) — Upgrade to Unity 6.2 — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity62.html
4. [../reference/unity6-release/manual-upgradeguideunity61.md](../reference/unity6-release/manual-upgradeguideunity61.md) — Upgrade to Unity 6.1 — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html
5. [../reference/unity6-release/manual-upgradeguideunity6.md](../reference/unity6-release/manual-upgradeguideunity6.md) — Upgrade to Unity 6.0 — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html
6. [../reference/unity6-release/manual-upgrade-guide-unity-6.md](../reference/unity6-release/manual-upgrade-guide-unity-6.md) — Upgrade to URP 17 (Unity 6.0) — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrade-guide-unity-6.html
7. [../reference/unity6-release/manual-upgradeguides.md](../reference/unity6-release/manual-upgradeguides.md) — Upgrade Unity (index) — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuides.html
8. [../reference/unity6-release/manual-upgrade-project.md](../reference/unity6-release/manual-upgrade-project.md) — Upgrade your Unity project — https://docs.unity3d.com/6000.3/Documentation/Manual/upgrade-project.html
9. [../reference/unity6-release/manual-apiupdater.md](../reference/unity6-release/manual-apiupdater.md) — API updater — https://docs.unity3d.com/6000.3/Documentation/Manual/APIUpdater.html
10. [../reference/unity6-release/manual-whatsnewunity6.md](../reference/unity6-release/manual-whatsnewunity6.md) — New in Unity 6.0 — https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html
11. [../reference/unity6-release/manual-whatsnewunity6preview.md](../reference/unity6-release/manual-whatsnewunity6preview.md) — New in Unity 6.0 Preview — https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6Preview.html
12. [../reference/unity6-release/manual-whatsnewunity61.md](../reference/unity6-release/manual-whatsnewunity61.md) — New in Unity 6.1 — https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity61.html
13. [../reference/unity6-release/manual-whatsnewunity62.md](../reference/unity6-release/manual-whatsnewunity62.md) — New in Unity 6.2 — https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html
14. [../reference/unity6-release/manual-urp-whats-new.md](../reference/unity6-release/manual-urp-whats-new.md) — What's new in URP 17 (Unity 6.0) — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/whats-new/urp-whats-new.html
15. [../reference/unity6-release/manual-system-requirements.md](../reference/unity6-release/manual-system-requirements.md) — System requirements for Unity 6.3 — https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html
16. [../reference/unity6-release/manual-index.md](../reference/unity6-release/manual-index.md) — Unity 6.3 User Manual — https://docs.unity3d.com/6000.3/Documentation/Manual/index.html
17. [../reference/unity6-release/manual-unity-ai.md](../reference/unity6-release/manual-unity-ai.md) — Unity's AI — https://docs.unity3d.com/6000.3/Documentation/Manual/unity-ai.html
18. [../reference/unity6-release/releases-6000-3-22f1.md](../reference/unity6-release/releases-6000-3-22f1.md) — Unity 6000.3.22f1 release notes — https://unity.com/releases/editor/whats-new/6000.3.22f1
19. [../reference/unity6-release/releases-6000-3-0f1.md](../reference/unity6-release/releases-6000-3-0f1.md) — Unity 6000.3.0f1 release notes — https://unity.com/releases/editor/whats-new/6000.3.0f1
20. [../reference/unity6-release/releases-support.md](../reference/unity6-release/releases-support.md) — Unity 6 release support — https://unity.com/releases/unity-6/support
21. [../reference/unity6-release/blog-unity-6-3-lts-is-now-available.md](../reference/unity6-release/blog-unity-6-3-lts-is-now-available.md) — Unity 6.3 LTS is now available — https://unity.com/blog/unity-6-3-lts-is-now-available
22. [../reference/unity6-release/blog-unity-6-features-announcement.md](../reference/unity6-release/blog-unity-6-features-announcement.md) — Unity 6 is here: See what's new — https://unity.com/blog/unity-6-features-announcement
23. [../reference/unity6-release/blog-introducing-unity-6-launch.md](../reference/unity6-release/blog-introducing-unity-6-launch.md) — Unity 6 launches today! — https://unity.com/blog/introducing-unity-6-launch
24. [../reference/unity6-release/blog-unity-engine-2025-roadmap.md](../reference/unity6-release/blog-unity-engine-2025-roadmap.md) — What's Next: Unity Engine 2025 Roadmap — https://unity.com/blog/unity-engine-2025-roadmap
25. [../reference/scripting/blog-unite-seoul-keynote-2026-recap.md](../reference/scripting/blog-unite-seoul-keynote-2026-recap.md) — Unite Seoul 2026 Keynote Recap: Announcing Unity 7 — https://unity.com/blog/unite-seoul-keynote-2026-recap
26. [../reference/csharp-style/manual-csharp-compiler.md](../reference/csharp-style/manual-csharp-compiler.md) — C# compiler and language version reference — https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html
27. [../reference/scripting/manual-overview-of-dot-net-in-unity.md](../reference/scripting/manual-overview-of-dot-net-in-unity.md) — Unity .NET features — https://docs.unity3d.com/6000.3/Documentation/Manual/overview-of-dot-net-in-unity.html
28. [../reference/scripting/manual-dotnet-profile-support.md](../reference/scripting/manual-dotnet-profile-support.md) — API compatibility levels for .NET — https://docs.unity3d.com/6000.3/Documentation/Manual/dotnet-profile-support.html
29. [../reference/scripting/manual-scripting-backends.md](../reference/scripting/manual-scripting-backends.md) — Scripting back ends — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html
30. [../reference/scripting/manual-async-awaitable-introduction.md](../reference/scripting/manual-async-awaitable-introduction.md) — Introduction to asynchronous programming with Awaitable — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html
31. [../reference/scripting/scriptref-awaitable.md](../reference/scripting/scriptref-awaitable.md) — Scripting API: Awaitable — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html
32. [../reference/scripting/scriptref-awaitable-waitforsecondsasync.md](../reference/scripting/scriptref-awaitable-waitforsecondsasync.md) — Scripting API: Awaitable.WaitForSecondsAsync — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.WaitForSecondsAsync.html
33. [../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md](../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md) — Scripting API: MonoBehaviour.destroyCancellationToken — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html
34. [../reference/scripting/scriptref-application-exitcancellationtoken.md](../reference/scripting/scriptref-application-exitcancellationtoken.md) — Scripting API: Application.exitCancellationToken — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-exitCancellationToken.html
35. [../reference/scripting/scriptref-object-findobjectoftype.md](../reference/scripting/scriptref-object-findobjectoftype.md) — Scripting API: Object.FindObjectOfType (obsolete) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectOfType.html
36. [../reference/scripting/scriptref-object-findfirstobjectbytype.md](../reference/scripting/scriptref-object-findfirstobjectbytype.md) — Scripting API: Object.FindFirstObjectByType — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html
37. [../reference/scripting/scriptref-object-findobjectsbytype.md](../reference/scripting/scriptref-object-findobjectsbytype.md) — Scripting API: Object.FindObjectsByType — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html
38. [../reference/scripting/scriptref-object-instantiateasync.md](../reference/scripting/scriptref-object-instantiateasync.md) — Scripting API: Object.InstantiateAsync — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html
39. [../reference/scripting/github-unitycsreference-unityengineobject-bindings-cs.md](../reference/scripting/github-unitycsreference-unityengineobject-bindings-cs.md) — UnityCsReference 6000.3: UnityEngineObject.bindings.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Runtime/Export/Scripting/UnityEngineObject.bindings.cs
40. [../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md](../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md) — UnityCsReference 6000.3: Rigidbody.bindings.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/Rigidbody.bindings.cs
41. [../reference/scripting/scriptref-rigidbody-linearvelocity.md](../reference/scripting/scriptref-rigidbody-linearvelocity.md) — Scripting API: Rigidbody.linearVelocity — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearVelocity.html
42. [../reference/scripting/scriptref-rigidbody-lineardamping.md](../reference/scripting/scriptref-rigidbody-lineardamping.md) — Scripting API: Rigidbody.linearDamping — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearDamping.html
43. [../reference/scripting/manual-class-rigidbody.md](../reference/scripting/manual-class-rigidbody.md) — Rigidbody component reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Rigidbody.html
44. [../reference/scripting/manual-class-physicsmaterial.md](../reference/scripting/manual-class-physicsmaterial.md) — Physics Material asset reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsMaterial.html
45. [../reference/scripting/scriptref-physicsmaterial.md](../reference/scripting/scriptref-physicsmaterial.md) — Scripting API: PhysicsMaterial — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial.html
46. [../reference/scripting/scriptref-serializefield.md](../reference/scripting/scriptref-serializefield.md) — Scripting API: SerializeField — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html
47. [../reference/scripting/manual-input.md](../reference/scripting/manual-input.md) — Input — https://docs.unity3d.com/6000.3/Documentation/Manual/Input.html
48. [../reference/scripting/manual-input-introduction.md](../reference/scripting/manual-input-introduction.md) — Introduction to Input — https://docs.unity3d.com/6000.3/Documentation/Manual/input-introduction.html
49. [../reference/packages/inputsystem-1-20-installation.md](../reference/packages/inputsystem-1-20-installation.md) — Input System — Installation — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Installation.html
50. [../reference/packages/inputsystem-1-20-corresponding-old-new-api.md](../reference/packages/inputsystem-1-20-corresponding-old-new-api.md) — Corresponding old and new APIs — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/corresponding-old-new-api.html
51. [../reference/packages/cinemachine-3-1-whats-new.md](../reference/packages/cinemachine-3-1-whats-new.md) — Cinemachine 3 — What's new — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/whats-new.html
52. [../reference/packages/manual-pack-safe.md](../reference/packages/manual-pack-safe.md) — Released packages (Unity 6.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/pack-safe.html
53. [../reference/packages/manual-pack-core.md](../reference/packages/manual-pack-core.md) — Core packages — https://docs.unity3d.com/6000.3/Documentation/Manual/pack-core.html
54. [../reference/packages/manual-com-unity-inputsystem.md](../reference/packages/manual-com-unity-inputsystem.md) — Input System package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.inputsystem.html
55. [../reference/packages/manual-com-unity-cinemachine.md](../reference/packages/manual-com-unity-cinemachine.md) — Cinemachine package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.cinemachine.html
56. [../reference/packages/manual-com-unity-ai-navigation.md](../reference/packages/manual-com-unity-ai-navigation.md) — AI Navigation package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ai.navigation.html
57. [../reference/packages/manual-com-unity-behavior.md](../reference/packages/manual-com-unity-behavior.md) — Behavior package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.behavior.html
58. [../reference/packages/behavior-1-0-index.md](../reference/packages/behavior-1-0-index.md) — About Unity Behavior (1.0.16) — https://docs.unity3d.com/Packages/com.unity.behavior@1.0/manual/index.html
59. [../reference/packages/manual-com-unity-addressables.md](../reference/packages/manual-com-unity-addressables.md) — Addressables package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.addressables.html
60. [../reference/packages/manual-com-unity-test-framework.md](../reference/packages/manual-com-unity-test-framework.md) — Test Framework package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.test-framework.html
61. [../reference/packages/manual-com-unity-testtools-codecoverage.md](../reference/packages/manual-com-unity-testtools-codecoverage.md) — Code Coverage package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.testtools.codecoverage.html
62. [../reference/packages/manual-com-unity-project-auditor.md](../reference/packages/manual-com-unity-project-auditor.md) — Project Auditor package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.project-auditor.html
63. [../reference/packages/manual-com-unity-ide-visualstudio.md](../reference/packages/manual-com-unity-ide-visualstudio.md) — Visual Studio Editor package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ide.visualstudio.html
64. [../reference/packages/manual-com-unity-ide-rider.md](../reference/packages/manual-com-unity-ide-rider.md) — JetBrains Rider Editor package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ide.rider.html
65. [../reference/packages/manual-com-unity-netcode-gameobjects.md](../reference/packages/manual-com-unity-netcode-gameobjects.md) — Netcode for GameObjects package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.netcode.gameobjects.html
66. [../reference/packages/manual-com-unity-charactercontroller.md](../reference/packages/manual-com-unity-charactercontroller.md) — Character Controller (ECS) package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.charactercontroller.html
67. [../reference/packages/manual-com-unity-ugui.md](../reference/packages/manual-com-unity-ugui.md) — uGUI package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ugui.html
68. [../reference/packages/ugui-2-0-textmeshpro-index.md](../reference/packages/ugui-2-0-textmeshpro-index.md) — TextMesh Pro (inside uGUI 2.0) — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/index.html
69. [../reference/packages/manual-uielements.md](../reference/packages/manual-uielements.md) — UI Toolkit — https://docs.unity3d.com/6000.3/Documentation/Manual/UIElements.html
70. [../reference/packages/en-us-multiplayer-center.md](../reference/packages/en-us-multiplayer-center.md) — Get started with the Multiplayer Center — https://docs.unity.com/en-us/multiplayer/multiplayer-center
71. [../reference/testing-tooling/manual-scripting-ide-support.md](../reference/testing-tooling/manual-scripting-ide-support.md) — Integrated development environment (IDE) support — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html
72. [../reference/testing-tooling/manual-buildsettings.md](../reference/testing-tooling/manual-buildsettings.md) — Create a build from the Editor (Build Profiles) — https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html
73. [../reference/rendering-urp/manual-creating-a-new-project-with-urp.md](../reference/rendering-urp/manual-creating-a-new-project-with-urp.md) — Create a new project that uses URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/creating-a-new-project-with-urp.html
74. [../reference/rendering-urp/manual-integration-with-post-processing.md](../reference/rendering-urp/manual-integration-with-post-processing.md) — Introduction to post-processing in URP — https://docs.unity3d.com/6000.3/Documentation/Manual/urp/integration-with-post-processing.html
75. [../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md](../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md) — UnityCsReference 6000.3: Rigidbody.deprecated.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/Rigidbody.deprecated.cs
76. [../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md](../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md) — UnityCsReference 6000.3: PhysicsMaterial.deprecated.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/PhysicsMaterial.deprecated.cs
77. [../reference/testing-tooling/scriptref-build-profile-buildprofile.md](../reference/testing-tooling/scriptref-build-profile-buildprofile.md) — Scripting API: BuildProfile — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html
78. [../reference/testing-tooling/scriptref-editorbuildsettings.md](../reference/testing-tooling/scriptref-editorbuildsettings.md) — Scripting API: EditorBuildSettings — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html
79. [../reference/testing-tooling/manual-build-profile-scene-list.md](../reference/testing-tooling/manual-build-profile-scene-list.md) — Manage scenes in a build — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html
