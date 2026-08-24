# 04. Unity scripting rules

> **Scope:** How to write MonoBehaviour, ScriptableObject and plain C# code that behaves correctly on Unity 6000.3 — lifecycle, serialization, null checks, object lookup, Instantiate/Destroy, Awaitable vs coroutines, events, time, physics API, Input System usage, logging, assembly definitions and language limits.
> **Applies to:** all C# under `Assets/RootsDance/Scripts` and `Assets/RootsDance/Tests` (assemblies `RootsDance.Runtime`, `RootsDance.Editor`, `RootsDance.Tests.EditMode`, `RootsDance.Tests.PlayMode`).
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

Naming and formatting are owned by [01 C# style](./01-csharp-style.md); architecture (SOLID, event channels, pooling, service locator) by [03 Architecture patterns](./03-architecture-patterns.md); profiling and optimisation by [05 Performance](./05-performance.md); API renames and deprecations in full by [10 Unity 6.3 facts](./10-unity6-facts.md). This document is the code-level rulebook that sits between them.

## TL;DR — rules at a glance

1. **MUST** initialise own components in `Awake`, talk to other objects in `Start`, subscribe in `OnEnable` and unsubscribe in `OnDisable`; **NEVER** write a MonoBehaviour/ScriptableObject constructor or a field initialiser that touches objects, components or assets.
2. **MUST** expose Inspector data as `[SerializeField] private` fields (6.3 compiles `[SerializeField]` only on fields; auto-properties need `[field: SerializeField]`); rename serialized fields with `[FormerlySerializedAs]`.
3. **MUST** null-check `UnityEngine.Object` references with `== null` or the implicit `bool`; **NEVER** use `?.`, `??`, `is null` or `ReferenceEquals` to test whether a Unity object is alive.
4. **MUST** wire references through serialized fields or `GetComponent` cached in `Awake`; use `TryGetComponent` when the component may be absent; **NEVER** call `GetComponent`, `Find*` or `Camera.main` every frame.
5. **MUST** wire gameplay references (see [03](./03-architecture-patterns.md)); when a lookup is unavoidable (bootstrap, tests, editor tooling) use `FindFirstObjectByType` / `FindAnyObjectByType` / `FindObjectsByType(FindObjectsSortMode.None)` once, in initialisation code; **NEVER** the obsolete `FindObjectOfType` family, `GameObject.Find` or `FindWithTag` in gameplay code; compare tags with `CompareTag`.
6. **MUST** destroy with `Destroy` (deferred to end of frame) at runtime; **NEVER** `DestroyImmediate` outside Editor code.
7. **MUST** write async work as `async Awaitable` methods that take a `CancellationToken` (`destroyCancellationToken` on MonoBehaviours, `Application.exitCancellationToken` elsewhere); **NEVER** await the same `Awaitable` twice or touch Unity APIs off the main thread.
8. **MAY** use coroutines for simple frame/time sequences; cache `WaitForSeconds`, start/stop them by `IEnumerator`/`Coroutine` reference, never by string name; **NEVER** use `Invoke("...")`.
9. **MUST** scale per-frame movement by `Time.deltaTime`; put Rigidbody work in `FixedUpdate` and move bodies with `AddForce` / `MovePosition`, not `transform`.
10. **MUST** use the Unity 6 physics names `linearVelocity`, `linearDamping`, `angularDamping`, `PhysicsMaterial`.
11. **MUST** read input from `InputSystem.actions` (project-wide actions) via `ReadValue<T>()` / `IsPressed()` / `WasPressedThisFrame()`; **NEVER** use `UnityEngine.Input`.
12. **MUST** use C# `event` for code-to-code notifications and `UnityEvent` only for designer-wired Inspector callbacks; every subscription has a matching unsubscription.
13. **MUST** log through `RootsDance.Core.Log` (`Log.Info`/`Log.Warning` compile out of release builds, `Log.Error`/`Log.Exception` are unconditional, every call passes a `UnityEngine.Object` context); **NEVER** call `Debug.Log*` directly outside `Log.cs` and `_Sandbox/`, never `print()`, never a log in a per-frame method; `Debug.Assert` for invariants.
14. **MUST** keep project code inside the four project asmdefs — the only code outside them is vendor code in `Assets/ThirdParty/` and scratch code in `Assets/_Sandbox/<user>/` (both land in `Assembly-CSharp`, may use `RootsDance.Runtime`, can never be referenced by it); Editor-only code lives in `RootsDance.Editor` or behind `#if UNITY_EDITOR`; test code never ships.
15. **NEVER** use C# records, `init` setters, `dynamic`, finalizers, `[ThreadStatic]` or `System.Reflection.Emit`; static mutable state needs an explicit reset path.

## Lifecycle and event functions

**Put each kind of work in the callback Unity designed for it.**

| Callback | Use it for | Do not use it for |
|---|---|---|
| `Awake` | Caching own components (`GetComponent`), initialising private state. Runs once per instance, even if the component is disabled. | Reading state from *other* objects — their `Awake` order is undefined. |
| `OnEnable` | Subscribing to events, registering with managers, enabling input actions. Runs every time the component/GameObject becomes active. | Work that must run exactly once. |
| `Start` | Cross-object setup (all `Awake` calls have finished), first use of other components' state. Runs once, just before the first `Update`, only if enabled. | Caching own components (do it in `Awake`). |
| `Update` | Per-frame gameplay: reading input, non-physics movement, timers. | Physics (`Rigidbody`) changes. |
| `FixedUpdate` | Physics: `AddForce`, `MovePosition`, `linearVelocity`. May run 0..n times per frame. | Reading one-shot input (see Input section). |
| `LateUpdate` | Camera follow, anything that must see the final position of everything moved in `Update` and by animation. | Gameplay logic. |
| `OnDisable` | Unsubscribing, unregistering, cancelling. Also called on destroy, scene unload and domain reload. | Cleanup that needs other objects to still exist. |
| `OnDestroy` | Releasing resources you created (materials, `CreateInstance` objects). Only called on objects that were active at least once. | Saving state on mobile (not guaranteed). |
| `OnValidate` | Clamping/validating serialized fields in the Editor. | Creating objects, calling non-thread-safe APIs, persisting computed values. |

- *Why:* `Awake` order between objects is not deterministic; `Start` is guaranteed to run after every `Awake` in the scene. `OnEnable`/`OnDisable` pair symmetrically across activation and destruction, which makes them the only safe subscribe/unsubscribe points. `FixedUpdate` can run zero or several times per frame. `OnValidate` runs at load/import, from loading threads, and doesn't save.
- *Source:* [Event functions](../reference/scripting/manual-event-functions.md), [Execution order](../reference/scripting/manual-execution-order.md), [Awake](../reference/scripting/scriptref-monobehaviour-awake.md), [Start](../reference/scripting/scriptref-monobehaviour-start.md), [OnEnable](../reference/scripting/scriptref-monobehaviour-onenable.md), [OnDisable](../reference/scripting/scriptref-monobehaviour-ondisable.md), [OnDestroy](../reference/scripting/scriptref-monobehaviour-ondestroy.md), [FixedUpdate](../reference/scripting/scriptref-monobehaviour-fixedupdate.md), [LateUpdate](../reference/scripting/scriptref-monobehaviour-lateupdate.md), [OnValidate](../reference/scripting/scriptref-monobehaviour-onvalidate.md).

```csharp
using UnityEngine;
using UnityEngine.SceneManagement;

namespace RootsDance.Player
{
    [RequireComponent(typeof(Rigidbody))]
    public class PlayerSpawnTracker : MonoBehaviour
    {
        [SerializeField] private Transform m_spawnPoint;

        private Rigidbody m_rigidbody;

        private void Awake()
        {
            m_rigidbody = GetComponent<Rigidbody>();          // own components only
        }

        private void OnEnable()
        {
            SceneManager.sceneLoaded += SceneManager_SceneLoaded;    // subscribe
        }

        private void Start()
        {
            m_rigidbody.position = m_spawnPoint.position;     // other objects are initialised now
        }

        private void OnDisable()
        {
            SceneManager.sceneLoaded -= SceneManager_SceneLoaded;    // always paired with OnEnable
        }

        private void SceneManager_SceneLoaded(Scene scene, LoadSceneMode mode)
        {
            m_rigidbody.position = m_spawnPoint.position;
        }
    }
}
```

**NEVER define a constructor on a MonoBehaviour or ScriptableObject, and never touch objects, components or assets from field initialisers.** The only field-initialiser calls allowed are pure helpers on simple data (`Vector3`, `Mathf`, `Animator.StringToHash`, `Shader.PropertyToID` in `private static readonly` caches). **[project decision]** for the two ID helpers.
- *Why:* Unity constructs these objects itself, on a loading thread, before serialized state exists; a constructor "can cause major problems with the project". Development builds throw `UnityException: ... can only be called from the main thread` for main-thread API calls in constructors/field initialisers; Unity lists math and simple-data APIs as safe there.
- *Source:* [MonoBehaviour manual](../reference/scripting/manual-class-monobehaviour.md), [Serialization best practices](../reference/scripting/manual-script-serialization-best-practices.md), [Awaitable continuations](../reference/scripting/manual-async-awaitable-continuations.md), [Animator.StringToHash](../reference/scripting/scriptref-animator-stringtohash.md).

**Do not rely on the order in which different scripts receive the same callback.** When two scripts genuinely need an order, use `[DefaultExecutionOrder(n)]` in code (lower runs first) and do not also set it in Project Settings.
- *Why:* Unity documents cross-script order as non-deterministic unless configured. A value set in the Editor UI silently overrides the attribute, so keeping it in code makes the dependency reviewable in Git. **[project decision]** for "attribute, not Project Settings".
- *Source:* [Script execution order](../reference/scripting/manual-script-execution-order.md), [DefaultExecutionOrder](../reference/scripting/scriptref-defaultexecutionorder.md).

**Bootstrap code that must run without a scene object uses `[RuntimeInitializeOnLoadMethod]`.** Static mutable *values* **MUST** be reset in a `[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]` method. Static *event* subscriptions are instead removed where they were added (`OnDisable`/`OnDestroy`); if a static subscription must outlive an object, unregister it on exiting Play mode via `EditorApplication.playModeStateChanged` inside `#if UNITY_EDITOR` — the manual calls entry-time unregistration error-prone. **[project decision]**
- *Why:* With domain reload disabled (a common iteration-speed setting) statics and static event handlers survive between Play sessions; the reset method keeps the option toggleable per developer without breaking the game. Order within one load type is not guaranteed. The manual's best practice is to "always unregister static event handlers on exiting Play mode" because waiting for the next session "can cause object reference issues that lead to unregistering the wrong handler".
- *Source:* [RuntimeInitializeOnLoadMethod](../reference/scripting/scriptref-runtimeinitializeonloadmethodattribute.md), [Domain reload disabled](../reference/scripting/manual-domain-reloading.md).

**ScriptableObject lifecycle:** `OnEnable` runs when the asset is loaded (and again after domain reloads or when Unity re-instantiates it), so it is for one-time initialisation only. Never mutate a ScriptableObject asset as runtime game state — in the Editor the loaded asset keeps the modified values until it is reloaded (and Inspector edits are saved to disk, even in Play mode), while a Player can only read asset data, so behaviour differs between Editor and build. Create a runtime copy with `ScriptableObject.CreateInstance<T>()` or `Instantiate` when state must change.
- *Source:* [ScriptableObject.OnEnable](../reference/scripting/scriptref-scriptableobject-onenable.md), [ScriptableObject manual](../reference/scripting/manual-class-scriptableobject.md), [ScriptableObject API](../reference/scripting/scriptref-scriptableobject.md).

## Script serialization

**Expose tunables as `[SerializeField] private` fields, never public fields.** In 6.3 `[SerializeField]` on a property, method or type is a compile error; serialize an auto-property's backing field with `[field: SerializeField]` only when a public getter is genuinely needed.
- *Why:* Unity serializes fields, not properties; the Inspector writes the backing field directly and never calls setters. Private serialized fields keep other classes from overwriting values.
- *Source:* [Upgrade to Unity 6.3 — SerializeField restriction](../reference/unity6-release/manual-upgradeguideunity63.md), [Serialization rules](../reference/scripting/manual-script-serialization-rules.md), [SerializeField](../reference/scripting/scriptref-serializefield.md), [How Unity uses serialization](../reference/scripting/manual-script-serialization-how-unity-uses.md), [C# style e-book, Serialization](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md).

```csharp
using System;
using UnityEngine;
using UnityEngine.Serialization;

public class Health : MonoBehaviour
{
    [SerializeField, Range(1, 999)] private int m_maxHealth = 100;
    [SerializeField, FormerlySerializedAs("m_regenSettings")] private RegenSettings m_regen;
    [SerializeField] private HealthConfigSO m_config;        // ScriptableObject: serialized as a reference

    [field: SerializeField] public float InvulnerableSeconds { get; private set; } = 1f;

    [NonSerialized] private int m_currentHealth;            // runtime-only: never serialized, not restored on hot reload

    // ❌ [SerializeField] public int Lives { get; set; }   // compile error in 6.3
    // ❌ public Dictionary<string, int> m_stats;           // Unity cannot serialize dictionaries

    [Serializable]
    public struct RegenSettings                 // custom struct: needs [Serializable]; nested types go last
    {
        public float PerSecond;
        public float DelayAfterHit;
    }
}
```

**What serializes** (and what does not):
- Serialized: public or `[SerializeField]` fields that are not `static`, `const` or `readonly`, of type primitive, enum (≤32 bit), Unity built-in type (`Vector3`, `Color`, `AnimationCurve`…), `UnityEngine.Object` reference, `[Serializable]` custom class/struct, or array/`List<T>` of those.
- Not serialized: properties, dictionaries, multidimensional/jagged arrays, nested containers (`List<List<T>>`), interface- or abstract-typed fields (unless `[SerializeReference]`), `readonly`/`static` fields. Wrap nested containers in a `[Serializable]` class or implement `ISerializationCallbackReceiver`.
- `[Serializable]` is not inherited — apply it to every class in the hierarchy.
- `[SerializeReference]` is only for polymorphism, null or shared references inside one object; default inline serialization is cheaper.
- *Source:* [Serialization rules](../reference/scripting/manual-script-serialization-rules.md).

**Rename a serialized field with `[FormerlySerializedAs("oldName")]` and keep the attribute at least until every scene/prefab has been re-saved on `develop` (the integration branch, see [06 Version control](./06-version-control.md)).** Editor-only; harmless in builds.
- *Why:* Without it every scene and prefab loses the value silently — a classic hackathon time sink and merge-conflict generator.
- *Source:* [FormerlySerializedAs](../reference/scripting/scriptref-serialization-formerlyserializedasattribute.md), [How Unity uses serialization (Editor vs runtime table)](../reference/scripting/manual-script-serialization-how-unity-uses.md).

**Keep serialized data flat and minimal; never serialize cached or duplicated data; share data through ScriptableObject references.** Mark runtime-only fields `[NonSerialized]` (or `[field: NonSerialized]` for auto-properties) so hot reload does not resurrect stale values.
- *Source:* [Serialization best practices](../reference/scripting/manual-script-serialization-best-practices.md), [How Unity uses serialization — hot reload](../reference/scripting/manual-script-serialization-how-unity-uses.md).

**`OnValidate` only clamps/validates the fields that changed.** No object creation, no scene changes, no reliance on it to persist computed values (Prefab Variants will not store them).
- *Source:* [OnValidate](../reference/scripting/scriptref-monobehaviour-onvalidate.md).

## Null checks on Unity objects

**Check `UnityEngine.Object` references with `== null`, `!= null` or the implicit `bool` conversion. NEVER use `?.`, `??`, `??=`, `is null`/`is not null` or `ReferenceEquals` as a liveness check on GameObjects, Components, ScriptableObjects or assets.** `ReferenceEquals` (or a cast to `System.Object`) is only for the rare case where you deliberately want the plain C# null check and a destroyed object must *not* count as null.
- *Why:* `UnityEngine.Object` overloads `==` to also check whether the native C++ object still exists (destroyed objects, and Editor-only "fake null" placeholders for unassigned fields). `?.`/`??`/`is null` cannot be overloaded, so they see a live C# wrapper around a dead object and your code then fails on the next member access. The custom operator is slower than a plain reference check, which is another reason not to do it per frame.
- *Source:* [Object manual — custom equality operators](../reference/scripting/manual-class-object.md), [Object.operator ==](../reference/scripting/scriptref-object-operator-eq.md), [Object implicit bool](../reference/scripting/scriptref-object-operator-object.md), [Programming best practices](../reference/scripting/manual-programming-best-practices.md), [Custom == operator blog](../reference/scripting/blog-custom-operator-should-we-keep-it.md), [ScriptableObject API](../reference/scripting/scriptref-scriptableobject.md).

```csharp
// ✅ Unity-aware
if (m_target == null)
{
    return;
}

if (!m_target)
{
    return;
}

Transform anchor = m_anchor != null ? m_anchor : transform;

// ❌ bypass the custom operator — a destroyed object slips through all of these
m_target?.SetActive(false);
Transform anchor2 = m_anchor ?? transform;
if (m_target is null)
{
    return;
}

// ✅ plain C# objects and delegates are normal: ?. is fine here
HealthChanged?.Invoke(m_currentHealth);
```

**Do not cache components across scene unloads without re-checking, and do not hold large assets in static fields.**
- *Why:* Cached wrappers outlive their native objects; statics keep assets alive across scenes.
- *Source:* [Programming best practices](../reference/scripting/manual-programming-best-practices.md).

## Finding objects and accessing components

**Prefer, in this order:** (1) a `[SerializeField]` reference assigned in the Inspector or prefab; (2) `GetComponent<T>()` on the own GameObject, cached in `Awake`; (3) `TryGetComponent` when absence is a valid case; (4) only outside gameplay code — bootstrap, tests, editor tooling — `FindFirstObjectByType<T>()` once in `Awake`/`Start`. Gameplay code wires its references (serialized fields, event channels, runtime sets) as [03 Architecture patterns](./03-architecture-patterns.md) prescribes. Declare hard dependencies with `[RequireComponent(typeof(T))]`.
- *Why:* `GetComponent` is documented as expensive enough to cache in `Awake` rather than call from `Update`; `TryGetComponent` does not allocate in the Editor when the component is missing; `RequireComponent` makes the `Awake` lookup unable to fail (it only adds the dependency when the component is added, so add it before teammates attach the script).
- *Source:* [Programming best practices](../reference/scripting/manual-programming-best-practices.md), [GameObject.GetComponent](../reference/scripting/scriptref-gameobject-getcomponent.md), [Component.TryGetComponent](../reference/scripting/scriptref-component-trygetcomponent.md), [RequireComponent](../reference/scripting/scriptref-requirecomponent.md).

**When a lookup is unavoidable, use the `ByType` family only; the `OfType` family is obsolete.** `FindFirstObjectByType<T>()` when identity matters, `FindAnyObjectByType<T>()` when any instance will do (faster), `FindObjectsByType<T>(FindObjectsSortMode.None)` for lists. Pass `FindObjectsInactive.Include` only when you really need inactive objects. Never call any of them per frame; they are "very resource intensive" and cannot find interfaces or assets.
- *Source:* [FindObjectOfType (obsolete)](../reference/scripting/scriptref-object-findobjectoftype.md), [FindFirstObjectByType](../reference/scripting/scriptref-object-findfirstobjectbytype.md), [FindAnyObjectByType](../reference/scripting/scriptref-object-findanyobjectbytype.md), [FindObjectsByType](../reference/scripting/scriptref-object-findobjectsbytype.md), [Upgrade to Unity 6.0 — FindObjectsOfType obsolete](../reference/unity6-release/manual-upgradeguideunity6.md).

**NEVER use `GameObject.Find`, `FindWithTag` or other string lookups in gameplay code.** In bootstrap/test/editor code call it once and cache; prefer `Transform.Find` for a child.
- *Source:* [GameObject.Find](../reference/scripting/scriptref-gameobject-find.md).

**Compare tags with `CompareTag("Player")`, never `gameObject.tag == "Player"`; cache `Camera.main` in `Awake`/`Start`.**
- *Why:* `CompareTag` is the documented API for tag checks (a `TagHandle` overload exists for hot paths); `Camera.main` has `GetComponent`-like cost per access.
- *Source:* [GameObject.CompareTag](../reference/scripting/scriptref-gameobject-comparetag.md), [Camera.main](../reference/scripting/scriptref-camera-main.md).

```csharp
private void OnTriggerEnter(Collider other)
{
    if (!other.CompareTag("Player"))
    {
        return;
    }

    if (other.TryGetComponent(out Health health))
    {
        health.ApplyDamage(m_damage);
    }
}
```

## Instantiate and Destroy

**Spawn from a typed prefab reference with the generic overload: `Instantiate(m_prefab, position, rotation)` or `Instantiate(m_prefab, parent, false)`.**
- *Why:* The generic overload returns the component type, so no casts. `Instantiate` clones the whole hierarchy with serialized state; `Awake`/`OnEnable` run immediately for active clones; the clone keeps the prefab's active state and gets no parent unless you pass one (with `parent`, the prefab's transform becomes *local* unless `worldPositionStays` is true).
- *Source:* [Object.Instantiate](../reference/scripting/scriptref-object-instantiate.md), [How Unity uses serialization — Instantiation](../reference/scripting/manual-script-serialization-how-unity-uses.md).

**Destroy with `Destroy(obj)` / `Destroy(obj, seconds)`; never `DestroyImmediate` in runtime code.** Destroying a GameObject destroys its components and children; destroying a component removes only that component. `Destroy` is safe on already-destroyed/null objects; the delay is scaled by `Time.timeScale`.
- *Why:* `Destroy` defers to after the current Update loop (before rendering), which avoids iterating-while-removing bugs; `DestroyImmediate` is Edit-mode only and errors inside physics/animation/render callbacks.
- *Source:* [Object.Destroy](../reference/scripting/scriptref-object-destroy.md), [Object.DestroyImmediate](../reference/scripting/scriptref-object-destroyimmediate.md), [Programming best practices](../reference/scripting/manual-programming-best-practices.md).

```csharp
[SerializeField] private Projectile m_projectilePrefab;
[SerializeField] private Transform m_muzzle;

private void Fire()
{
    Projectile projectile = Instantiate(m_projectilePrefab, m_muzzle.position, m_muzzle.rotation);
    projectile.Launch(m_muzzle.forward);
    Destroy(projectile.gameObject, 5f);
}
```

**Anything spawned more than a few times per second goes through `ObjectPool<T>`** — see [03 Architecture patterns](./03-architecture-patterns.md) and [05 Performance](./05-performance.md). **[project decision]**

**`DontDestroyOnLoad` only on root GameObjects, and only for the bootstrap scene's persistent services** (scene flow is defined in [11 Scenes, prefabs and workflow](./11-scenes-prefabs-workflow.md)).
- *Source:* [Object.DontDestroyOnLoad](../reference/scripting/scriptref-object-dontdestroyonload.md).

## Async: Awaitable and coroutines

**Default to `Awaitable` for anything asynchronous** (delays, waiting for frames, scene loads, background computation, awaiting `AsyncOperation`). Coroutines are acceptable for short frame/time sequences that never need cancellation or a result. No third-party async libraries. **[project decision]**
- *Why:* `Awaitable` is pooled (near-zero allocations), resumes synchronously in the same frame, knows about the main thread and `Update`/`FixedUpdate`, and supports cancellation tokens; `.NET Task` continuations wait for the next `Update` and capture a synchronization context.
- *Source:* [Introduction to Awaitable](../reference/scripting/manual-async-awaitable-introduction.md), [Awaitable continuations](../reference/scripting/manual-async-awaitable-continuations.md), [Programming best practices — thread safety](../reference/scripting/manual-programming-best-practices.md).

Rules for `Awaitable` code:

1. **Every `async Awaitable` method takes a `CancellationToken` and passes it to every `Awaitable.*Async` call.** MonoBehaviours pass `destroyCancellationToken` (cache it before destroying the object); non-MonoBehaviour code passes `Application.exitCancellationToken`.
   - *Why:* Unity does not stop background code on Play-mode exit, and a destroyed MonoBehaviour otherwise resumes and throws on the main thread.
   - *Source:* [destroyCancellationToken](../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md), [Application.exitCancellationToken](../reference/scripting/scriptref-application-exitcancellationtoken.md), [Awaitable continuations](../reference/scripting/manual-async-awaitable-continuations.md).
2. **Handle `OperationCanceledException`.** `WaitForSecondsAsync`, `NextFrameAsync` and friends throw it when the token fires; code after the `await` is skipped.
   - *Source:* [Awaitable.WaitForSecondsAsync](../reference/scripting/scriptref-awaitable-waitforsecondsasync.md), [Awaitable.NextFrameAsync](../reference/scripting/scriptref-awaitable-nextframeasync.md), [Awaitable API](../reference/scripting/scriptref-awaitable.md).
3. **Never await an `Awaitable` more than once or store it for later.** Pooled instances are recycled after the first await; a second await is undefined behaviour. If you need `WhenAll`-style composition, wrap in a `Task` via an `AsTask` extension as the manual shows — and accept the allocation.
   - *Source:* [Introduction to Awaitable](../reference/scripting/manual-async-awaitable-introduction.md), [Awaitable examples](../reference/scripting/manual-async-awaitable-examples.md).
4. **Only touch Unity APIs on the main thread.** After `await Awaitable.BackgroundThreadAsync()` you must `await Awaitable.MainThreadAsync()` before using any `UnityEngine` object; the switch is local to the current method. Background work is also unavailable on the Web platform (no managed threads), so keep it out of gameplay code unless the feature is desktop-only. **[project decision]**
   - *Source:* [Awaitable continuations](../reference/scripting/manual-async-awaitable-continuations.md), [IL2CPP limitations — threads](../reference/scripting/manual-scripting-restrictions.md).
5. **Never block the main thread on async work** (`Task.Result`, `Task.Wait`, `GetAwaiter().GetResult()`).
   - *Source:* [Programming best practices — thread safety](../reference/scripting/manual-programming-best-practices.md).
6. **Fire-and-forget entry points are `async void` methods that wrap the awaited body in `try/catch`.** Exceptions inside an `Awaitable` that nobody awaits are only rethrown when it is awaited (see `PropagateExceptionAndRelease` in `Awaitable.cs`), so an un-awaited `async Awaitable` swallows them silently. Catch `OperationCanceledException` and ignore it; log everything else with `Log.Exception(exception, this)`. **[project decision]**
   - *Source:* [Awaitable.cs (UnityCsReference 6000.3)](../reference/scripting/github-unitycsreference-awaitable-cs.md).
7. **Do not run a per-object `while (true) { await Awaitable.NextFrameAsync(); }` loop on many objects** — that is an `Update` with extra overhead.
   - *Source:* [Introduction to Awaitable](../reference/scripting/manual-async-awaitable-introduction.md).

```csharp
using System;
using System.Threading;
using RootsDance.Core;
using UnityEngine;

namespace RootsDance.Player
{
    public class PlayerHatch : MonoBehaviour
    {
        private static readonly int k_OpenHash = Animator.StringToHash("Open");

        [SerializeField] private float m_openDelay = 0.5f;
        [SerializeField] private Animator m_animator;

        public void RequestOpen()
        {
            OpenAsync(destroyCancellationToken);             // fire-and-forget entry point
        }

        private async void OpenAsync(CancellationToken cancellationToken)
        {
            try
            {
                await OpenSequenceAsync(cancellationToken);
            }
            catch (OperationCanceledException)
            {
                // Hatch was destroyed while waiting: nothing to do.
            }
            catch (Exception exception)
            {
                Log.Exception(exception, this);
            }
        }

        private async Awaitable OpenSequenceAsync(CancellationToken cancellationToken)
        {
            await Awaitable.WaitForSecondsAsync(m_openDelay, cancellationToken);   // resumes on the main thread
            m_animator.SetTrigger(k_OpenHash);
            await Awaitable.NextFrameAsync(cancellationToken);
        }
    }
}
```

Coroutine rules (when you do use them):
- Start with `StartCoroutine(MyRoutine())` and stop with the returned `Coroutine` (or the same `IEnumerator`); never the string overloads. Keep the handle in an `m_` field and stop it in `OnDisable`. **[project decision]**
- Cache yield instructions: `private readonly WaitForSeconds m_tick = new WaitForSeconds(0.5f);`. `yield return null` does not allocate; `new WaitForSeconds` does; lambdas in `WaitUntil`/`WaitWhile` allocate.
- Use `WaitForSecondsRealtime` for UI that must run while `Time.timeScale == 0`.
- A coroutine stops when its GameObject is deactivated or the MonoBehaviour is destroyed — but **not** when `enabled = false`.
- You may `yield return` an `Awaitable` (not `Awaitable<T>`) from a coroutine.
- *Source:* [Coroutines](../reference/scripting/manual-coroutines.md), [Yield instructions](../reference/scripting/manual-coroutines-yield-instructions.md), [WaitForSeconds](../reference/scripting/scriptref-waitforseconds.md), [StartCoroutine](../reference/scripting/scriptref-monobehaviour-startcoroutine.md), [StopCoroutine](../reference/scripting/scriptref-monobehaviour-stopcoroutine.md), [Programming best practices](../reference/scripting/manual-programming-best-practices.md).

**NEVER use `Invoke("MethodName", delay)` / `InvokeRepeating`.** Use `Awaitable.WaitForSecondsAsync` or a coroutine.
- *Why:* String-based, unrefactorable, cannot pass parameters; Unity's own page points to coroutines as the better-performing alternative.
- *Source:* [MonoBehaviour.Invoke](../reference/scripting/scriptref-monobehaviour-invoke.md).

## Events: C# `event` vs `UnityEvent`

**Code-to-code notification: a C# `event` (typically `Action`/`Action<T>`), named as a verb phrase in past/progressive tense, raised from an `On…` method. Designer-wired callbacks (a door that plays a sound chosen in the Inspector): a serialized `UnityEvent` field.** Cross-scene, decoupled communication goes through ScriptableObject event channels — see [03 Architecture patterns](./03-architecture-patterns.md). **[project decision]**
- *Why:* `UnityEvent`'s only advantage over C# events is Inspector serialization; it costs Inspector wiring that is invisible in code review and merge-prone in scene files. C# events stay in code where agents and diffs can see them.
- *Source:* [UnityEvent manual](../reference/scripting/manual-unity-events.md), [C# style e-book — Events](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md).

**Every `+=` / `AddListener` has a matching `-=` / `RemoveListener`, normally in `OnEnable`/`OnDisable`.** Static events are no exception — with domain reload disabled a leaked static subscription survives into the next Play session (see the Play-mode-exit fallback in the lifecycle section).
- *Why:* Subscriptions keep targets alive; `UnityEvent` silently skips a destroyed Unity-object target, while a C# event still invokes the handler on the dead wrapper, which then fails on its first member access.
- *Source:* [UnityEvent manual](../reference/scripting/manual-unity-events.md), [UnityEvent.RemoveListener](../reference/scripting/scriptref-events-unityevent-removelistener.md), [Domain reload disabled](../reference/scripting/manual-domain-reloading.md).

```csharp
using System;
using UnityEngine;
using UnityEngine.Events;

public class Health : MonoBehaviour
{
    [SerializeField] private UnityEvent m_died;          // designer hooks VFX/SFX here

    private int m_currentHealth;

    public event Action<int> HealthChanged;              // code subscribers

    public void ApplyDamage(int amount)
    {
        m_currentHealth -= amount;
        OnHealthChanged();
        if (m_currentHealth <= 0)
        {
            m_died.Invoke();
        }
    }

    private void OnHealthChanged()
    {
        HealthChanged?.Invoke(m_currentHealth);          // delegate, not a UnityEngine.Object: ?. is correct
    }
}
```

## Time

- **Multiply every per-frame change by `Time.deltaTime`** (`transform.position += direction * m_speed * Time.deltaTime`). Inside `FixedUpdate`, `Time.deltaTime` already returns `Time.fixedDeltaTime`, so the same expression is correct in both loops.
- **Use `Time.unscaledDeltaTime` / `WaitForSecondsRealtime` for pause menus and UI animation**; `Time.deltaTime` is 0 while `Time.timeScale == 0`.
- **Pause by setting `Time.timeScale = 0f`** (and restore to `1f`), never by disabling scripts one by one. **[project decision]**
- Do not treat `Time.deltaTime` as exact: it is capped by `Time.maximumDeltaTime`, can be tiny on the first frame, and is unreliable in `OnGUI`/UI callbacks.
- *Source:* [Per-frame updates](../reference/scripting/manual-time-per-frame-updates.md), [Fixed updates](../reference/scripting/manual-fixed-updates.md), [Time.deltaTime](../reference/scripting/scriptref-time-deltatime.md), [Time.unscaledDeltaTime](../reference/scripting/scriptref-time-unscaleddeltatime.md), [Time scale](../reference/scripting/manual-time-scale.md), [Handling variation in time](../reference/scripting/manual-time-handling-variations.md).

## Physics API (Unity 6 names)

**Use the Unity 6 member names.** `Rigidbody.velocity`, `drag` and `angularDrag` are `[Obsolete]` (compile warnings, API-Updater upgradable) and have no 6000.3 ScriptReference page; `PhysicMaterial` is obsolete-as-error. The full old→new table is in [10 Unity 6.3 facts](./10-unity6-facts.md).
- *Source:* [Rigidbody.deprecated.cs (6000.3)](../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md), [PhysicsMaterial.deprecated.cs (6000.3)](../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md), [Rigidbody.linearVelocity](../reference/scripting/scriptref-rigidbody-linearvelocity.md), [Rigidbody.linearDamping](../reference/scripting/scriptref-rigidbody-lineardamping.md), [Rigidbody.angularDamping](../reference/scripting/scriptref-rigidbody-angulardamping.md), [PhysicsMaterial](../reference/scripting/scriptref-physicsmaterial.md), [Rigidbody.bindings.cs (6000.3)](../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md).

**Move a dynamic Rigidbody with `AddForce` (choose the `ForceMode`) in `FixedUpdate`; move a kinematic Rigidbody with `MovePosition`/`MoveRotation` in `FixedUpdate`; set `linearVelocity` directly only for instantaneous changes such as a jump, never every physics step. Never drive a non-kinematic Rigidbody through `transform`.**
- *Why:* Transform writes bypass the simulation and break joints/contacts; `MovePosition` honours interpolation; forces accumulate until the next simulation step, so calling them from `Update` produces frame-rate-dependent results.
- *Source:* [Rigid body physics](../reference/scripting/manual-rigidbodiesoverview.md), [Rigidbody.AddForce](../reference/scripting/scriptref-rigidbody-addforce.md), [Rigidbody.MovePosition](../reference/scripting/scriptref-rigidbody-moveposition.md), [Rigidbody.linearVelocity](../reference/scripting/scriptref-rigidbody-linearvelocity.md), [Fixed updates](../reference/scripting/manual-fixed-updates.md).

**Collision and trigger callbacks:** `OnCollisionEnter/Stay/Exit` fire only if one side has a non-kinematic Rigidbody; `OnTriggerEnter/Stay/Exit` need at least one trigger collider and at least one physics-body collider. Both are delivered even to *disabled* MonoBehaviours. Omit the `Collision` parameter when you do not read it.
- *Source:* [OnCollisionEnter](../reference/scripting/scriptref-monobehaviour-oncollisionenter.md), [OnTriggerEnter](../reference/scripting/scriptref-monobehaviour-ontriggerenter.md).

```csharp
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player
{
    [RequireComponent(typeof(Rigidbody))]
    public class PlayerMover : MonoBehaviour
    {
        [SerializeField] private float m_moveForce = 20f;
        [SerializeField] private float m_jumpSpeed = 6f;

        private Rigidbody m_rigidbody;
        private InputAction m_moveAction;
        private InputAction m_jumpAction;
        private Vector2 m_moveInput;
        private bool m_jumpRequested;

        private void Awake()
        {
            m_rigidbody = GetComponent<Rigidbody>();
            m_moveAction = InputSystem.actions.FindAction("Player/Move");
            m_jumpAction = InputSystem.actions.FindAction("Player/Jump");
        }

        private void Update()
        {
            m_moveInput = m_moveAction.ReadValue<Vector2>();
            if (m_jumpAction.WasPressedThisFrame())          // one-shot input: read in Update, consume in FixedUpdate
            {
                m_jumpRequested = true;
            }
        }

        private void FixedUpdate()
        {
            Vector3 force = new Vector3(m_moveInput.x, 0f, m_moveInput.y) * m_moveForce;
            m_rigidbody.AddForce(force);                     // ForceMode.Force by default

            if (m_jumpRequested)
            {
                m_jumpRequested = false;
                Vector3 velocity = m_rigidbody.linearVelocity;
                velocity.y = m_jumpSpeed;
                m_rigidbody.linearVelocity = velocity;       // instantaneous change: allowed
            }
        }
    }
}
```

## Input System in code

**All input comes from the project-wide action asset (`Assets/RootsDance/Input/RootsDance.inputactions`) via `InputSystem.actions.FindAction("Map/Action")`, looked up once in `Awake` and stored in an `m_` field.** `UnityEngine.Input` (legacy Input Manager), `OnMouse*` callbacks and per-device reads (`Keyboard.current`) are not used in gameplay code.
- *Why:* Project-wide actions are preloaded and enabled automatically, so no asset references or `Enable()` calls are needed; the legacy Input Manager is deprecated and "will be removed in future versions of Unity". Qualify with the map name (`"Player/Move"`) to avoid ambiguity when two maps share an action name.
- *Source:* [About project-wide actions](../reference/packages/inputsystem-1-20-about-project-wide-actions.md), [Enabling actions](../reference/packages/inputsystem-1-20-enable-actions.md), [Quick start guide](../reference/packages/inputsystem-1-20-quick-start-guide.md), [Introduction to Input](../reference/scripting/manual-input-introduction.md), [Legacy Input](../reference/scripting/manual-inputlegacy.md); project-wide asset path and "no legacy Input" are **[project decision]**.

**Poll actions by type:** value actions with `ReadValue<Vector2>()` / `ReadValue<float>()`; button actions with `IsPressed()`, `WasPressedThisFrame()`, `WasReleasedThisFrame()`; interaction phases with `WasPerformedThisFrame()` / `WasCompletedThisFrame()`. Use callbacks (`performed += …`) only for genuinely event-like input such as UI confirm — and unsubscribe in `OnDisable`. **[project decision]**
- *Source:* [Polling actions](../reference/packages/inputsystem-1-20-polling-actions.md), [InputAction API](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputaction.md).

**Read `WasPressedThisFrame`/`WasReleasedThisFrame` in `Update` (the default *Process in Dynamic Update* mode), never in `FixedUpdate`.** Buffer the press in a field and consume it in `FixedUpdate`, as in the `PlayerMover` example.
- *Why:* With the default update mode, polling one-shot events in `FixedUpdate` misses or duplicates presses.
- *Source:* [Avoid missed or duplicate events](../reference/packages/inputsystem-1-20-timing-missed-duplicate-events.md).

Actions that are *not* project-wide (a second asset, or actions created in code) start disabled and must be enabled in `OnEnable` and disabled in `OnDisable`. The `ENABLE_INPUT_SYSTEM` symbol is defined in this project; do not write `#if ENABLE_LEGACY_INPUT_MANAGER` branches.
- *Source:* [Enabling actions](../reference/packages/inputsystem-1-20-enable-actions.md), [Scripting symbol reference](../reference/scripting/manual-scripting-symbol-reference.md).

## Logging

**All logging goes through the static class `RootsDance.Core.Log` in `Scripts/Runtime/Core/Log.cs`.** `Info` and `Warning` carry `[Conditional("UNITY_EDITOR")]` and `[Conditional("DEVELOPMENT_BUILD")]` so the call and its argument evaluation disappear from release builds; `Error` and `Exception` are unconditional. Every overload takes a `UnityEngine.Object context` — pass `this`, so clicking the message highlights the object in the Hierarchy. Direct `Debug.Log*` only inside `Log` and in `_Sandbox/`; `print()` never; no custom scripting symbols (no `SHENICEST_LOG`). **[project decision]**
- *Why:* `Debug` logging is not stripped from release builds; Unity's own recommendation is a `[Conditional]` wrapper keyed to symbols defined only in development. `UNITY_EDITOR || DEVELOPMENT_BUILD` is exactly what Unity's predefined `DEBUG` means, so no custom symbol is needed, and a `[Conditional]` method call is removed together with its arguments, so the string interpolation never runs in release.
- *Source:* [The Debug class — Excluding Debug code from non-development builds](../reference/testing-tooling/manual-class-debug.md), [Conditional compilation — Conditional attribute](../reference/scripting/manual-platform-dependent-compilation.md), [Scripting symbol reference](../reference/scripting/manual-scripting-symbol-reference.md), [Debug.Log](../reference/scripting/scriptref-debug-log.md), [Debug.LogException](../reference/testing-tooling/scriptref-debug-logexception.md).

```csharp
using System;
using System.Diagnostics;
using Debug = UnityEngine.Debug;

namespace RootsDance.Core
{
    public static class Log
    {
        [Conditional("UNITY_EDITOR"), Conditional("DEVELOPMENT_BUILD")]
        public static void Info(string message, UnityEngine.Object context)
        {
            Debug.Log(message, context);
        }

        [Conditional("UNITY_EDITOR"), Conditional("DEVELOPMENT_BUILD")]
        public static void Warning(string message, UnityEngine.Object context)
        {
            Debug.LogWarning(message, context);
        }

        public static void Error(string message, UnityEngine.Object context)
        {
            Debug.LogError(message, context);
        }

        public static void Exception(Exception exception, UnityEngine.Object context)
        {
            Debug.LogException(exception, context);
        }
    }
}
```

- **Severity:** `Log.Info` = developer information while a feature is in progress; `Log.Warning` = recoverable unexpected state (missing optional reference, fallback used); `Log.Error` = a bug or invalid setup that a human must fix; `Log.Exception(exception, this)` for caught exceptions. **[project decision]**
- **Never leave a log call in `Update`, `FixedUpdate`, `LateUpdate`, coroutines or per-entity loops.** Logging builds strings (allocation) and the Console cost is real in the Editor and development builds. Remove or downgrade to `Debug.Assert` before committing.
- **Use `Debug.Assert(condition, "message", this)` for invariants.** It compiles only when `UNITY_ASSERTIONS` is defined, so it costs nothing in release builds — never put side effects inside the condition.
- `Debug.DrawLine` / `Debug.DrawRay` are the fast way to visualise raycasts; keep them behind `#if UNITY_EDITOR || DEVELOPMENT_BUILD`.
- *Source:* [Debug](../reference/scripting/scriptref-debug.md), [Debug.Log](../reference/scripting/scriptref-debug-log.md), [Debug.Assert](../reference/scripting/scriptref-debug-assert.md), [Programming best practices — allocations](../reference/scripting/manual-programming-best-practices.md), [Scripting symbol reference](../reference/scripting/manual-scripting-symbol-reference.md).

## Assembly definitions and conditional compilation

**Every project script lives in exactly one of the four project assemblies** (folder layout in [02 Project structure](./02-project-structure.md)); the only exceptions are `Assets/ThirdParty/` and `Assets/_Sandbox/<user>/`, which compile into the predefined `Assembly-CSharp` and can never be referenced from `RootsDance.*`: **[project decision]**

| Assembly (`.asmdef`) | Folder | Platforms | References |
|---|---|---|---|
| `RootsDance.Runtime` | `Scripts/Runtime` | Any | `Unity.InputSystem`, `Unity.Cinemachine`; add `Unity.TextMeshPro` / `UnityEngine.UI` only if uGUI is actually used. Root Namespace `RootsDance`. |
| `RootsDance.Editor` | `Scripts/Editor` | **Editor only** | `RootsDance.Runtime` |

Test assemblies (`RootsDance.Tests.EditMode`, Editor only; `RootsDance.Tests.PlayMode`, Any Platform): exact JSON in [02 — assembly definitions](./02-project-structure.md). EditMode references `RootsDance.Runtime` and `RootsDance.Editor`; PlayMode references `RootsDance.Runtime`.

- *Why:* Code outside an asmdef lands in the predefined `Assembly-CSharp`, which custom assemblies (including the test assemblies) cannot reference and which recompiles on every change — that is also why `_Sandbox/` code can use `RootsDance.Runtime` but never leak back into it. Package assembly names come from the package API pages (`Unity.InputSystem.dll`, `Unity.Cinemachine.dll`, `Unity.TextMeshPro.dll`, `UnityEngine.UI.dll`).
- *Source:* [Introduction to assemblies](../reference/project-structure/manual-assembly-definitions-intro.md), [Referencing assemblies](../reference/project-structure/manual-assembly-definitions-referencing.md), [Edit mode and Play mode tests](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md), [InputAction API](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputaction.md), [CinemachineCamera API](../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md), [TMP_Text API](../reference/packages/ugui-2-0-tmpro-tmp-text.md).

Rules:
1. **Add a reference before using a type from another assembly** — in the Inspector's *Assembly Definition References* with **Use GUIDs unticked**, or by adding the assembly *name* to the `references` array of the JSON in [02](./02-project-structure.md); a missing reference is a compile error, not a warning. References from a custom assembly to `Assembly-CSharp` and cyclic references are impossible — if two assemblies need each other, merge them or invert the dependency.
   - *Source:* [Referencing assemblies](../reference/project-structure/manual-assembly-definitions-referencing.md), [Assembly Definition Inspector](../reference/project-structure/manual-class-assemblydefinitionimporter.md).
2. **Editor-only code goes in `RootsDance.Editor` (Platforms = Editor only).** Any `using UnityEditor;` that must live in a runtime file (custom `OnValidate` helpers, gizmo colours, menu items next to the runtime class) is wrapped in `#if UNITY_EDITOR … #endif` — the `using`, the fields and the methods — otherwise the Player build fails. A folder named `Editor` under a folder that has its own asmdef is **not** automatically Editor-only.
   - *Source:* [Creating assembly assets — Editor assembly](../reference/project-structure/manual-assembly-definitions-creating.md), [Introduction to assemblies — Editor folder](../reference/project-structure/manual-assembly-definitions-intro.md), [Conditional compilation](../reference/scripting/manual-platform-dependent-compilation.md), [How Unity uses serialization — Editor-only fields](../reference/scripting/manual-script-serialization-how-unity-uses.md).
3. **Test assemblies are created with Test Runner → *Create a new Test Assembly Folder*** (or *Assets > Create > Testing > Test Assembly Folder*), which writes the `nunit.framework.dll`, `UnityEngine.TestRunner` and `UnityEditor.TestRunner` references that mark an assembly as a test assembly; then add `RootsDance.Runtime` to its references. Keep the generated references and `defineConstraints` when editing the JSON by hand. EditMode test asmdefs keep `includePlatforms: ["Editor"]`; PlayMode ones leave platforms open. Test assemblies are excluded from Player builds — production code accidentally placed there will not ship. The canonical JSON for both files is in [02](./02-project-structure.md); how to write and run tests is in [08](./08-testing-tooling.md).
   - *Source:* [Create a test assembly](../reference/testing-tooling/manual-workflow-create-test-assembly.md), [Creating assembly assets — test assembly](../reference/project-structure/manual-assembly-definitions-creating.md), [Assembly Definition file format](../reference/project-structure/manual-assembly-definition-file-format.md).
4. **Prefer `#if` on Unity's built-in symbols only** (`UNITY_EDITOR`, `DEVELOPMENT_BUILD`, `UNITY_WEBGL`, `UNITY_STANDALONE`); `#if DEBUG` equals `UNITY_EDITOR || DEVELOPMENT_BUILD`. Do not add custom scripting symbols for a hackathon; use `Define Constraints` on an asmdef if a whole assembly is platform-specific. Never use `UNITY_64`.
   - *Source:* [Scripting symbol reference](../reference/scripting/manual-scripting-symbol-reference.md), [Conditional compilation](../reference/scripting/manual-platform-dependent-compilation.md).
5. `[Conditional("UNITY_EDITOR")]` does not suppress Unity event functions (`Awake`, `Update`…); Unity calls them regardless.
   - *Source:* [Conditional compilation — Conditional attribute](../reference/scripting/manual-platform-dependent-compilation.md).

## C# 9, runtime and platform limits

- **Language level is C# 9.0 (Roslyn).** Unsupported: init-only setters, records (they need `IsExternalInit` and are not serializable), covariant return types, module initializers. Project rule: **no records, no `init`** — not even with a shim. Target-typed `new()`, pattern matching, switch expressions, `using` declarations and static local functions are fine.
  - *Source:* [C# compiler and language version](../reference/csharp-style/manual-csharp-compiler.md).
- **Write code that works on both Mono and IL2CPP** (desktop players may ship either; IL2CPP is required on platforms without JIT, and the Web platform additionally has no managed threads): no `dynamic`, no `System.Reflection.Emit`, avoid reflection-driven code (stripping), add `where T : class` / `where T : struct` on hot generic methods, keep exception filters side-effect free.
  - *Source:* [IL2CPP limitations](../reference/scripting/manual-scripting-restrictions.md), [Scripting back ends](../reference/scripting/manual-scripting-backends.md).
- **No finalizers (`~MyClass()`), no `[ThreadStatic]`, no `WeakReference` to Unity objects.**
  - *Source:* [Programming best practices](../reference/scripting/manual-programming-best-practices.md), [Unity attributes](../reference/scripting/manual-unity-attributes.md), [Object manual](../reference/scripting/manual-class-object.md).
- Per-frame allocation rules (no LINQ, string building, boxing, closures in `Update`/`FixedUpdate`/hot paths) are owned by [05 Performance](./05-performance.md).
- **Static mutable state:** static fields are never restored by hot reload and survive Play sessions when domain reload is off. Keep statics to `readonly` caches (`Shader.PropertyToID`, `Animator.StringToHash`) and reset static *values* via `[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]` (static *event* handlers: see the lifecycle section).
  - *Source:* [How Unity uses serialization — hot reload](../reference/scripting/manual-script-serialization-how-unity-uses.md), [Domain reload disabled](../reference/scripting/manual-domain-reloading.md).

## Common pitfalls

- **`Renderer.material` silently clones the material** (and breaks SRP batching); read with `sharedMaterial`, never write per-instance values through `material` or `MaterialPropertyBlock` in URP — use a Material Variant asset or vertex colour as [05 Performance](./05-performance.md) and [07 Rendering](./07-rendering-urp.md) specify; cache any property ID you do need with `Shader.PropertyToID` in a `private static readonly int k_…`.
  - *Source:* [Renderer.material](../reference/scripting/scriptref-renderer-material.md), [Shader.PropertyToID](../reference/scripting/scriptref-shader-propertytoid.md); the URP batching rule is **[project decision]** owned by 05/07.
- **Animator parameters:** hash once with `Animator.StringToHash` (stable across sessions) instead of passing strings every call.
  - *Source:* [Animator.StringToHash](../reference/scripting/scriptref-animator-stringtohash.md).
- **`enabled = false` does not stop coroutines or async methods; `SetActive(false)` stops coroutines but not `Awaitable` methods** — cancellation tokens do. `SetActive` changes only `activeSelf`; check `activeInHierarchy` for the effective state.
  - *Source:* [Coroutines](../reference/scripting/manual-coroutines.md), [GameObject.SetActive](../reference/scripting/scriptref-gameobject-setactive.md).
- **`GetComponent<T>()` returns null for a script whose class cannot be loaded** (file name ≠ class name, duplicate class names) — see [01 C# style](./01-csharp-style.md) naming rules.
  - *Source:* [GameObject.GetComponent](../reference/scripting/scriptref-gameobject-getcomponent.md).
- **`FindObjectsByType` cannot search by interface**; find the concrete base component and filter.
  - *Source:* [FindObjectsByType](../reference/scripting/scriptref-object-findobjectsbytype.md).
- **`Destroy(obj, t)` does not tick while `Time.timeScale == 0`.**
  - *Source:* [Object.Destroy](../reference/scripting/scriptref-object-destroy.md).
- **`OnDestroy` is skipped for objects that were never active**, and is not a reliable save hook on mobile.
  - *Source:* [OnDestroy](../reference/scripting/scriptref-monobehaviour-ondestroy.md).
- **`SceneManager.sceneLoaded` fires after `OnEnable` and before `Start`** — do not expect `Start` to have run in that handler.
  - *Source:* [SceneManager.sceneLoaded](../reference/scripting/scriptref-scenemanagement-scenemanager-sceneloaded.md), [Execution order](../reference/scripting/manual-execution-order.md).
- **`Instantiate` of an inactive prefab yields an inactive clone** whose `Awake` has not run yet; it runs on the first `SetActive(true)`.
  - *Source:* [Object.Instantiate](../reference/scripting/scriptref-object-instantiate.md), [Awake](../reference/scripting/scriptref-monobehaviour-awake.md).
- **Two Unity objects can compare equal after Undo/recreate**, and `==` is not thread-safe — never compare Unity objects off the main thread.
  - *Source:* [Programming best practices](../reference/scripting/manual-programming-best-practices.md), [Custom == operator blog](../reference/scripting/blog-custom-operator-should-we-keep-it.md).

## Anti-patterns

- ❌ `public float speed;` for an Inspector value → ✅ `[SerializeField] private float m_speed;`
- ❌ `[SerializeField] public int Lives { get; set; }` → ✅ `[field: SerializeField] public int Lives { get; private set; }` (or a field)
- ❌ `m_target?.gameObject.SetActive(false)` / `m_camera ?? Camera.main` → ✅ `if (m_target != null) { … }` / `m_camera != null ? m_camera : Camera.main`
- ❌ `GetComponent<Rigidbody>().AddForce(...)` in `Update` → ✅ cache in `Awake`, call in `FixedUpdate`
- ❌ `FindObjectOfType<GameManager>()` → ✅ a serialized reference or event channel; in bootstrap/test code `FindFirstObjectByType<GameManager>()` once
- ❌ `GameObject.Find("Player")` each frame → ✅ a serialized reference or a runtime set ([03](./03-architecture-patterns.md))
- ❌ `other.gameObject.tag == "Enemy"` → ✅ `other.CompareTag("Enemy")`
- ❌ `transform.position += move;` on a non-kinematic Rigidbody → ✅ `m_rigidbody.MovePosition(...)` / `AddForce(...)` in `FixedUpdate`
- ❌ `m_rigidbody.velocity`, `.drag`, `PhysicMaterial` → ✅ `linearVelocity`, `linearDamping`, `PhysicsMaterial`
- ❌ `Input.GetAxis("Horizontal")`, `Input.GetKeyDown(KeyCode.Space)` → ✅ `m_moveAction.ReadValue<Vector2>()`, `m_jumpAction.WasPressedThisFrame()`
- ❌ `Invoke("Explode", 2f)` / `StartCoroutine("Blink")` → ✅ `Awaitable.WaitForSecondsAsync(2f, destroyCancellationToken)` / `m_blinkRoutine = StartCoroutine(Blink())`
- ❌ `await Task.Delay(500)` / `Task.Run(...)` → ✅ `await Awaitable.WaitForSecondsAsync(0.5f, token)` / `await Awaitable.BackgroundThreadAsync()` then `MainThreadAsync()`
- ❌ awaiting one stored `Awaitable` from two places → ✅ await once, or wrap in `Task` via `AsTask`
- ❌ `yield return new WaitForSeconds(0.1f)` inside a loop → ✅ cached `m_wait` field
- ❌ `DestroyImmediate(go)` in gameplay → ✅ `Destroy(go)`
- ❌ `Log.Info($"pos {transform.position}", this)` in `Update` → ✅ remove, or `Debug.Assert`, or Profiler (see [05](./05-performance.md))
- ❌ `Debug.Log("spawned", this)` / `print("spawned")` in gameplay code → ✅ `Log.Info("spawned", this)` (direct `Debug.Log*` only inside `Log.cs` and `_Sandbox/`)
- ❌ `using UnityEditor;` at the top of a runtime file → ✅ move to `RootsDance.Editor` or guard with `#if UNITY_EDITOR`
- ❌ `public record PlayerStats(...)` / `init` setters → ✅ `[Serializable] struct`/class with fields or `{ get; private set; }`
- ❌ mutating a ScriptableObject asset's fields as game state → ✅ runtime copy via `CreateInstance`/`Instantiate`, or keep state on a MonoBehaviour

## Review checklist

- [ ] No MonoBehaviour/ScriptableObject constructor; field initialisers touch no objects, components or assets (only `static readonly` ID caches).
- [ ] `Awake` touches only own components; `Start` does cross-object work; `OnEnable`/`OnDisable` subscriptions are symmetric.
- [ ] Inspector values are `[SerializeField] private` (or `[field: SerializeField]`); no `[SerializeField]` on properties; renamed fields carry `[FormerlySerializedAs]`.
- [ ] No `?.`, `??`, `is null` or `ReferenceEquals` as a liveness check on `UnityEngine.Object` types.
- [ ] No `GetComponent`, `Find*`, `Camera.main` or allocation-heavy calls inside `Update`/`FixedUpdate`/`LateUpdate`.
- [ ] No `FindObjectOfType`/`FindObjectsOfType`; no `Find*` in gameplay code; `FindObjectsByType` (bootstrap/tests/editor only) passes `FindObjectsSortMode.None`.
- [ ] Tags compared with `CompareTag`.
- [ ] `Destroy` not `DestroyImmediate`; spawned-often objects are pooled.
- [ ] Every `async Awaitable` method takes and forwards a `CancellationToken`; entry points are `async void` with `try/catch`; no double awaits; main thread restored before Unity API calls.
- [ ] Coroutines started/stopped by reference, yield instructions cached, no `Invoke(string)`.
- [ ] Movement scaled by `Time.deltaTime`; Rigidbody code in `FixedUpdate`; Unity 6 physics names used.
- [ ] Input read through `InputSystem.actions`; one-shot presses polled in `Update`; no `UnityEngine.Input`.
- [ ] C# `event` for code, `UnityEvent` only for Inspector wiring; all subscriptions removed.
- [ ] No log call in per-frame code; all logging goes through `RootsDance.Core.Log` with `this` as context; no direct `Debug.Log*` or `print()` outside `Log.cs`/`_Sandbox/`.
- [ ] File is inside the right asmdef (or under `ThirdParty/`/`_Sandbox/`); Editor-only code is in `RootsDance.Editor` or `#if UNITY_EDITOR`; tests are in a test assembly.
- [ ] No records/`init`, `dynamic`, finalizers, `[ThreadStatic]`, LINQ in hot paths; static mutable values have a `[RuntimeInitializeOnLoadMethod]` reset; static event handlers are unsubscribed.
- [ ] `Renderer.material` not used; no `MaterialPropertyBlock`; property IDs and animator hashes cached as `k_` statics.

## Sources

1. [../reference/scripting/manual-event-functions.md](../reference/scripting/manual-event-functions.md) — Event functions (Unity 6.3 Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html
2. [../reference/scripting/manual-execution-order.md](../reference/scripting/manual-execution-order.md) — Order of execution for event functions — https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html
3. [../reference/scripting/scriptref-monobehaviour-awake.md](../reference/scripting/scriptref-monobehaviour-awake.md) — MonoBehaviour.Awake() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html
4. [../reference/scripting/scriptref-monobehaviour-start.md](../reference/scripting/scriptref-monobehaviour-start.md) — MonoBehaviour.Start() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html
5. [../reference/scripting/scriptref-monobehaviour-onenable.md](../reference/scripting/scriptref-monobehaviour-onenable.md) — MonoBehaviour.OnEnable() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html
6. [../reference/scripting/scriptref-monobehaviour-ondisable.md](../reference/scripting/scriptref-monobehaviour-ondisable.md) — MonoBehaviour.OnDisable() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html
7. [../reference/scripting/scriptref-monobehaviour-ondestroy.md](../reference/scripting/scriptref-monobehaviour-ondestroy.md) — MonoBehaviour.OnDestroy() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDestroy.html
8. [../reference/scripting/scriptref-monobehaviour-onvalidate.md](../reference/scripting/scriptref-monobehaviour-onvalidate.md) — MonoBehaviour.OnValidate() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnValidate.html
9. [../reference/scripting/scriptref-monobehaviour-fixedupdate.md](../reference/scripting/scriptref-monobehaviour-fixedupdate.md) — MonoBehaviour.FixedUpdate() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html
10. [../reference/scripting/scriptref-monobehaviour-lateupdate.md](../reference/scripting/scriptref-monobehaviour-lateupdate.md) — MonoBehaviour.LateUpdate() — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html
11. [../reference/scripting/manual-class-monobehaviour.md](../reference/scripting/manual-class-monobehaviour.md) — MonoBehaviour (Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html
12. [../reference/scripting/manual-script-execution-order.md](../reference/scripting/manual-script-execution-order.md) — Script execution order — https://docs.unity3d.com/6000.3/Documentation/Manual/script-execution-order.html
13. [../reference/scripting/scriptref-defaultexecutionorder.md](../reference/scripting/scriptref-defaultexecutionorder.md) — DefaultExecutionOrder — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder.html
14. [../reference/scripting/scriptref-runtimeinitializeonloadmethodattribute.md](../reference/scripting/scriptref-runtimeinitializeonloadmethodattribute.md) — RuntimeInitializeOnLoadMethodAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html
15. [../reference/scripting/manual-domain-reloading.md](../reference/scripting/manual-domain-reloading.md) — Enter Play mode with domain reload disabled — https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html
16. [../reference/scripting/scriptref-scenemanagement-scenemanager-sceneloaded.md](../reference/scripting/scriptref-scenemanagement-scenemanager-sceneloaded.md) — SceneManager.sceneLoaded — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html
17. [../reference/scripting/manual-class-scriptableobject.md](../reference/scripting/manual-class-scriptableobject.md) — ScriptableObject (Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html
18. [../reference/scripting/scriptref-scriptableobject.md](../reference/scripting/scriptref-scriptableobject.md) — ScriptableObject (Scripting API) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html
19. [../reference/scripting/scriptref-scriptableobject-onenable.md](../reference/scripting/scriptref-scriptableobject-onenable.md) — ScriptableObject.OnEnable — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnEnable.html
20. [../reference/unity6-release/manual-upgradeguideunity63.md](../reference/unity6-release/manual-upgradeguideunity63.md) — Upgrade to Unity 6.3 — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html
21. [../reference/scripting/manual-script-serialization-rules.md](../reference/scripting/manual-script-serialization-rules.md) — Serialization rules — https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html
22. [../reference/scripting/scriptref-serializefield.md](../reference/scripting/scriptref-serializefield.md) — SerializeField — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html
23. [../reference/scripting/scriptref-serialization-formerlyserializedasattribute.md](../reference/scripting/scriptref-serialization-formerlyserializedasattribute.md) — FormerlySerializedAsAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.FormerlySerializedAsAttribute.html
24. [../reference/scripting/manual-script-serialization-best-practices.md](../reference/scripting/manual-script-serialization-best-practices.md) — Serialization best practices — https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-best-practices.html
25. [../reference/scripting/manual-script-serialization-how-unity-uses.md](../reference/scripting/manual-script-serialization-how-unity-uses.md) — How Unity uses serialization — https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-how-unity-uses.html
26. [../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) — Use a C# style guide for clean and scalable game code (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/f5vqx76rkt57bw9rjptcbcpv/Use_a_C__style_guide_for_clean_and_scalable_game_code_Unity_6_edition_e-book.pdf
27. [../reference/scripting/manual-class-object.md](../reference/scripting/manual-class-object.md) — Object (Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html
28. [../reference/scripting/scriptref-object-operator-eq.md](../reference/scripting/scriptref-object-operator-eq.md) — Object.operator == — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html
29. [../reference/scripting/scriptref-object-operator-object.md](../reference/scripting/scriptref-object-operator-object.md) — Object implicit bool operator — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html
30. [../reference/scripting/blog-custom-operator-should-we-keep-it.md](../reference/scripting/blog-custom-operator-should-we-keep-it.md) — Custom == operator, should we keep it? (Unity Blog) — https://unity.com/blog/engine-platform/custom-operator-should-we-keep-it
31. [../reference/scripting/manual-programming-best-practices.md](../reference/scripting/manual-programming-best-practices.md) — Unity programming best practices — https://docs.unity3d.com/6000.3/Documentation/Manual/programming-best-practices.html
32. [../reference/scripting/scriptref-gameobject-getcomponent.md](../reference/scripting/scriptref-gameobject-getcomponent.md) — GameObject.GetComponent — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html
33. [../reference/scripting/scriptref-component-trygetcomponent.md](../reference/scripting/scriptref-component-trygetcomponent.md) — Component.TryGetComponent — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html
34. [../reference/scripting/scriptref-requirecomponent.md](../reference/scripting/scriptref-requirecomponent.md) — RequireComponent — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RequireComponent.html
35. [../reference/scripting/scriptref-gameobject-comparetag.md](../reference/scripting/scriptref-gameobject-comparetag.md) — GameObject.CompareTag — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CompareTag.html
36. [../reference/scripting/scriptref-gameobject-find.md](../reference/scripting/scriptref-gameobject-find.md) — GameObject.Find — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.Find.html
37. [../reference/scripting/scriptref-camera-main.md](../reference/scripting/scriptref-camera-main.md) — Camera.main — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-main.html
38. [../reference/scripting/scriptref-object-findfirstobjectbytype.md](../reference/scripting/scriptref-object-findfirstobjectbytype.md) — Object.FindFirstObjectByType — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html
39. [../reference/scripting/scriptref-object-findanyobjectbytype.md](../reference/scripting/scriptref-object-findanyobjectbytype.md) — Object.FindAnyObjectByType — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html
40. [../reference/scripting/scriptref-object-findobjectsbytype.md](../reference/scripting/scriptref-object-findobjectsbytype.md) — Object.FindObjectsByType — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html
41. [../reference/scripting/scriptref-object-findobjectoftype.md](../reference/scripting/scriptref-object-findobjectoftype.md) — Object.FindObjectOfType (obsolete) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectOfType.html
42. [../reference/unity6-release/manual-upgradeguideunity6.md](../reference/unity6-release/manual-upgradeguideunity6.md) — Upgrade to Unity 6.0 — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html
43. [../reference/scripting/scriptref-object-instantiate.md](../reference/scripting/scriptref-object-instantiate.md) — Object.Instantiate — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html
44. [../reference/scripting/scriptref-object-destroy.md](../reference/scripting/scriptref-object-destroy.md) — Object.Destroy — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html
45. [../reference/scripting/scriptref-object-destroyimmediate.md](../reference/scripting/scriptref-object-destroyimmediate.md) — Object.DestroyImmediate — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html
46. [../reference/scripting/scriptref-object-dontdestroyonload.md](../reference/scripting/scriptref-object-dontdestroyonload.md) — Object.DontDestroyOnLoad — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html
47. [../reference/scripting/manual-async-awaitable-introduction.md](../reference/scripting/manual-async-awaitable-introduction.md) — Introduction to asynchronous programming with Awaitable — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-introduction.html
48. [../reference/scripting/manual-async-awaitable-continuations.md](../reference/scripting/manual-async-awaitable-continuations.md) — Awaitable completion and continuation — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-continuations.html
49. [../reference/scripting/manual-async-awaitable-examples.md](../reference/scripting/manual-async-awaitable-examples.md) — Awaitable code example reference — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html
50. [../reference/scripting/scriptref-awaitable.md](../reference/scripting/scriptref-awaitable.md) — Awaitable — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.html
51. [../reference/scripting/scriptref-awaitable-waitforsecondsasync.md](../reference/scripting/scriptref-awaitable-waitforsecondsasync.md) — Awaitable.WaitForSecondsAsync — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.WaitForSecondsAsync.html
52. [../reference/scripting/scriptref-awaitable-nextframeasync.md](../reference/scripting/scriptref-awaitable-nextframeasync.md) — Awaitable.NextFrameAsync — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Awaitable.NextFrameAsync.html
53. [../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md](../reference/scripting/scriptref-monobehaviour-destroycancellationtoken.md) — MonoBehaviour.destroyCancellationToken — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-destroyCancellationToken.html
54. [../reference/scripting/scriptref-application-exitcancellationtoken.md](../reference/scripting/scriptref-application-exitcancellationtoken.md) — Application.exitCancellationToken — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-exitCancellationToken.html
55. [../reference/scripting/github-unitycsreference-awaitable-cs.md](../reference/scripting/github-unitycsreference-awaitable-cs.md) — UnityCsReference 6000.3: Awaitable.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Runtime/Export/Scripting/Awaitable.cs
56. [../reference/scripting/manual-coroutines.md](../reference/scripting/manual-coroutines.md) — Write and run coroutines — https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html
57. [../reference/scripting/manual-coroutines-yield-instructions.md](../reference/scripting/manual-coroutines-yield-instructions.md) — Yield instruction reference — https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-yield-instructions.html
58. [../reference/scripting/scriptref-waitforseconds.md](../reference/scripting/scriptref-waitforseconds.md) — WaitForSeconds — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html
59. [../reference/scripting/scriptref-monobehaviour-startcoroutine.md](../reference/scripting/scriptref-monobehaviour-startcoroutine.md) — MonoBehaviour.StartCoroutine — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html
60. [../reference/scripting/scriptref-monobehaviour-stopcoroutine.md](../reference/scripting/scriptref-monobehaviour-stopcoroutine.md) — MonoBehaviour.StopCoroutine — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html
61. [../reference/scripting/scriptref-monobehaviour-invoke.md](../reference/scripting/scriptref-monobehaviour-invoke.md) — MonoBehaviour.Invoke — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Invoke.html
62. [../reference/scripting/manual-unity-events.md](../reference/scripting/manual-unity-events.md) — Inspector-configurable custom events (UnityEvent) — https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html
63. [../reference/scripting/scriptref-events-unityevent-removelistener.md](../reference/scripting/scriptref-events-unityevent-removelistener.md) — UnityEvent.RemoveListener — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Events.UnityEvent.RemoveListener.html
64. [../reference/scripting/manual-time-per-frame-updates.md](../reference/scripting/manual-time-per-frame-updates.md) — Per-frame updates — https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html
65. [../reference/scripting/manual-fixed-updates.md](../reference/scripting/manual-fixed-updates.md) — Fixed updates — https://docs.unity3d.com/6000.3/Documentation/Manual/fixed-updates.html
66. [../reference/scripting/scriptref-time-deltatime.md](../reference/scripting/scriptref-time-deltatime.md) — Time.deltaTime — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-deltaTime.html
67. [../reference/scripting/scriptref-time-unscaleddeltatime.md](../reference/scripting/scriptref-time-unscaleddeltatime.md) — Time.unscaledDeltaTime — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-unscaledDeltaTime.html
68. [../reference/scripting/manual-time-scale.md](../reference/scripting/manual-time-scale.md) — In-game time and real time — https://docs.unity3d.com/6000.3/Documentation/Manual/time-scale.html
69. [../reference/scripting/manual-time-handling-variations.md](../reference/scripting/manual-time-handling-variations.md) — Handling variation in time — https://docs.unity3d.com/6000.3/Documentation/Manual/time-handling-variations.html
70. [../reference/scripting/manual-rigidbodiesoverview.md](../reference/scripting/manual-rigidbodiesoverview.md) — Introduction to rigid body physics — https://docs.unity3d.com/6000.3/Documentation/Manual/RigidbodiesOverview.html
71. [../reference/scripting/scriptref-rigidbody-linearvelocity.md](../reference/scripting/scriptref-rigidbody-linearvelocity.md) — Rigidbody.linearVelocity — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearVelocity.html
72. [../reference/scripting/scriptref-rigidbody-lineardamping.md](../reference/scripting/scriptref-rigidbody-lineardamping.md) — Rigidbody.linearDamping — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-linearDamping.html
73. [../reference/scripting/scriptref-rigidbody-angulardamping.md](../reference/scripting/scriptref-rigidbody-angulardamping.md) — Rigidbody.angularDamping — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-angularDamping.html
74. [../reference/scripting/scriptref-rigidbody-addforce.md](../reference/scripting/scriptref-rigidbody-addforce.md) — Rigidbody.AddForce — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.AddForce.html
75. [../reference/scripting/scriptref-rigidbody-moveposition.md](../reference/scripting/scriptref-rigidbody-moveposition.md) — Rigidbody.MovePosition — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.MovePosition.html
76. [../reference/scripting/scriptref-physicsmaterial.md](../reference/scripting/scriptref-physicsmaterial.md) — PhysicsMaterial — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial.html
77. [../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md](../reference/scripting/github-unitycsreference-rigidbody-bindings-cs.md) — UnityCsReference 6000.3: Rigidbody.bindings.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/Rigidbody.bindings.cs
78. [../reference/scripting/scriptref-monobehaviour-oncollisionenter.md](../reference/scripting/scriptref-monobehaviour-oncollisionenter.md) — MonoBehaviour.OnCollisionEnter — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnCollisionEnter.html
79. [../reference/scripting/scriptref-monobehaviour-ontriggerenter.md](../reference/scripting/scriptref-monobehaviour-ontriggerenter.md) — MonoBehaviour.OnTriggerEnter — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html
80. [../reference/scripting/manual-input-introduction.md](../reference/scripting/manual-input-introduction.md) — Introduction to Input — https://docs.unity3d.com/6000.3/Documentation/Manual/input-introduction.html
81. [../reference/scripting/manual-inputlegacy.md](../reference/scripting/manual-inputlegacy.md) — Legacy Input — https://docs.unity3d.com/6000.3/Documentation/Manual/InputLegacy.html
82. [../reference/packages/inputsystem-1-20-about-project-wide-actions.md](../reference/packages/inputsystem-1-20-about-project-wide-actions.md) — About project-wide actions (Input System 1.20) — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html
83. [../reference/packages/inputsystem-1-20-polling-actions.md](../reference/packages/inputsystem-1-20-polling-actions.md) — Polling actions (Input System 1.20) — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/polling-actions.html
84. [../reference/packages/inputsystem-1-20-quick-start-guide.md](../reference/packages/inputsystem-1-20-quick-start-guide.md) — Input System quick start guide — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/quick-start-guide.html
85. [../reference/packages/inputsystem-1-20-enable-actions.md](../reference/packages/inputsystem-1-20-enable-actions.md) — Enabling actions (Input System 1.20) — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/enable-actions.html
86. [../reference/packages/inputsystem-1-20-timing-missed-duplicate-events.md](../reference/packages/inputsystem-1-20-timing-missed-duplicate-events.md) — Avoid missed or duplicate events (Input System 1.20) — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/timing-missed-duplicate-events.html
87. [../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputaction.md](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputaction.md) — InputAction API (Input System 1.20) — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html
88. [../reference/scripting/scriptref-debug.md](../reference/scripting/scriptref-debug.md) — Debug — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html
89. [../reference/scripting/scriptref-debug-log.md](../reference/scripting/scriptref-debug-log.md) — Debug.Log — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html
90. [../reference/scripting/scriptref-debug-assert.md](../reference/scripting/scriptref-debug-assert.md) — Debug.Assert — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Assert.html
91. [../reference/project-structure/manual-assembly-definitions-intro.md](../reference/project-structure/manual-assembly-definitions-intro.md) — Introduction to assemblies in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-intro.html
92. [../reference/project-structure/manual-assembly-definitions-referencing.md](../reference/project-structure/manual-assembly-definitions-referencing.md) — Referencing assemblies — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html
93. [../reference/project-structure/manual-assembly-definitions-creating.md](../reference/project-structure/manual-assembly-definitions-creating.md) — Creating assembly assets — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html
94. [../reference/project-structure/manual-class-assemblydefinitionimporter.md](../reference/project-structure/manual-class-assemblydefinitionimporter.md) — Assembly Definition Inspector window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html
95. [../reference/project-structure/manual-assembly-definition-file-format.md](../reference/project-structure/manual-assembly-definition-file-format.md) — Assembly Definition file format reference — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html
96. [../reference/testing-tooling/manual-workflow-create-test-assembly.md](../reference/testing-tooling/manual-workflow-create-test-assembly.md) — Create a test assembly — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html
97. [../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md) — Edit mode and Play mode tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/edit-mode-vs-play-mode-tests.html
98. [../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md](../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md) — CinemachineCamera API (assembly name) — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCamera.html
99. [../reference/packages/ugui-2-0-tmpro-tmp-text.md](../reference/packages/ugui-2-0-tmpro-tmp-text.md) — TMP_Text API (assembly name) — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/api/TMPro.TMP_Text.html
100. [../reference/scripting/manual-platform-dependent-compilation.md](../reference/scripting/manual-platform-dependent-compilation.md) — Conditional compilation in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html
101. [../reference/scripting/manual-scripting-symbol-reference.md](../reference/scripting/manual-scripting-symbol-reference.md) — Unity scripting symbol reference — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-symbol-reference.html
102. [../reference/csharp-style/manual-csharp-compiler.md](../reference/csharp-style/manual-csharp-compiler.md) — C# compiler and language version reference — https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html
103. [../reference/scripting/manual-scripting-restrictions.md](../reference/scripting/manual-scripting-restrictions.md) — IL2CPP limitations — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-restrictions.html
104. [../reference/scripting/manual-unity-attributes.md](../reference/scripting/manual-unity-attributes.md) — Unity attributes — https://docs.unity3d.com/6000.3/Documentation/Manual/unity-attributes.html
105. [../reference/scripting/scriptref-renderer-material.md](../reference/scripting/scriptref-renderer-material.md) — Renderer.material — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html
106. [../reference/scripting/scriptref-shader-propertytoid.md](../reference/scripting/scriptref-shader-propertytoid.md) — Shader.PropertyToID — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.PropertyToID.html
107. [../reference/scripting/scriptref-animator-stringtohash.md](../reference/scripting/scriptref-animator-stringtohash.md) — Animator.StringToHash — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html
108. [../reference/scripting/scriptref-gameobject-setactive.md](../reference/scripting/scriptref-gameobject-setactive.md) — GameObject.SetActive — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html
109. [../reference/scripting/manual-scripting-backends.md](../reference/scripting/manual-scripting-backends.md) — Scripting back ends — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html
110. [../reference/testing-tooling/manual-class-debug.md](../reference/testing-tooling/manual-class-debug.md) — The Debug class — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html
111. [../reference/testing-tooling/scriptref-debug-logexception.md](../reference/testing-tooling/scriptref-debug-logexception.md) — Debug.LogException — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogException.html
112. [../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md](../reference/scripting/github-unitycsreference-rigidbody-deprecated-cs.md) — UnityCsReference 6000.3: Rigidbody.deprecated.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/Rigidbody.deprecated.cs
113. [../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md](../reference/scripting/github-unitycsreference-physicsmaterial-deprecated-cs.md) — UnityCsReference 6000.3: PhysicsMaterial.deprecated.cs — https://raw.githubusercontent.com/Unity-Technologies/UnityCsReference/6000.3/Modules/Physics/ScriptBindings/PhysicsMaterial.deprecated.cs
