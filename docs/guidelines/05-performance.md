# 05. Performance guidelines

> **Scope:** Practical performance rules for the *Where the Roots Dance* 3D game — frame budget, profiling workflow, per-frame code hygiene, managed memory, pooling, physics, rendering, UI, audio, asset import and build size.
> **Applies to:** All C# under `Assets/RootsDance/Scripts`, all scenes/prefabs/assets under `Assets/RootsDance/`, and the Project Settings that affect runtime performance.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-26

Related guidelines: [04 Unity scripting rules](./04-unity-scripting-rules.md) owns event-function semantics, coroutines and `Awaitable`; [07 Rendering and HDRP](./07-rendering-hdrp.md) owns HDRP asset/global settings setup and the lighting workflow; [08 Testing and tooling](./08-testing-tooling.md) owns Editor/IDE setup; [09 Packages and systems](./09-packages-systems.md) owns package choices. This document says *what to keep cheap and how to prove it*; those documents say *how to configure the feature*.

## TL;DR — rules at a glance

1. **MUST** measure before optimizing: profile a **Development Build** on the min-spec machine, read **frame time in ms** (not fps), and decide CPU-bound vs GPU-bound from the Profiler **Highlights** / **Timeline** view before touching code.
2. **MUST** stay inside the frame budget table below: 16.6 ms per frame on desktop during gameplay, **0 B `GC.Alloc`** in steady-state gameplay frames.
3. **MUST** cache references (`GetComponent`, `Camera.main`, and the rare `FindFirstObjectByType` that 03/04 permit) in `Awake`/`Start`; **NEVER** look them up in `Update`, `FixedUpdate` or `LateUpdate`.
4. **MUST** use non-allocating APIs in per-frame code: `Physics.*NonAlloc` with a pre-allocated buffer, `CompareTag`, `TryGetComponent`, cached `Shader.PropertyToID` / `Animator.StringToHash` ids, reused collections (`Clear()`), `ListPool<T>`.
5. **NEVER** allocate per frame: no string concatenation/interpolation, LINQ, closures that capture locals, `params` overloads, `new` arrays/lists, boxing, or `new WaitForSeconds` inside a `yield`.
6. **MUST** pool anything spawned repeatedly (projectiles, VFX, pickups, UI rows) with `UnityEngine.Pool.ObjectPool<T>`; **NEVER** `Instantiate`/`Destroy` in a loop during gameplay.
7. **MUST** keep **Incremental GC** enabled (Player Settings default); **NEVER** call `System.GC.Collect()` during gameplay — only in the scene-transition flow.
8. **MUST** give dynamic bodies primitive colliders (sphere/capsule/box, compound if needed); non-convex Mesh Colliders are for static geometry only.
9. **MUST** pass a serialized `LayerMask`, an explicit `QueryTriggerInteraction` and the shortest max distance to every physics query; layers and the collision matrix are owned by [09](./09-packages-systems.md#layers-and-the-collision-matrix).
10. **MUST** share materials and keep them SRP-Batcher compatible (the SRP Batcher is always on in HDRP); **NEVER** read `Renderer.material` or use `MaterialPropertyBlock` on batched objects (use `sharedMaterial` or Material Variants, per [07 §9.2](./07-rendering-hdrp.md#92-srp-batcher-compatibility)).
11. **MUST** run exactly one Unity `Camera` (rule owned by [09](./09-packages-systems.md) and [11](./11-scenes-prefabs-workflow.md)); every extra enabled camera re-runs culling, sorting and batching.
12. **SHOULD** stay inside [07](./07-rendering-hdrp.md)'s lighting budgets: lights Realtime today, Mixed + baked GI/APV only once baking starts (07 §5.3), shadow-casting lights only as 07 §11 allows; **NEVER** a shadow-casting point light.
13. **MUST** import assets per the tables in section 7: textures Max Size ≤ 2048 and GPU-compressed (POT, Read/Write, mipmaps per [07 §10](./07-rendering-hdrp.md#10-texture-import-settings-that-affect-rendering)); meshes Read/Write off; 3D audio mono, load type by clip size.
14. **SHOULD** wrap every non-trivial per-frame system in a `ProfilerMarker` named `RootsDance.<System>.<Phase>` so it shows up by name in the Profiler.
15. **NEVER** ship `Debug.Log` in per-frame paths; dev-only logging goes through `RootsDance.Core.Log` ([04](./04-unity-scripting-rules.md#logging)), which compiles out of release builds.

## 1. Measure first: budget and profiling workflow

### 1.1 Frame budget

Use **frame time in milliseconds**, never fps, when talking about performance. 60 fps is 16.66 ms; 56.25 fps is 17.77 ms — the same 1.1 ms that separates 900 fps from 450 fps. Even a single frame over budget during gameplay is a visible hitch; menus and loading screens may exceed it.
- *Source:* [Ultimate guide to profiling (Unity 6)](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) · [Best practices for profiling game performance](../reference/performance/how-to-best-practices-for-profiling-game-performance.md)

| Budget item | Desktop (the only target) | How to read it |
|---|---|---|
| Target frame time (gameplay) | **16.6 ms** (60 fps) | Profiler Highlights module, target 60 |
| Worst frame on min-spec (gameplay) | frame time never above 33.3 ms | Highlights "Bottlenecks" count must be 0 over a 300-frame capture with the target set to 30 fps |
| CPU main thread (scripts + physics + animation + UI) | ≤ 8 ms | CPU module, Timeline, `PlayerLoop` minus `WaitForTargetFPS` |
| — of which scripts (`BehaviourUpdate`, `LateUpdate`, coroutines) | ≤ 3 ms | Hierarchy view, `BehaviourUpdate` / `PreLateUpdate.ScriptRunBehaviourLateUpdate` |
| — of which physics (`FixedBehaviourUpdate`, `Physics.*`) | ≤ 2 ms | Physics module / `Physics.Processing` |
| Render thread + culling | ≤ 5 ms | Timeline, render thread row |
| GPU time (1080p) | ≤ 12 ms | Highlights "GPU Time" |
| `GC.Alloc` per steady-state gameplay frame | **0 B** | Hierarchy view, GC.Alloc column, Memory module "GC allocated in frame" |
| System Used Memory | ≤ 2 GB | Memory Profiler snapshot, Summary tab |
| Investigate when (Stats overlay) | Batches > 1000 or SetPass > 200 | Game view Stats |

HDRP is a desktop-only pipeline (no WebGL/WebGPU, no mobile — see [09](./09-packages-systems.md#package-inventory-for-60003)), so there is one budget column, and the GPU one is the tight one: HDRP's per-frame cost (volumetrics, shadow atlases, post) is higher than URP's at the same content.

The frame-time targets follow Unity's guidance (30 fps = 33.33 ms, 60 fps = 16.66 ms); the split into sub-budgets, the memory caps and the batch thresholds are **[project decision]** — provisional until the min-spec machine is confirmed (see 1.5). The CPU and GPU each get the *full* frame time because Unity runs them in parallel; both must individually fit.
- *Why:* A budget gives every system owner a number to check against instead of "it feels slow".
- *Source:* [Highlights module](../reference/performance/manual-profilerhighlights.md) (CPU Active Time and GPU Time each compared against the target), [Garbage collector overview](../reference/performance/manual-performance-garbage-collector.md) ("ideally to 0 bytes per frame"), [Memory in Unity Web](../reference/performance/manual-webgl-memory.md), [Memory profiling how-to](../reference/performance/how-to-use-memory-profiling-unity.md) (budget ≈ 80 % of lowest-spec RAM).

### 1.2 Workflow: profile, change, compare

**MUST** follow the three-point procedure: profile *before* a change to establish a baseline, profile *during* to keep within budget, profile *after* to prove the change worked. Save the Profiler `.data` capture before optimizing and compare it with the Profile Analyzer **Compare** view afterwards.
- *Why:* Guessing optimizes the wrong thing; some "optimizations" make things worse.
- *Source:* [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) · [Profile Analyzer how-to](../reference/performance/how-to-optimize-your-game-unity-profile-analyzer.md)

**MUST** profile a **Development Build** on the target machine for any number you report; Editor Play-mode profiling is for quick iteration only (Editor overhead, `GetComponent` allocates in the Editor but not in a build, textures are Read/Write in the Editor).
- *Source:* [Collect performance data on a target platform](../reference/performance/manual-profiling-target-device.md) · [Tracking GC allocations](../reference/performance/manual-performance-track-garbage-collection.md)

**SHOULD** go top-down: start with the Highlights and CPU modules to find the biggest marker, then drill in. Enable **Call Stacks** in the Profiler toolbar to find allocation sources; use **Deep Profile** only when call stacks are not enough, and never trust relative timings from a deep-profile capture.
- *Source:* [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) (Deep profiling tips) · [PC/console optimization e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md)

**SHOULD** disable VSync (**Project Settings > Quality > VSync Count = Don't Sync**) in the profiling build so `WaitForTargetFPS` does not hide where the time goes; re-enable it for release.
- *Source:* [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) (Unity Profiler tips)

### 1.3 Tools and when to use each

| Question | Tool | Where |
|---|---|---|
| Are we in budget? CPU- or GPU-bound? | Profiler **Highlights** + **CPU** Timeline | Window > Analysis > Profiler; enable the Highlights module |
| Which script/system is slow? | CPU **Hierarchy** sorted by Time ms, our `ProfilerMarker`s | Profiler CPU module |
| Who allocates? | CPU Hierarchy sorted by **GC.Alloc** with **Call Stacks** on; Memory module "GC allocated in frame" | Profiler |
| Did my change help? | **Profile Analyzer** Compare view (before/after `.data`) | Window > Analysis > Profile Analyzer (package) |
| Why so many draw calls / why no batching? | **Frame Debugger** (shows batch-break reasons) | Window > Analysis > Frame Debugger |
| Overdraw, lighting complexity | **Rendering Debugger** | Window > Analysis > Rendering Debugger (Ctrl+Backspace in Play mode / dev build) |
| Memory leaks / what eats RAM? | **Memory Profiler** snapshots, Compare mode | Window > Analysis > Memory Profiler (package 1.1) |
| Physics pairs that should not exist | **Physics Debugger** | Window > Analysis > Physics Debugger |
| Quick sanity during Play | **Stats** overlay (Batches, SetPass, Tris) | Game view > Stats |
| Project-wide static issues | **Project Auditor** | package; run before the submission build |

- *Source:* [Profiler introduction](../reference/performance/manual-profiler-introduction.md) · [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) · [Frame Debugger](../reference/performance/manual-framedebugger.md) · [Rendering Statistics](../reference/performance/manual-renderingstatistics.md) · [Enhanced physics performance](../reference/performance/how-to-enhanced-physics-performance-smooth-gameplay.md)

### 1.4 Reading a capture: CPU-bound or GPU-bound

| Marker you see | Meaning | Next step |
|---|---|---|
| `WaitForTargetFPS` on main thread, gray idle on render/worker threads | In budget; idle time | Done — run the Memory Profiler to confirm memory budget |
| Main thread busy the whole frame, no wait marker | **CPU-bound, main thread** | Look at `BehaviourUpdate`, `Physics.FixedUpdate`/`Physics.Processing`, `LateBehaviourUpdate`, `Animators`, UI, camera culling, `GC.Alloc` (magenta) |
| Main thread in `Gfx.WaitForPresentOnGfxThread`, render thread in `Camera.Render` | **CPU-bound, render thread** | Too many draw calls / cameras / poor culling → Frame Debugger, section 6 |
| Main thread in `Gfx.WaitForPresentOnGfxThread`, render thread in `Gfx.PresentFrame` or `<API>.WaitForLastPresent` | **GPU-bound** | Post-processing, fragment shaders, overdraw, resolution, micro-triangles, uncompressed textures → section 6 |
| `Gfx.WaitForCommands` on render thread | Render thread starved → main-thread bottleneck | As CPU-bound main thread |
| `WaitForJobGroupID` / `JobHandle.Complete` on main thread | Sync point waiting for jobs | Schedule earlier, need results later |
| `GC.Collect` | Garbage collection ran | Find and remove the allocations that filled the heap |

- *Source:* [Best practices for profiling game performance](../reference/performance/how-to-best-practices-for-profiling-game-performance.md) · [Profiler markers reference](../reference/performance/manual-profiler-markers.md) · [Analyzing Profiler traces](../reference/performance/manual-performance-profiler-traces.md)

### 1.5 Cadence and machines **[project decision]**

- The **min-spec machine** is the weakest laptop on the team; write its CPU/GPU/RAM in `docs/` and profile on it. Unity recommends establishing the lowest spec per platform and optimizing for it.
- Profile a Development Build on the min-spec machine **once per jam day** and **before every submission build**; profile in the Editor whenever you touch a per-frame system and check your markers' `GC.Alloc` column is 0 before pushing.
- Do **not** commit Profiler `.data` captures or Memory Profiler snapshots; attach them to the PR or chat if a reviewer needs them.
- *Source:* [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) (hardware tiers, profile early and often)

### 1.6 Profiler markers in our code

**SHOULD** add a `ProfilerMarker` around every system that does real work each frame (AI, flocking, procedural updates, custom managers). Declare it `static readonly` (named `k_PascalCase` per [01](./01-csharp-style.md)), name the marker `RootsDance.<System>.<Phase>`, never put `/` in the name, and do not `await`/`yield` inside the marked scope. `Begin`/`End` compile out of release builds; `Auto()` returns null in release with minimal overhead.

Examples below use `RootsDance.Enemies` and `RootsDance.Combat` as placeholder feature namespaces; a real feature folder is added under `Scripts/Runtime/<Feature>/` per [02](./02-project-structure.md) before such a namespace is used.

```csharp
using Unity.Profiling;
using UnityEngine;

namespace RootsDance.Enemies
{
    public class FlockingSystem : MonoBehaviour
    {
        private static readonly ProfilerMarker k_UpdateMarker = new ProfilerMarker("RootsDance.Flocking.Update");

        private void Update()
        {
            using (k_UpdateMarker.Auto())
            {
                StepFlock();
            }
        }

        private void StepFlock()
        {
            // ...
        }
    }
}
```

- *Why:* Named markers give deep-profile-level detail for your code at ~10 ns per marker instead of instrumenting every call.
- *Source:* [Adding profiler markers to your code](../reference/performance/manual-profiler-add-markers-code.md) · [ProfilerMarker API](../reference/performance/scriptref-unity-profiling-profilermarker.md)

**MAY** add `[Performance]` tests with `Measure.Method(...).WarmupCount(n).MeasurementCount(n).Run()` from the Performance Testing package for pure-logic hot paths; not required for the jam.
- *Source:* [Performance Testing: writing tests](../reference/performance/test-framework-performance-3-5-writing-tests.md)

## 2. Per-frame code hygiene

Event-function semantics (what belongs in `Update` vs `FixedUpdate`, coroutine vs `Awaitable`) are owned by [04 Unity scripting rules](./04-unity-scripting-rules.md). This section is only about cost.

**MUST** move logic out of `Update`/`LateUpdate`/`FixedUpdate` when it does not need to run every frame; run on change, or time-slice with `Time.frameCount % n` (better: 1/n of the work each frame).
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Minimize code that runs every frame)

**MUST** cache component and object references in `Awake`/`Start` and reuse them; `GetComponent`, `GameObject.Find`, `FindFirstObjectByType` and `Camera.main` are no longer catastrophically slow, but they still do not belong in a per-frame method. Use `TryGetComponent` for optional lookups. Gameplay code wires references through serialized fields or `GetComponent` instead of looking them up ([03](./03-architecture-patterns.md)); `FindFirstObjectByType`/`GameObject.Find` are for bootstrap, tests and editor tooling only ([04](./04-unity-scripting-rules.md#finding-objects-and-accessing-components)).
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Cache the results of expensive functions) · [Component.TryGetComponent](../reference/scripting/scriptref-component-trygetcomponent.md)

**MUST** remove empty `Update`/`LateUpdate`/`FixedUpdate` methods; each one costs an interop call per frame even when empty.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Avoid empty Unity event functions)

**MUST** cache property ids: `Shader.PropertyToID("_BaseColor")` for material/shader properties and `Animator.StringToHash("Speed")` for animator parameters, stored in `private static readonly int k_PascalCase` fields (e.g. `k_SpeedHash`, per [01](./01-csharp-style.md)), and call the int-valued `Set`/`Get` overloads. `CompareTag("Player")` instead of `tag == "Player"`.
- *Why:* The string overloads hash the string every call and `GameObject.tag` returns a new string (garbage).
- *Source:* [Shader.PropertyToID](../reference/scripting/scriptref-shader-propertytoid.md) · [Animator.StringToHash](../reference/scripting/scriptref-animator-stringtohash.md) · [GameObject.CompareTag](../reference/scripting/scriptref-gameobject-comparetag.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Use hash values instead of string parameters)

```csharp
using UnityEngine;

namespace RootsDance.Player
{
    [RequireComponent(typeof(Animator))]
    public class PlayerAnimationDriver : MonoBehaviour
    {
        private static readonly int k_SpeedHash = Animator.StringToHash("Speed");
        private static readonly int k_IsGroundedHash = Animator.StringToHash("IsGrounded");

        private Animator m_animator;

        private void Awake()
        {
            m_animator = GetComponent<Animator>();
        }

        public void Apply(float speed, bool isGrounded)
        {
            m_animator.SetFloat(k_SpeedHash, speed);
            m_animator.SetBool(k_IsGroundedHash, isGrounded);
        }
    }
}
```

**NEVER** allocate in per-frame code. The usual culprits and their replacements:

| ❌ Allocates | ✅ Use instead |
|---|---|
| `"Score: " + score`, `$"{hp}"` every frame | Update text only when the value changes; `StringBuilder` with preset `Capacity` for real string building |
| LINQ (`Where`, `ToList`, `OrderBy`) and `Regex` in hot paths | `for` loops over `List<T>`/arrays |
| Lambda/delegate that captures a local or `this` | Method group on a cached delegate, or pass state explicitly |
| `params` overloads (`string.Format`, `Debug.LogFormat`) | Fixed-arity overloads; `RootsDance.Core.Log` ([04](./04-unity-scripting-rules.md#logging)) |
| `new List<T>()` / `new T[n]` inside `Update` | Field initialised once; `Clear()` each frame; `ListPool<T>.Get`/`Release` for temporaries |
| Boxing: passing `int`/`float`/struct as `object`, non-generic collections, `Equals(object)` | Generic overloads, `IEquatable<T>`, typed collections |
| `mesh.vertices`, `renderer.sharedMaterials` read inside a loop (every array-valued Unity property returns a new copy) | `Mesh.GetVertices(list)`, `Renderer.GetSharedMaterials(list)`; hoist array-valued property reads out of loops |
| `Physics.RaycastAll`, `OverlapSphere` | `Physics.RaycastNonAlloc`, `OverlapSphereNonAlloc` with a pre-allocated buffer (section 5) |
| `yield return new WaitForSeconds(1f)` | Cache the `WaitForSeconds` in a field; prefer `Awaitable` (pooled, minimal allocation) |
| Returning a fresh empty array | `System.Array.Empty<T>()` / a static zero-length instance |

- *Source:* [Reference type management](../reference/performance/manual-performance-reference-types.md) · [Optimizing arrays](../reference/performance/manual-performance-optimizing-arrays.md) · [Pooling and reusing objects](../reference/performance/manual-performance-reusable-code.md) · [ListPool](../reference/performance/scriptref-pool-listpool-1.md) · [Awaitable introduction](../reference/scripting/manual-async-awaitable-introduction.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Reduce the impact of GC)

```csharp
// ❌ Allocates every frame: LINQ, new list, string concat, FindObjectsByType array.
private void Update()
{
    var enemies = FindObjectsByType<Enemy>(FindObjectsSortMode.None)
        .Where(e => Vector3.Distance(e.transform.position, transform.position) < m_radius)
        .ToList();
    m_label.text = "Enemies: " + enemies.Count;
}

// ✅ Zero allocations: non-alloc query into a reused buffer, text updated only on change.
// (m_label is a TMPro.TextMeshProUGUI, m_enemyMask a serialized LayerMask.)
private readonly Collider[] m_overlapBuffer = new Collider[32];
private int m_lastCount = -1;

private void Update()
{
    int count = Physics.OverlapSphereNonAlloc(transform.position, m_radius, m_overlapBuffer, m_enemyMask, QueryTriggerInteraction.Ignore);
    if (count != m_lastCount)
    {
        m_lastCount = count;
        m_label.text = count.ToString();
    }
}
```

**NEVER** call `Debug.Log*` (or `Debug.DrawLine`/`DrawRay`) in per-frame paths of shipped code. Dev-only logging goes through `RootsDance.Core.Log` — `Info`/`Warning` compile out of release builds via `[Conditional("UNITY_EDITOR")]` / `[Conditional("DEVELOPMENT_BUILD")]` (the call *and its argument evaluation* disappear), no custom define symbols; the wrapper and its rules are owned by [04 Unity scripting rules — Logging](./04-unity-scripting-rules.md#logging). Set **Player > Stack Trace > Log = None** for release (section 9).
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Remove Debug Log statements, Disable Stack Trace logging)

**SHOULD** keep coroutines few and flat: each running coroutine is a heap object; a coroutine that runs every frame without waiting on anything is an `Update` in disguise. `Awaitable` is the project default for async work (see [04](./04-unity-scripting-rules.md)); its instances are pooled, so calling an `Awaitable`-returning method usually does not allocate.
- *Source:* [Analyzing coroutines](../reference/performance/manual-coroutines-analyzing.md)

**SHOULD** use `Transform.SetPositionAndRotation` instead of setting position then rotation, and `Instantiate(prefab, position, rotation, parent)` (the `Object.Instantiate(Object original, Vector3 position, Quaternion rotation, Transform parent)` overload) instead of instantiate-then-reparent-then-move. Keep transform hierarchies shallow: deep hierarchies serialise transform updates and cost more GC.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Transform once, not twice; Avoid large hierarchies — the e-book prints the `Instantiate` arguments in the wrong order; the signature above is from the 6000.3 bindings: [UnityEngine.Object bindings](../reference/scripting/github-unitycsreference-unityengineobject-bindings-cs.md))

**SHOULD** avoid `AddComponent` at runtime; instantiate a prefab that already has the components. Store shared static data in ScriptableObjects, not on every instance.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Avoid adding components at runtime; Use ScriptableObjects)

**SHOULD** keep `Awake`/`Start`/`OnEnable` light in the first scene; heavy work there delays the first frame. Do it after the first frame or behind a loading screen.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Avoid heavy logic in Start/Awake) · [Analyzing Profiler traces](../reference/performance/manual-performance-profiler-traces.md)

## 3. Managed memory and garbage collection

**MUST** leave **Incremental GC** enabled (**Project Settings > Player > Configuration**, the default). It does not make collection faster, it spreads it over frames and uses idle time at the end of VSync'd frames. It is **not supported on Web** — there the GC runs only at the end of a frame, so allocation-free gameplay code matters even more.
- *Source:* [Garbage collection modes](../reference/performance/manual-performance-incremental-garbage-collection.md) · [Memory in Unity Web](../reference/performance/manual-webgl-memory.md)

**NEVER** call `System.GC.Collect()` or change `GarbageCollector.GCMode` during gameplay. **MAY** call `System.GC.Collect()` once in the scene-transition flow (after unloading the old content scene, before the new one finishes loading), where a spike is invisible **[project decision]**.
- *Why:* A full collection stops the main thread for up to hundreds of milliseconds; hidden behind a load it costs nothing.
- *Source:* [Garbage collection modes](../reference/performance/manual-performance-incremental-garbage-collection.md) (Manual garbage collection) · [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) (Time garbage collection whenever possible)

**MUST** treat any non-zero `GC.Alloc` in a steady-state gameplay frame as a bug. 1 KB per frame at 60 fps is 3.6 MB per minute and a guaranteed `GC.Collect` spike. Find the source with Call Stacks (section 1.2) and fix it with the table in section 2.
- *Source:* [Garbage collector overview](../reference/performance/manual-performance-garbage-collector.md) · [Tracking GC allocations](../reference/performance/manual-performance-track-garbage-collection.md)

**SHOULD** keep large data in value types / `NativeArray<T>` rather than huge managed arrays (> 10 000 reference-sized elements), which the non-generational, non-compacting Boehm GC has to scan.
- *Source:* [Optimizing arrays](../reference/performance/manual-performance-optimizing-arrays.md) (native containers)

**SHOULD** avoid parsing JSON/XML at runtime for gameplay data; use ScriptableObjects. On Web, avoid any loop that grows a string or array element by element (quadratic temporary memory); pre-size with `StringBuilder.Capacity` / `List<T>` capacity.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Strings) · [Memory in Unity Web](../reference/performance/manual-webgl-memory.md)

**MUST** take a Memory Profiler snapshot on the min-spec machine before the submission build, and compare two snapshots (before/after a scene round-trip) to catch leaks: objects from an unloaded scene still alive mean a lingering reference (static event, singleton list, pooled instance not released).
- *Source:* [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) (Locating memory leaks)

## 4. Object pooling

**MUST** pool objects that are created and destroyed repeatedly during gameplay — projectiles, hit VFX, particle bursts, audio one-shots, pickups, damage numbers, UI list rows. Use `UnityEngine.Pool.ObjectPool<T>` (project decision 10); do not write a custom pool.
- *Why:* `Instantiate`/`Destroy` allocate, deserialise and fragment the heap; GC spikes follow.
- *Source:* [Pooling and reusing objects](../reference/performance/manual-performance-reusable-code.md) · [Object pooling tutorial](../reference/performance/tutorial-use-object-pooling-to-boost-performance-of-c-scripts-in-unity.md)

Pool rules:
- Construct the pool in `Awake` with `collectionCheck: true` (Editor-only double-release check, free in builds), a `defaultCapacity` matching the expected concurrent count and a `maxSize` cap.
- `actionOnGet` activates and resets; `actionOnRelease` deactivates (so the object stops receiving `Update`), stops coroutines/particles, unsubscribes events, zeroes `Rigidbody.linearVelocity`/`angularVelocity`.
- Give the pooled object a reference to its pool so it can release itself; never hold long-lived references to inactive pooled instances.
- Pools die with their scene. If a pool must survive a content-scene swap, parent it under the bootstrap scene's persistent root; release active instances in `OnDisable`/`OnDestroy`; call `Clear()` between levels.
- Use `ListPool<T>` / `HashSetPool<T>` / `DictionaryPool<TKey, TValue>` for temporary collections in hot paths.
- *Source:* [ObjectPool<T> constructor](../reference/performance/scriptref-pool-objectpool-1-ctor.md) · [Pooling and reusing objects](../reference/performance/manual-performance-reusable-code.md)

```csharp
// ProjectilePool.cs
using UnityEngine;
using UnityEngine.Pool;

namespace RootsDance.Combat
{
    public class ProjectilePool : MonoBehaviour
    {
        [SerializeField] private Projectile m_projectilePrefab;
        [SerializeField] private int m_defaultCapacity = 20;
        [SerializeField] private int m_maxSize = 100;

        private IObjectPool<Projectile> m_pool;

        private void Awake()
        {
            m_pool = new ObjectPool<Projectile>(
                CreateProjectile, OnGetFromPool, OnReleaseToPool, OnDestroyPooledObject,
                true, m_defaultCapacity, m_maxSize);
        }

        public Projectile Spawn(Vector3 position, Quaternion rotation)
        {
            Projectile projectile = m_pool.Get();
            projectile.transform.SetPositionAndRotation(position, rotation);
            return projectile;
        }

        private Projectile CreateProjectile()
        {
            Projectile projectile = Instantiate(m_projectilePrefab, transform);
            projectile.Pool = m_pool;
            return projectile;
        }

        private void OnGetFromPool(Projectile projectile)
        {
            projectile.gameObject.SetActive(true);
        }

        private void OnReleaseToPool(Projectile projectile)
        {
            projectile.gameObject.SetActive(false);
        }

        private void OnDestroyPooledObject(Projectile projectile)
        {
            Destroy(projectile.gameObject);
        }
    }
}
```

```csharp
// Projectile.cs
using UnityEngine;
using UnityEngine.Pool;

namespace RootsDance.Combat
{
    [RequireComponent(typeof(Rigidbody))]
    public class Projectile : MonoBehaviour
    {
        [SerializeField] private float m_lifetime = 3f;

        private Rigidbody m_rigidbody;
        private float m_age;

        public IObjectPool<Projectile> Pool { get; set; }

        private void Awake()
        {
            m_rigidbody = GetComponent<Rigidbody>();
        }

        private void OnEnable()
        {
            m_age = 0f;
        }

        private void Update()
        {
            m_age += Time.deltaTime;
            if (m_age >= m_lifetime)
            {
                ReturnToPool();
            }
        }

        private void OnCollisionEnter(Collision collision)
        {
            ReturnToPool();
        }

        private void ReturnToPool()
        {
            m_rigidbody.linearVelocity = Vector3.zero;
            m_rigidbody.angularVelocity = Vector3.zero;
            Pool.Release(this);
        }
    }
}
```

## 5. Physics

Project Settings are shared; change them once, in a dedicated commit, and say so in the PR. Values below are the settled defaults for this project.

| Setting (Edit > Project Settings) | Value | Rule |
|---|---|---|
| Time > Fixed Timestep | 0.02 (50 Hz, default) | **MUST** keep unless profiling shows physics is the bottleneck; lowering the rate makes tunneling more likely |
| Time > Maximum Allowed Timestep | 0.1 s **[project decision]** | **SHOULD** — caps how many physics steps one slow frame can trigger (the "spiral of doom"), at the cost of physics appearing to slow down during a hitch |
| Physics > Settings > Shared > Layer Collision Matrix | as configured in [09 — Layers and the collision matrix](./09-packages-systems.md#layers-and-the-collision-matrix) | 09 owns the project layers and the matrix; do not change or restate them here. Every unticked pair is simulation time saved |
| Physics > Settings > GameObject > Reuse Collision Callbacks | enabled (default) | **MUST** keep; `Collision` objects are reused — do not cache the `Collision` argument beyond the callback |
| Physics > Settings > GameObject > Auto Sync Transforms | disabled (default) | **MUST** keep; call `Physics.SyncTransforms()` once before a query that must see a transform you just changed |
| Physics > Settings > Default Solver Iterations | default | Raise `Rigidbody.solverIterations` per body that needs it, not globally |
| Physics > Broadphase Type | Sweep and Prune (default) | **MAY** switch to Automatic Box Pruning only for a large, flat world with many colliders |
| Player > Other Settings > Optimization > Prebake Collision Meshes | **enabled** | **MUST** tick it (the sources say "check whenever possible"; verify in `ProjectSettings/ProjectSettings.asset`) — avoids mesh-cooking spikes at scene load |

- *Source:* [Set fixed timestep](../reference/performance/manual-physics-optimization-cpu-frequency.md) · [Layer collision matrix](../reference/performance/manual-physics-optimization-cpu-collision-layers.md) · [Optimize collision callbacks](../reference/performance/manual-physics-optimization-collision-callbacks.md) · [Optimize transform value syncing](../reference/performance/manual-physics-optimization-cpu-transform-sync.md) · [Collider types and performance](../reference/performance/manual-physics-optimization-cpu-collider-types.md) · [Enhanced physics performance](../reference/performance/how-to-enhanced-physics-performance-smooth-gameplay.md)

**MUST** choose colliders by cost: Sphere < Capsule < Box < convex Mesh < non-convex Mesh. Dynamic bodies get primitives or a compound of a few primitives; convex Mesh Colliders only when primitives cannot approximate the shape; non-convex Mesh Colliders only on static geometry. Characters: one capsule.
- *Source:* [Collider types and performance](../reference/performance/manual-physics-optimization-cpu-collider-types.md)

**MUST** use non-allocating queries with a pre-allocated buffer, a serialized `LayerMask`, an explicit `QueryTriggerInteraction` (normally `Ignore`, per [09](./09-packages-systems.md#raycasts-and-queries)) and the shortest max distance that works. Size the buffer for the realistic maximum; extra hits beyond its length are silently dropped. Batch large numbers of rays with `RaycastCommand.ScheduleBatch` only if profiling shows query cost (not needed for a handful of rays).
- *Source:* [Optimize raycasts and other physics queries](../reference/performance/manual-physics-optimization-raycasts-queries.md) · [Physics.RaycastNonAlloc](../reference/performance/scriptref-physics-raycastnonalloc.md) · [Physics.OverlapSphereNonAlloc](../reference/scripting/scriptref-physics-overlapspherenonalloc.md)

```csharp
[SerializeField] private LayerMask m_groundMask;
private readonly RaycastHit[] m_groundHits = new RaycastHit[4];

private bool IsGrounded()
{
    int hitCount = Physics.RaycastNonAlloc(transform.position, Vector3.down, m_groundHits, 1.1f, m_groundMask, QueryTriggerInteraction.Ignore);
    return hitCount > 0;
}
```

**NEVER** move a static collider (Collider without Rigidbody) every frame by editing its Transform; give moving geometry a **kinematic Rigidbody** and move it with `Rigidbody.MovePosition`/`position` (see [04](./04-unity-scripting-rules.md)). Do not add a Rigidbody to something only to move it once.
- *Source:* [Move static colliders](../reference/performance/manual-physics-optimization-cpu-static-colliders.md)

**SHOULD** let bodies sleep: keep the default Sleep Threshold, never call `Rigidbody.WakeUp` in a loop, and use the Physics Debugger to spot bodies that never settle (tiny persistent contacts).
- *Source:* [Rigidbody sleeping](../reference/performance/manual-physics-optimization-cpu-rigidbody-sleeping.md)

**SHOULD** prefer `OnTriggerEnter`/`OnCollisionEnter` over `OnTriggerStay`/`OnCollisionStay` loops; `Stay` callbacks fire every physics step for every pair and show up under `Physics.ProcessReports`.
- *Source:* [Profiler markers reference](../reference/performance/manual-profiler-markers.md) · [Analyzing Profiler traces](../reference/performance/manual-performance-profiler-traces.md)

## 6. Rendering

HDRP asset, global settings, Frame Settings and lighting setup are configured per [07 Rendering and HDRP](./07-rendering-hdrp.md). The rules below say which knobs performance depends on and when to turn them.

### 6.1 Draw calls and batching

The draw-call strategy for this project **[project decision — the GPU Resident Drawer, which the manual recommends enabling, stays off until a profile justifies it]**:

| Feature | State | Rule |
|---|---|---|
| SRP Batcher | **always on** | HDRP has no SRP Batcher checkbox — it is part of the pipeline and cannot be turned off. Use `HDRP/Lit`, `HDRP/Unlit` and HDRP-target Shader Graph materials only (all SRP-Batcher compatible); check a hand-written shader's "SRP Batcher: compatible" line in the Inspector |
| GPU Instancing checkbox on materials | **off** | **NEVER** tick it — extra shader variants, and it is not how HDRP instances |
| Static Batching (Player Settings) | on (Unity default) | Mark non-moving environment **Batching Static**; disable Static Batching only when the GPU Resident Drawer is enabled |
| Dynamic Batching | **off** | **NEVER** — CPU cost of finding ≤ 300-vertex meshes outweighs a modern draw call |
| GPU Resident Drawer (HDRP asset > **Rendering** > **GPU Resident Drawer** = **Instanced Drawing**) | **off by default** | **MAY** enable when the Profiler shows a render-thread/draw-call-bound frame *and* the scene has many instances of the same mesh. Prerequisites: **Project Settings > Graphics > Shader Stripping > BatchRendererGroup Variants = Keep All**, Mesh Renderers only, a compute-shader-capable graphics API; then disable Static Batching. Builds get slower (all BRG variants compile) |
| GPU Occlusion Culling (HDRP asset > **Rendering**) | off | Only together with the GPU Resident Drawer, in scenes with a lot of occlusion; can cost more than it saves otherwise |
| `MaterialPropertyBlock` | **never** | Breaks SRP Batcher and GPU Resident Drawer batching; rule and the Material Variants alternative are in [07 §9.2](./07-rendering-hdrp.md#92-srp-batcher-compatibility) |

- *Source:* [Choose a method for optimizing draw calls](../reference/performance/manual-optimizing-draw-calls-choose-method.md) · [Batching meshes](../reference/performance/manual-drawcallbatching.md) · [GPU instancing](../reference/performance/manual-gpuinstancing.md) · [Scriptable Render Pipeline Batcher (HDRP)](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-srpbatcher.md) · [Use the GPU Resident Drawer (HDRP)](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-gpu-resident-drawer.md) · [HDRP Asset reference — Rendering section](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md)

**MUST** share materials: few textures (atlas where practical), few shaders, many materials is fine with the SRP Batcher. **NEVER** read `Renderer.material` on a scene object — it silently clones the material and breaks the batch; read `Renderer.sharedMaterial`. Tinting a single instance is a design question: prefer a Material Variant asset or a shader that reads vertex colour (SRP-Batcher compatibility rules: [07 §9.2](./07-rendering-hdrp.md#92-srp-batcher-compatibility)).
- *Source:* [Managing GPU usage for PC and console](../reference/performance/how-to-gpu-optimization.md) · [Mobile/XR/Web e-book](../reference/performance/ebook-optimize-your-game-performance-for-mobile-xr-and-the-web-in-unity-unit.md) (Be careful with Renderer.material)

**MUST** check the Frame Debugger when the Stats overlay exceeds the thresholds in 1.1; it tells you *why* a draw call could not be batched with the previous one. Keep shader keyword/variant count low — every variant change breaks an SRP batch.
- *Source:* [Ultimate guide to profiling](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) (Frame Debugger) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Use draw call batching)

### 6.2 Cameras and culling

**MUST** keep exactly one active Unity `Camera` — the rule lives in [09](./09-packages-systems.md) (camera conventions) and [11](./11-scenes-prefabs-workflow.md) (scene contents); this section only explains the cost: every enabled `Camera` runs culling, sorting and batching (one full render per camera in the Profiler). HDRP has no camera stacking at all — a second enabled camera is a second complete frame — so never add one "just for the weapon/UI"; overlays go on the Screen Space – Overlay canvas or through a Custom Pass ([07 §4](./07-rendering-hdrp.md#4-custom-rendering-custom-passes-and-custom-post-process)).
- *Source:* [Best practices for profiling](../reference/performance/how-to-best-practices-for-profiling-game-performance.md) (five cameras example) · [Managing GPU usage](../reference/performance/how-to-gpu-optimization.md) (Check multiple Camera views)

**SHOULD** set a tight far clip plane and `Camera.layerCullDistances` for small-object layers (props, debris) so they cull before the far plane.
- *Source:* [Reduce rendering work on the CPU or GPU](../reference/performance/manual-optimizinggraphicsperformance.md)

**MAY** bake CPU occlusion culling (**Window > Rendering > Occlusion Culling**, static flags Occluder/Occludee) only for indoor, room-and-corridor levels that are GPU-bound by overdraw; profile before and after — it costs CPU and memory and is useless in open scenes or with runtime-generated geometry.
- *Source:* [Occlusion culling](../reference/performance/manual-occlusionculling.md) · [Static GameObjects](../reference/performance/manual-staticobjects.md)

### 6.3 LOD and geometry

**SHOULD** enable **Generate Mesh LODs** in the Model import settings for character and dynamic-prop meshes above roughly 10k triangles **[project decision threshold]**; environment meshes that are **Batching Static** get no benefit (LOD0 always) — enable Mesh LOD on them only if Static Batching is off because the GPU Resident Drawer is on. It needs no extra GameObjects or DCC work. Use a hand-authored **LOD Group** only when a lower LOD must also drop materials/renderers. Do not combine both on one object.
- *Caveats:* Mesh LOD always renders LOD0 for statically-batched meshes, GPU-instanced draws, particles and VFX Graph; cross-fade needs the GPU Resident Drawer; skinned meshes still deform LOD0.
- *Source:* [Introduction to level of detail](../reference/performance/manual-levelofdetail.md) · [Introduction to Mesh LOD](../reference/performance/manual-mesh-lod-introduction.md) · [Model import settings](../reference/performance/manual-fbximporter-model.md)

**SHOULD** keep polygon *density* low: micro-triangles (dense distant meshes) hurt the GPU more than total triangle count. Delete faces the camera never sees; bake detail into normal maps.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Check your polygon counts)

### 6.4 Lights, shadows, post-processing budget

Per-scene lighting, shadow and post-processing budgets (lights visible at once, shadow-casting lights, cascades, baked reflection probes, the allowed Volume overrides) are owned by [07 §11 Render budgets](./07-rendering-hdrp.md#11-render-budgets), [07 §5 Lighting workflow](./07-rendering-hdrp.md#5-lighting-workflow) and [07 §6 Post-processing](./07-rendering-hdrp.md#6-post-processing-via-volumes); do not tune them here. Why they matter for the GPU in HDRP: every shadow-casting light rents space in a shared **shadow atlas** sized on the HDRP asset — a point light takes six tiles (a spot light one), and when the atlas overflows HDRP drops or rescales shadows instead of getting slower, so the symptom is visual, not a frame spike; every extra cascade adds shadow draw calls; **volumetric fog and volumetric lighting are a fixed-cost froxel pass** that scales with the volumetric quality setting, not with content, so turning it on is a budget decision made once in 07, not per scene; a realtime reflection probe re-renders six cubemap faces; fullscreen post effects are the usual GPU bottleneck; baked light (APV per 07) is free at runtime; `Mesh Renderer > Cast Shadows = Off` on small props removes shadow casters.

- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Common lighting optimizations, Profile post-processing) · [Shadows in HDRP (shadow atlas)](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md) · [Volumetric lighting](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md) · [Shadow cascades performance](../reference/performance/manual-shadow-cascades-performance.md) · [Optimize reflections](../reference/performance/manual-refprobeperformance.md)

**SHOULD** treat overdraw as the first GPU suspect: overlapping transparent particles, UI and foliage. Check with the Rendering Debugger; reduce particle counts and alpha-blended layers before touching shaders.
- *Source:* [Reduce rendering work on the CPU or GPU](../reference/performance/manual-optimizinggraphicsperformance.md) · [Mobile/XR/Web e-book](../reference/performance/ebook-optimize-your-game-performance-for-mobile-xr-and-the-web-in-unity-unit.md) (Minimize overdraw)

**SHOULD** keep Shader Graphs lean when GPU-bound: remove unused nodes, use `half` where precision allows, combine scalar maths before vector ops, bake constants into textures, avoid branches; keep keyword variants to a minimum.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Optimize Shader Graph)

### 6.5 Frame pacing

**MUST** ship desktop builds with **VSync Count = Every V Blank** and leave `Application.targetFrameRate` untouched; Unity recommends `vSyncCount` over `targetFrameRate` on desktop because the latter micro-stutters. Do not hard-code an assumed refresh rate anywhere.
- *Source:* [Application.targetFrameRate](../reference/performance/scriptref-application-targetframerate.md) · [QualitySettings.vSyncCount](../reference/performance/scriptref-qualitysettings-vsynccount.md)

**MAY** lower `Application.targetFrameRate` (desktop with VSync off) or use `OnDemandRendering` in static fullscreen menus; also disable the 3D camera when a fullscreen UI covers it.
- *Source:* [Reduce rendering work on the CPU or GPU](../reference/performance/manual-optimizinggraphicsperformance.md) (Reducing the frequency of rendering) · [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md)

## 7. Assets: import settings

Don't rely on defaults for every asset; the import settings below are the project baseline. Apply them with **Presets** stored under `Assets/RootsDance/Settings/Presets/` **[project decision]** so new assets start correct (folder layout per [02 Project structure](./02-project-structure.md)).
- *Source:* [Configuring your Unity project for stronger performance](../reference/performance/how-to-project-configuration-and-assets.md)

### 7.1 Textures

Rendering-side import rules (sRGB, normal-map type, POT, Read/Write off, mipmaps on for 3D / off for UI) are owned by [07 §10](./07-rendering-hdrp.md#10-texture-import-settings-that-affect-rendering); the performance-specific settings are:

| Setting | Value | Why |
|---|---|---|
| Max Size | 2048 environment/character/hero, 1024 props, 512 UI icons **[project decision]**; never 4096 without a profile | Non-destructive, fastest memory win |
| Compression / Format (desktop) | Automatic, Normal quality → DXT1 for RGB, BC7 (or DXT5) for RGBA, BC6H for HDR | ¼ – ⅛ of uncompressed memory and bandwidth |
| Mipmap Streaming (texture Import Settings > Advanced > Streaming Mipmaps) | on for large world textures, with **Quality > Textures > Mipmap Streaming** enabled | Only loads needed mip levels |

Max Size is **derived, not typed in**, for every texture the pipeline owns — `Textures/**` named
`<Asset>_<Map>` — where `TexturePipelinePostprocessor` sets it to the source file's own authored
width, clamped to the 2048 ceiling ([02 §12](./02-project-structure.md#12-import-settings-are-applied-by-script-not-by-hand)).
The tiers above are therefore an **authoring** budget: shrink the exported file, do not hand-set
Max Size in the Inspector. A committed `.meta` that disagrees with the authored width is drift —
the importer rewrites it on the next reimport and the file churns for every teammate.

- *Source:* [Choose a GPU texture format by platform](../reference/performance/manual-texture-choose-format-by-platform.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Texture import settings, Stream mipmaps) · [Mipmap streaming](../reference/performance/manual-texturestreaming.md) · [Quality settings reference](../reference/performance/manual-class-qualitysettings.md) (Textures > Mipmap Streaming)

### 7.2 Meshes (Model import settings)

| Setting | Value |
|---|---|
| Read/Write | **off** (default) unless a script reads vertices |
| Optimize Mesh | Everything (default) |
| Mesh Compression | Off during the jam; it only shrinks disk size, not runtime memory, and can introduce quantisation artefacts **[project decision]** |
| Index Format | Auto |
| Normals / Tangents | Import; set Tangents = None for meshes with no normal map |
| Import BlendShapes / Rig | off when the mesh is not animated / has no blend shapes |
| Generate Mesh LODs | see 6.3 |
| Generate Colliders | off; add primitive colliders on the prefab instead |
| Scale | 1 unit = 1 m (Convert Units) |

- *Source:* [Model import settings](../reference/performance/manual-fbximporter-model.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Mesh import settings)

**SHOULD** enable **Player > Optimize Mesh Data** so vertex streams the material never reads are stripped from the build.
- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Other mesh optimizations)

### 7.3 Audio

| Clip | Load Type | Compression | Notes |
|---|---|---|---|
| Short SFX < 200 KB (footsteps, hits, UI) | Decompress On Load | PCM or ADPCM | cheapest at runtime |
| Medium ≥ 200 KB (dialogue, stingers) | Compressed In Memory (memory priority) or Decompress On Load (CPU priority) | Vorbis | |
| Music / ambience > 350–400 KB | Streaming | Vorbis | ~200 KB overhead per streaming clip |

- Source files **MUST** be lossless (WAV/AIFF); MP3/OGG sources get compressed twice.
- 3D-positioned clips **MUST** be mono (author mono or tick **Force To Mono**): stereo spatial sources double memory and cost CPU to down-mix.
- Sample rate: 44.1 kHz is enough on PC; 48 kHz is waste. Tick **Load In Background** for large clips not needed at scene start.
- AudioMixer: no **SFX Reverb** group unless used (costs CPU even with no signal), no parent group with a single child, few groups overall.
- *Source:* [Audio Clip import settings](../reference/performance/manual-class-audioclip.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Audio)

### 7.4 Animation

- **SHOULD** use Generic rigs unless retargeting is needed; Humanoid costs 30–50 % more CPU. Use an Avatar Mask to drop IK goals/fingers you don't use.
- **MUST** set Animator **Culling Mode** to **Cull Completely** (animation fully disabled while no renderer is visible; **Cull Update Transforms** only disables retargeting, IK and transform writes) and untick **Update When Offscreen** on Skinned Mesh Renderers.
- **NEVER** drive single values (UI alpha, a door) with an Animator; tween in code.
- **SHOULD** avoid scale curves and keep animated hierarchies from sharing a non-root parent.
- *Source:* [Animation performance and optimization](../reference/performance/manual-mecanimpeformanceandoptimization.md) · [Animator component](../reference/scripting/manual-class-animator.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Animation)

## 8. UI performance

### 8.1 uGUI (our runtime UI)

**MUST** split Canvases by update frequency — a static canvas for the menu chrome, a separate one for anything that changes every frame. Any change to one graphic rebuilds the mesh of its **whole** canvas.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md) · [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (UGUI tips)

**MUST** turn **Raycast Target** off on every non-interactive `Image` / `TextMeshProUGUI`, and remove the `GraphicRaycaster` from canvases with nothing clickable in them.
- *Why:* Every raycast target is tested on every pointer event, whether or not it can respond.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md)

**MUST** assign a value to `TextMeshProUGUI.text` only when the value actually changed; **NEVER** in an unconditional `Update`.
- *Why:* Each assignment allocates the string, marks the canvas dirty and re-generates the text mesh; an unchanged frame should cost nothing.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md) (Canvas rebuilds)

**SHOULD** lay out hot UI with plain `RectTransform` anchors instead of Layout Groups; **NEVER** nest Layout Groups, and never leave a `ContentSizeFitter` on content that changes every frame.
- *Why:* A dirty element re-runs the layout pass for every layout group above it, so nesting multiplies the cost.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md) · [Auto layout](../reference/packages/ugui-2-0-uiautolayout.md)

**SHOULD** hide a panel by disabling its **Canvas component** rather than the GameObject when it is shown again soon (keeps the mesh, no rebuild on re-enable); disable the GameObject for panels that stay hidden for a long time.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md)

**SHOULD** keep UI sprites in one **Sprite Atlas** so a screen batches into few draw calls, and keep every UI element on the same canvas using the same material/texture where possible.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md) (Batching)

**MUST** use Screen Space – Overlay unless a camera is genuinely required; for Camera/World Space, assign the camera explicitly (a blank field costs a `Camera.main` lookup per canvas).
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md) · [Canvas](../reference/packages/ugui-2-0-uicanvas.md)

**NEVER** put an `Animator` on a UI element — it dirties the element every frame whether or not the value changed; tween the `RectTransform`/`CanvasGroup` from code (DOTween, [04](./04-unity-scripting-rules.md)) instead.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md)

**SHOULD** virtualise any scrollable list longer than a screen (pool a screenful of row prefabs and rebind them on scroll); never instantiate one row GameObject per data item.
- *Source:* [Unity UI optimization tips](../reference/performance/how-to-unity-ui-optimization-tips.md) (ScrollRect)

### 8.2 UI Toolkit (Editor UI only)

Runtime UI is uGUI ([09](./09-packages-systems.md#ugui-runtime-ui)); UI Toolkit appears only in Editor windows, custom Inspectors and property drawers, which do not ship in the player and are not covered by this document's runtime budgets. The one rule that still matters: do not build or query the element tree in an Editor `Update`/`OnGUI` loop.
- *Source:* [UI Toolkit: Optimizing performance](../reference/performance/manual-optimizing-performance.md)

## 9. Project configuration and build size

| Setting | Value | Rule |
|---|---|---|
| Player > Scripting Backend | Mono for daily iteration, **IL2CPP** for the submission build if the module is installed **[project decision]** | IL2CPP runs faster but builds slower |
| Player > Managed Stripping Level | default (do not raise during the jam) | Higher levels need `link.xml`/`[Preserve]` care; not worth the risk |
| Player > Auto Graphics API | off; list only the graphics APIs we ship (the list itself is configured per [07](./07-rendering-hdrp.md)) | Fewer shader variants, faster builds |
| Quality levels | exactly one level, `Desktop`, bound to `Settings/HDRP/HDRP_Desktop.asset` — never add, rename, reorder or delete levels (owned by [07 §3](./07-rendering-hdrp.md#3-quality-tiers)) | Each level/HDRP asset contributes shader variants; the set is settled in 07 |
| Graphics > Always Included Shaders | remove what we don't use | Each entry compiles all variants into the build |
| `Resources/` folder | none (project decision 8) | Everything in Resources ships and is indexed at startup |
| Player > Stack Trace | Log: None; Warning/Error: ScriptOnly in release builds **[project decision]** | Stack capture is expensive |

- *Source:* [PC/console e-book](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) (Project configuration, Remove built-in shader settings) · [Reducing the file size of a build](../reference/performance/manual-reducingfilesize.md) · [Managed code stripping](../reference/performance/manual-managed-code-stripping.md) · [Analyzing Profiler traces](../reference/performance/manual-performance-profiler-traces.md) (Resources index at startup)

**SHOULD** check build size with the Editor log after a build (**Console > ⋮ > Open Editor Log**, assets listed by size); textures and audio dominate, so revisit section 7 before anything else. Remove test assets bundled with third-party packages that are not referenced.
- *Source:* [Reducing the file size of a build](../reference/performance/manual-reducingfilesize.md) · [Mobile/XR/Web e-book](../reference/performance/ebook-optimize-your-game-performance-for-mobile-xr-and-the-web-in-unity-unit.md) (Remove unused resources)

### 9.1 No Web build

**NEVER** add a Web (or mobile) build target: HDRP does not support WebGL or WebGPU, and does not support mobile platforms. The project ships desktop standalone only (Windows/macOS), so there is no Brotli/decompression/`WebAssembly 2023` configuration to tune and no second frame budget — section 1.1 has the one budget that applies. Switching the active build target to Web produces a project that cannot render.

If the team ever wants a browser build, that is a pipeline decision (back to URP), not a Player-settings change; raise it with the rendering owner and [07](./07-rendering-hdrp.md) before anything else.
- *Source:* [HDRP system requirements](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md) (supported platforms) · [Choose a render pipeline](../reference/rendering-urp/manual-choose-a-render-pipeline.md) (HDRP targets high-end desktop/console only)

## Anti-patterns

- ❌ "It runs at 200 fps in the Editor so it's fine" → ✅ Profile a Development Build on the min-spec machine; Editor numbers include Editor overhead and Editor-only allocations.
- ❌ Optimizing shaders when the main thread is the bottleneck (or scripts when GPU-bound) → ✅ Read the Timeline/Highlights first; fix the chip/thread that is longest.
- ❌ `GetComponent<Rigidbody>()` / `FindFirstObjectByType<GameManager>()` / `Camera.main` inside `Update` → ✅ Cache in `Awake`; `[RequireComponent]` so it can't be null.
- ❌ `scoreLabel.text = "Score: " + score;` every frame → ✅ Update on change; keep label and value in separate elements.
- ❌ `enemies.Where(e => e.IsAlive).OrderBy(e => dist).First()` in a per-frame method → ✅ `for` loop with a running minimum over a reused list.
- ❌ `yield return new WaitForSeconds(0.1f)` in a loop → ✅ Cache the `WaitForSeconds`, or `await Awaitable.WaitForSecondsAsync(...)`.
- ❌ `Instantiate(bulletPrefab)` … `Destroy(gameObject, 3f)` → ✅ `ObjectPool<Projectile>` (section 4).
- ❌ `renderer.material.color = Color.red;` on a batched prop → ✅ `sharedMaterial` for reads, a Material Variant asset or vertex colour for per-instance tint; never `MaterialPropertyBlock` in HDRP.
- ❌ Ticking **Enable GPU Instancing** on HDRP materials, or enabling Dynamic Batching → ✅ the always-on SRP Batcher + static batching; GPU Resident Drawer only when measured.
- ❌ A second `Camera` for the weapon/UI/minimap "because it was easy" → ✅ One camera + an HDRP Custom Pass / a Screen Space – Overlay canvas; HDRP has no camera stacking and each camera is a full culling + render pass.
- ❌ Mesh Collider on a thrown crate; `OnTriggerStay` counting overlaps → ✅ Box/compound primitives; `Enter`/`Exit` events with a cached count.
- ❌ `Physics.OverlapSphere(...)` (allocates) every frame → ✅ `OverlapSphereNonAlloc` into a field buffer with a layer mask and `QueryTriggerInteraction.Ignore`.
- ❌ Point light with shadows, four cascades, realtime reflection probe "for quality" → ✅ Lights Realtime today (baked GI/APV once baking starts, 07 §5.3), shadow-casting lights and cascades per 07 §11, baked reflection probes.
- ❌ 4096² uncompressed PNG with Read/Write on, mipmaps off → ✅ 2048 max, DXT/BC7, Read/Write off, mipmaps on.
- ❌ Stereo 48 kHz WAV on a 3D `AudioSource`, Decompress On Load for the music track → ✅ Mono, 44.1 kHz, Streaming for music.
- ❌ `CanvasGroup.alpha = 0` to hide a panel (it still draws and still eats clicks); an `Animator` on a UI element → ✅ disable the `Canvas` component or the root GameObject; tween from code.
- ❌ `GC.Collect()` "to be safe" at the end of a wave → ✅ Only in the scene-transition flow; find the allocations instead.
- ❌ Deep Profile on for a whole session and quoting its numbers → ✅ Call Stacks for allocations, `ProfilerMarker`s for timing; Deep Profile briefly, for call trees only.

## Review checklist

- [ ] The PR touching per-frame code states the `GC.Alloc` for its markers is 0 in Play mode (or explains the allocation and where it is amortised).
- [ ] No `GetComponent`/`Find*`/`Camera.main`/`AddComponent` inside `Update`/`FixedUpdate`/`LateUpdate`; references cached in `Awake`/`Start`.
- [ ] No string building, LINQ, `Regex`, capturing lambdas, `params` calls or `new` collections/arrays in per-frame paths.
- [ ] Material/animator property ids cached as `static readonly int k_…` fields; tags compared with `CompareTag`.
- [ ] Physics queries use `*NonAlloc` with a field buffer, a `LayerMask`, an explicit `QueryTriggerInteraction` and a max distance; dynamic bodies use primitive/compound colliders.
- [ ] Repeatedly spawned objects go through `ObjectPool<T>` with reset-on-release; nothing `Instantiate`s/`Destroy`s in a gameplay loop.
- [ ] No `Debug.Log` in per-frame paths; dev-only logging goes through `RootsDance.Core.Log` (04).
- [ ] No `Renderer.material` reads, no `MaterialPropertyBlock`, no **Enable GPU Instancing** on HDRP materials; new materials use `HDRP/Lit`, `HDRP/Unlit` or an HDRP-target Shader Graph.
- [ ] Still exactly one active Unity `Camera` (09/11); new lights are Realtime (07 §5.3) and within 07 §11's shadow-casting budget.
- [ ] New textures: Max Size per 7.1, compressed, and the 07 §10 import rules (POT, Read/Write off, mipmaps correct). New meshes: Read/Write off, Optimize Mesh on. New audio: WAV source, mono for 3D, load type per clip size.
- [ ] Project Settings changes (Physics, Time, Quality, Player) are in their own commit and called out in the PR description.
- [ ] New per-frame system has a `ProfilerMarker` named `RootsDance.<System>.<Phase>`.
- [ ] Before a submission build: Development Build profiled on the min-spec machine, Highlights shows 0 over-budget frames in a 300-frame gameplay capture, Memory Profiler snapshot within budget, Stats overlay within 1.1 thresholds.

## Sources

1. [../reference/performance/how-to-best-practices-for-profiling-game-performance.md](../reference/performance/how-to-best-practices-for-profiling-game-performance.md) — Best practices for profiling game performance — https://unity.com/how-to/best-practices-for-profiling-game-performance
2. [../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md](../reference/performance/ebook-ultimate-guide-to-profiling-games-e-book-unity-6-edition.md) — Ultimate guide to profiling Unity games (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/8t9r5hwz38rrbrw4x8zcq2c/Ultimate_Guide_to_Profiling_Games_e-book_-_Unity_6_edition.pdf
3. [../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) — Optimize your game performance for consoles and PCs in Unity (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/xbhk7z8kvttn35t3nx45mm98/Optimize_your_game_performance_for_consoles_and_PCs_in_Unity_Unity_6_edition_e-book.pdf
4. [../reference/performance/ebook-optimize-your-game-performance-for-mobile-xr-and-the-web-in-unity-unit.md](../reference/performance/ebook-optimize-your-game-performance-for-mobile-xr-and-the-web-in-unity-unit.md) — Optimize your game performance for mobile, XR, and the web in Unity (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/3mp8w3wk36k2k6mmj5pbbr/Optimize_your_game_performance_for_mobile__XR__and_the_web_in_Unity_Unity_6_edition_e-book.pdf
5. [../reference/performance/manual-profilerhighlights.md](../reference/performance/manual-profilerhighlights.md) — Highlights Profiler module reference — https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerHighlights.html
6. [../reference/performance/manual-profiler-introduction.md](../reference/performance/manual-profiler-introduction.md) — Profiler introduction — https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-introduction.html
7. [../reference/performance/manual-profiling-target-device.md](../reference/performance/manual-profiling-target-device.md) — Collect performance data on a target platform — https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-target-device.html
8. [../reference/performance/manual-profiler-markers.md](../reference/performance/manual-profiler-markers.md) — Profiler markers reference — https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html
9. [../reference/performance/manual-performance-profiler-traces.md](../reference/performance/manual-performance-profiler-traces.md) — Analyzing Profiler traces — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-profiler-traces.html
10. [../reference/performance/manual-profiler-add-markers-code.md](../reference/performance/manual-profiler-add-markers-code.md) — Adding profiler markers to your code — https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-add-markers-code.html
11. [../reference/performance/scriptref-unity-profiling-profilermarker.md](../reference/performance/scriptref-unity-profiling-profilermarker.md) — ProfilerMarker (Script Reference) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.html
12. [../reference/performance/how-to-optimize-your-game-unity-profile-analyzer.md](../reference/performance/how-to-optimize-your-game-unity-profile-analyzer.md) — Optimize your game with the Unity Profile Analyzer — https://unity.com/how-to/optimize-your-game-unity-profile-analyzer
13. [../reference/performance/how-to-use-memory-profiling-unity.md](../reference/performance/how-to-use-memory-profiling-unity.md) — How to use Unity's memory profiling tools — https://unity.com/how-to/use-memory-profiling-unity
14. [../reference/performance/manual-performance-track-garbage-collection.md](../reference/performance/manual-performance-track-garbage-collection.md) — Tracking garbage collection allocations — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-track-garbage-collection.html
15. [../reference/performance/test-framework-performance-3-5-writing-tests.md](../reference/performance/test-framework-performance-3-5-writing-tests.md) — Performance Testing package: Writing tests — https://docs.unity3d.com/Packages/com.unity.test-framework.performance@3.5/manual/writing-tests.html
16. [../reference/performance/manual-performance-reference-types.md](../reference/performance/manual-performance-reference-types.md) — Reference type management — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reference-types.html
17. [../reference/performance/manual-performance-optimizing-arrays.md](../reference/performance/manual-performance-optimizing-arrays.md) — Optimizing arrays — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-arrays.html
18. [../reference/performance/manual-performance-reusable-code.md](../reference/performance/manual-performance-reusable-code.md) — Pooling and reusing objects — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reusable-code.html
19. [../reference/performance/scriptref-pool-objectpool-1-ctor.md](../reference/performance/scriptref-pool-objectpool-1-ctor.md) — Pool.ObjectPool<T> constructor — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1-ctor.html
20. [../reference/performance/scriptref-pool-listpool-1.md](../reference/performance/scriptref-pool-listpool-1.md) — ListPool<T0> (Script Reference) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ListPool_1.html
21. [../reference/performance/tutorial-use-object-pooling-to-boost-performance-of-c-scripts-in-unity.md](../reference/performance/tutorial-use-object-pooling-to-boost-performance-of-c-scripts-in-unity.md) — Use object pooling to boost performance of C# scripts in Unity (Unity Learn) — https://learn.unity.com/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity
22. [../reference/performance/manual-coroutines-analyzing.md](../reference/performance/manual-coroutines-analyzing.md) — Analyzing coroutines — https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-analyzing.html
23. [../reference/performance/manual-performance-garbage-collector.md](../reference/performance/manual-performance-garbage-collector.md) — Garbage collector overview — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html
24. [../reference/performance/manual-performance-incremental-garbage-collection.md](../reference/performance/manual-performance-incremental-garbage-collection.md) — Garbage collection modes — https://docs.unity3d.com/6000.3/Documentation/Manual/performance-incremental-garbage-collection.html
25. [../reference/performance/manual-physics-optimization-cpu-frequency.md](../reference/performance/manual-physics-optimization-cpu-frequency.md) — Set fixed timestep to optimize physics simulation frequency — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-frequency.html
26. [../reference/performance/manual-physics-optimization-cpu-collision-layers.md](../reference/performance/manual-physics-optimization-cpu-collision-layers.md) — Use the layer collision matrix to reduce overlaps — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collision-layers.html
27. [../reference/performance/manual-physics-optimization-collision-callbacks.md](../reference/performance/manual-physics-optimization-collision-callbacks.md) — Optimize collision callbacks — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-collision-callbacks.html
28. [../reference/performance/manual-physics-optimization-cpu-transform-sync.md](../reference/performance/manual-physics-optimization-cpu-transform-sync.md) — Optimize transform value syncing — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-transform-sync.html
29. [../reference/performance/manual-physics-optimization-cpu-collider-types.md](../reference/performance/manual-physics-optimization-cpu-collider-types.md) — Collider types and performance — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-collider-types.html
30. [../reference/performance/manual-physics-optimization-raycasts-queries.md](../reference/performance/manual-physics-optimization-raycasts-queries.md) — Optimize raycasts and other physics queries — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-raycasts-queries.html
31. [../reference/performance/manual-physics-optimization-cpu-static-colliders.md](../reference/performance/manual-physics-optimization-cpu-static-colliders.md) — Move static colliders to prevent performance issues — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-static-colliders.html
32. [../reference/performance/manual-physics-optimization-cpu-rigidbody-sleeping.md](../reference/performance/manual-physics-optimization-cpu-rigidbody-sleeping.md) — Use Rigidbody sleeping to improve physics performance — https://docs.unity3d.com/6000.3/Documentation/Manual/physics-optimization-cpu-rigidbody-sleeping.html
33. [../reference/performance/how-to-enhanced-physics-performance-smooth-gameplay.md](../reference/performance/how-to-enhanced-physics-performance-smooth-gameplay.md) — Enhanced physics performance for smooth gameplay — https://unity.com/how-to/enhanced-physics-performance-smooth-gameplay
34. [../reference/performance/manual-optimizing-draw-calls-choose-method.md](../reference/performance/manual-optimizing-draw-calls-choose-method.md) — Choose a method for optimizing draw calls — https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html
35. [../reference/performance/manual-drawcallbatching.md](../reference/performance/manual-drawcallbatching.md) — Introduction to batching meshes — https://docs.unity3d.com/6000.3/Documentation/Manual/DrawCallBatching.html
36. [../reference/performance/manual-gpuinstancing.md](../reference/performance/manual-gpuinstancing.md) — Introduction to GPU instancing — https://docs.unity3d.com/6000.3/Documentation/Manual/GPUInstancing.html
37. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-srpbatcher.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-srpbatcher.md) — Scriptable Render Pipeline Batcher (HDRP; always on, compatibility rules) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/SRPBatcher.html
38. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-gpu-resident-drawer.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-gpu-resident-drawer.md) — Use the GPU Resident Drawer (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/gpu-resident-drawer.html
39. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-hdrp-asset.md) — HDRP Asset reference (Rendering section: GPU Resident Drawer, GPU Occlusion Culling; shadow atlases) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html
40. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-reduce-shader-variants.md) — Reduce shader variants (HDRP) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-shader-variants.html
41. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-quality-settings.md) — Quality settings in HDRP (quality levels bound to HDRP assets) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/quality-settings.html
42. [../reference/performance/how-to-gpu-optimization.md](../reference/performance/how-to-gpu-optimization.md) — Managing GPU usage for PC and console games — https://unity.com/how-to/gpu-optimization
43. [../reference/performance/manual-optimizinggraphicsperformance.md](../reference/performance/manual-optimizinggraphicsperformance.md) — Reduce rendering work on the CPU or GPU — https://docs.unity3d.com/6000.3/Documentation/Manual/OptimizingGraphicsPerformance.html
44. [../reference/performance/manual-occlusionculling.md](../reference/performance/manual-occlusionculling.md) — Occlusion culling — https://docs.unity3d.com/6000.3/Documentation/Manual/OcclusionCulling.html
45. [../reference/performance/manual-staticobjects.md](../reference/performance/manual-staticobjects.md) — Static GameObjects — https://docs.unity3d.com/6000.3/Documentation/Manual/StaticObjects.html
46. [../reference/performance/manual-levelofdetail.md](../reference/performance/manual-levelofdetail.md) — Introduction to level of detail — https://docs.unity3d.com/6000.3/Documentation/Manual/LevelOfDetail.html
47. [../reference/performance/manual-mesh-lod-introduction.md](../reference/performance/manual-mesh-lod-introduction.md) — Introduction to Mesh LOD — https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-introduction.html
48. [../reference/performance/manual-shadow-cascades-performance.md](../reference/performance/manual-shadow-cascades-performance.md) — Performance impact of shadow cascades — https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-performance.html
49. [../reference/performance/manual-refprobeperformance.md](../reference/performance/manual-refprobeperformance.md) — Optimize reflections — https://docs.unity3d.com/6000.3/Documentation/Manual/RefProbePerformance.html
50. [../reference/performance/manual-renderingstatistics.md](../reference/performance/manual-renderingstatistics.md) — Rendering Statistics window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/RenderingStatistics.html
51. [../reference/performance/manual-framedebugger.md](../reference/performance/manual-framedebugger.md) — Introduction to the Frame Debugger — https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger.html
52. [../reference/performance/scriptref-application-targetframerate.md](../reference/performance/scriptref-application-targetframerate.md) — Application.targetFrameRate — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-targetFrameRate.html
53. [../reference/performance/scriptref-qualitysettings-vsynccount.md](../reference/performance/scriptref-qualitysettings-vsynccount.md) — QualitySettings.vSyncCount — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QualitySettings-vSyncCount.html
54. [../reference/performance/how-to-project-configuration-and-assets.md](../reference/performance/how-to-project-configuration-and-assets.md) — Configuring your Unity project for stronger performance — https://unity.com/how-to/project-configuration-and-assets
55. [../reference/performance/manual-texture-choose-format-by-platform.md](../reference/performance/manual-texture-choose-format-by-platform.md) — Choose a GPU texture format by platform — https://docs.unity3d.com/6000.3/Documentation/Manual/texture-choose-format-by-platform.html
56. [../reference/performance/manual-texturestreaming.md](../reference/performance/manual-texturestreaming.md) — Optimizing GPU texture memory with mipmap streaming — https://docs.unity3d.com/6000.3/Documentation/Manual/TextureStreaming.html
57. [../reference/performance/manual-fbximporter-model.md](../reference/performance/manual-fbximporter-model.md) — Model tab Import Settings reference — https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html
58. [../reference/performance/manual-class-audioclip.md](../reference/performance/manual-class-audioclip.md) — Audio Clip Import Settings reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html
59. [../reference/performance/manual-mecanimpeformanceandoptimization.md](../reference/performance/manual-mecanimpeformanceandoptimization.md) — Animation performance and optimization — https://docs.unity3d.com/6000.3/Documentation/Manual/MecanimPeformanceandOptimization.html
60. [../reference/scripting/manual-class-animator.md](../reference/scripting/manual-class-animator.md) — Animator component — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Animator.html
61. [../reference/packages/ugui-2-0-uiautolayout.md](../reference/packages/ugui-2-0-uiautolayout.md) — Auto layout (uGUI) — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/UIAutoLayout.html
62. [../reference/performance/manual-optimizing-performance.md](../reference/performance/manual-optimizing-performance.md) — UI Toolkit for advanced Unity developers: Optimizing performance — https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/optimizing-performance.html
63. [../reference/performance/how-to-unity-ui-optimization-tips.md](../reference/performance/how-to-unity-ui-optimization-tips.md) — Unity UI performance optimization tips — https://unity.com/how-to/unity-ui-optimization-tips
64. [../reference/performance/manual-reducingfilesize.md](../reference/performance/manual-reducingfilesize.md) — Reducing the file size of a build — https://docs.unity3d.com/6000.3/Documentation/Manual/ReducingFilesize.html
65. [../reference/performance/manual-managed-code-stripping.md](../reference/performance/manual-managed-code-stripping.md) — Managed code stripping — https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping.html
66. [../reference/performance/manual-webgl-memory.md](../reference/performance/manual-webgl-memory.md) — Memory in Unity Web — https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-memory.html
67. [../reference/scripting/scriptref-shader-propertytoid.md](../reference/scripting/scriptref-shader-propertytoid.md) — Shader.PropertyToID — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.PropertyToID.html
68. [../reference/scripting/scriptref-animator-stringtohash.md](../reference/scripting/scriptref-animator-stringtohash.md) — Animator.StringToHash — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html
69. [../reference/scripting/scriptref-gameobject-comparetag.md](../reference/scripting/scriptref-gameobject-comparetag.md) — GameObject.CompareTag — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CompareTag.html
70. [../reference/scripting/scriptref-component-trygetcomponent.md](../reference/scripting/scriptref-component-trygetcomponent.md) — Component.TryGetComponent — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html
71. [../reference/scripting/manual-async-awaitable-introduction.md](../reference/scripting/manual-async-awaitable-introduction.md) — Introduction to asynchronous programming with Awaitable — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html
72. [../reference/scripting/github-unitycsreference-unityengineobject-bindings-cs.md](../reference/scripting/github-unitycsreference-unityengineobject-bindings-cs.md) — UnityEngine.Object bindings, 6000.3 branch (`Object.Instantiate` overloads) — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Runtime/Export/Scripting/UnityEngineObject.bindings.cs
73. [../reference/performance/scriptref-physics-raycastnonalloc.md](../reference/performance/scriptref-physics-raycastnonalloc.md) — Physics.RaycastNonAlloc — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RaycastNonAlloc.html
74. [../reference/scripting/scriptref-physics-overlapspherenonalloc.md](../reference/scripting/scriptref-physics-overlapspherenonalloc.md) — Physics.OverlapSphereNonAlloc — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphereNonAlloc.html
75. [../reference/performance/manual-class-qualitysettings.md](../reference/performance/manual-class-qualitysettings.md) — Quality settings reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html
76. [../reference/packages/ugui-2-0-uicanvas.md](../reference/packages/ugui-2-0-uicanvas.md) — Canvas (uGUI) — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/UICanvas.html
77. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-shadows-in-hdrp.md) — Shadows in HDRP (shadow atlas budget) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Shadows-in-HDRP.html
78. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-volumetric-lighting.md) — Volumetric lighting (fixed-cost froxel pass) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Volumetric-Lighting.html
79. [../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md](../reference/rendering-hdrp/render-pipelines-high-definition-17-3-system-requirements.md) — HDRP system requirements (no Web, no mobile) — https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/System-Requirements.html
80. [../reference/rendering-urp/manual-choose-a-render-pipeline.md](../reference/rendering-urp/manual-choose-a-render-pipeline.md) — Choose a render pipeline (6000.3 Manual; HDRP platform scope) — https://docs.unity3d.com/6000.3/Documentation/Manual/choose-a-render-pipeline.html
