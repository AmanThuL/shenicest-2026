# 03. Architecture and design patterns

> **Scope:** How gameplay code is structured — which Unity type to use for what, SOLID applied to components, the ScriptableObject-based architecture (config, event channels, runtime sets, enum assets, pluggable behaviour), the approved patterns (observer, state, command, factory, object pool, MVP) and the one tolerated singleton, dependency wiring without a DI framework, and dependency direction between assemblies and namespaces.
> **Applies to:** all runtime C# under `Assets/SheNicest/Scripts/Runtime` (assembly `SheNicest.Runtime`) and the tests/editor code that references it.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

Naming and formatting are owned by [01 C# style](./01-csharp-style.md); folder layout by [02 Project structure](./02-project-structure.md); lifecycle semantics (`Awake`/`Start`/`OnEnable` ordering, null checks on Unity objects) by [04 Unity scripting rules](./04-unity-scripting-rules.md); measurements and profiling by [05 Performance](./05-performance.md). This document only decides *where code lives and how pieces talk to each other*.

## TL;DR — rules at a glance

1. **MUST** pick the type by role: **MonoBehaviour** for behaviour that lives in a scene and needs Unity callbacks; **ScriptableObject** for shared read-only config, enum-like assets, event channels, runtime sets and pluggable behaviour; **plain C# class** for logic with no Unity lifecycle (state machines, commands, models) so it can be EditMode-tested.
2. **MUST** give each component one responsibility. A `PlayerController` facade may coordinate `PlayerInputReader`, `PlayerMovement`, `PlayerAudio`; it does not implement them. Split any class that passes ~300 lines.
3. **MUST** wire dependencies with `[SerializeField]` references, `[RequireComponent]` + `GetComponent` in `Awake`, or constructor parameters for plain C# classes. **NEVER** call `FindFirstObjectByType`/`GameObject.Find` from gameplay code (unavoidable lookups in bootstrap, tests and editor tooling follow [04](./04-unity-scripting-rules.md#finding-objects-and-accessing-components)). No DI framework.
4. **MUST** communicate *across* features only through abstractions: an interface in `SheNicest.Core`, a ScriptableObject event channel (`SheNicest.Events`) or a data asset (`SheNicest.Data`). A feature namespace never references another feature's concrete types.
5. **MUST** use ScriptableObject **event channels** for cross-system messages, plain C# `event`s for intra-feature notifications, and `UnityEvent` only for designer-wired responses on a prefab.
6. **MUST** subscribe in `OnEnable` and unsubscribe in `OnDisable` (same pairs, same method group). Every `+=` has a matching `-=`.
7. **NEVER** add a singleton. The single tolerated static access point is `GameBootstrap` in the bootstrap scene, listed in this document; everything else uses references, channels or runtime sets.
8. **MUST** treat ScriptableObject assets as read-only at runtime. Runtime-mutable state lives in plain C# objects or MonoBehaviours, in a runtime set, or in an `Instantiate`/`CreateInstance` copy of the asset — never written back into the asset.
9. **MUST** use `UnityEngine.Pool.ObjectPool<T>` for anything spawned and destroyed repeatedly (projectiles, hit VFX, pickups). No hand-rolled pools.
10. **SHOULD** use the state pattern (`IState` + `StateMachine`) for actors and game flow once there are three or more states; an enum + `switch` is acceptable below that.
11. **SHOULD** use command objects only when actions need undo, replay or queuing; use a factory only when there is a real variety of products — otherwise `Instantiate` the prefab directly.
12. **MUST** keep UI logic in presenter MonoBehaviours (MVP): UXML/USS is the view, the model is a plain C# object or ScriptableObject, and gameplay code never queries UI elements. Runtime data binding **MAY** replace presenter boilerplate for read-only displays.
13. **SHOULD** prefer composition and interfaces over inheritance. A MonoBehaviour hierarchy is at most one abstract base deep; interfaces add capabilities.
14. **MUST** keep assembly dependencies one-directional: Tests.EditMode → Editor → Runtime, Tests.PlayMode → Runtime; `SheNicest.Runtime` references no project assembly (canonical asmdef JSON in [02](./02-project-structure.md)). Unity rejects cycles.
15. **SHOULD** apply KISS: a pattern earns its place only when the problem it solves is already present. Do not pre-build factories, command buffers or hierarchical state machines for a hackathon feature that does not need them.

## Choosing the type: MonoBehaviour, ScriptableObject or plain C#

Use this table before creating a class. **[project decision]** on top of Unity's comparison.

| Need | Use | Why |
|---|---|---|
| Behaviour attached to a scene object; needs `Update`, collisions, coroutines, `transform` | **MonoBehaviour** | Only MonoBehaviours receive player-loop callbacks and sit on GameObjects. |
| Shared, designer-editable, unchanging data (stats, spawn tables, audio sets, level layouts) | **ScriptableObject** asset | One copy in memory, referenced by many; edits are asset-level and merge-friendly; no Transform overhead. |
| A category or identity to compare (team, damage type, item slot) | **ScriptableObject** "enum asset" | Reorder/rename safe, extendable with fields and methods. |
| A message between systems that must not know each other | **ScriptableObject** event channel | Project-level asset reachable from any scene, survives scene loads, replaces singleton access. |
| A list of live scene objects reachable from anywhere (enemies, checkpoints) | **ScriptableObject** runtime set | Cheaper than `Find*`, no singleton. |
| Interchangeable behaviour a designer picks in the Inspector (AI brain, ability, audio variation) | **ScriptableObject** delegate object (strategy) | Drag-and-drop swapping; behaviour without a scene object. |
| Pure logic: state machine, command, model, calculators, parsers | **Plain C# class / struct** | No Unity lifecycle, constructor injection, EditMode-testable without Play mode. |
| Persistent save data | **Plain serializable C# class → JSON** | ScriptableObject changes are not saved in a Player build; SO data is read-only for persistence purposes. |

- *Why:* ScriptableObjects do not receive most lifecycle callbacks (only `Awake`, `OnEnable`, `OnDisable`, `OnDestroy`, plus `OnValidate`/`Reset` in the Editor), cannot reference scene objects, and persist Editor-time changes; MonoBehaviours carry a GameObject and Transform and reset when leaving Play mode. Plain classes are the only ones that can be constructed and tested in isolation.
- *Source:* [SO e-book, "ScriptableObjects versus MonoBehaviours", "Callbacks and messages", "ScriptableObject data versus persistent data"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md); [Manual: ScriptableObject](../reference/scripting/manual-class-scriptableobject.md); [Separate game data and logic](../reference/design-patterns/how-to-separate-game-data-logic-scriptable-objects.md).

Rules that follow from the table:

- **MUST NOT** store static gameplay data (max health, speeds, prices) as fields on MonoBehaviours placed more than once. Move it into a `...ConfigSO` and reference it. *Source:* [SO e-book, "Refactoring example"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md); [Get started with the SO demo — "6 best practices"](../reference/design-patterns/how-to-get-started-with-scriptableobjects-demo.md).
- **MUST NOT** use ScriptableObjects as persistent save data or for per-instance mutable state. *Source:* same.
- **SHOULD** extract any logic that does not touch `UnityEngine` objects into a plain class so the EditMode tests in [08 Testing](./08-testing-tooling.md) can cover it. **[project decision]**

```csharp
// ✅ Shared config as an asset, unique runtime state on the component.
[CreateAssetMenu(fileName = "EnemyConfig", menuName = "SheNicest/Config/Enemy")]
public class EnemyConfigSO : ScriptableObject
{
    [SerializeField] private int m_maxHealth = 100;
    [SerializeField] private float m_moveSpeed = 3f;

    public int MaxHealth => m_maxHealth;
    public float MoveSpeed => m_moveSpeed;
}

public class EnemyHealth : MonoBehaviour
{
    [SerializeField] private EnemyConfigSO m_config;

    private int m_currentHealth;

    private void Awake()
    {
        m_currentHealth = m_config.MaxHealth;
    }
}
```

Class-name suffix: ScriptableObject class names end in `SO` (`EnemyConfigSO`, `VoidEventChannelSO`), as Unity's e-book does; asset files do not carry the suffix. Rule owned by [01 C# style](./01-csharp-style.md); asset naming by [02 Project structure](./02-project-structure.md).

## SOLID, applied to components

The five principles are the reasoning behind every rule below; the e-book is the source for all of them ([Level up your code with design patterns and SOLID, "The SOLID principles"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md)).

### Single responsibility and component granularity

- **MUST** give each MonoBehaviour one reason to change. Input, movement, audio and VFX are separate components, exactly like Unity's own `MeshFilter`/`Renderer`/`Rigidbody` split.
- **MAY** add a thin facade component (`PlayerController`) that holds references to the parts and exposes a small public API to the rest of the game.
- **SHOULD** split a class that exceeds ~300 lines; **SHOULD NOT** go to the other extreme of one-method classes. The e-book quotes 200–300 lines as a common limit; we use 300. **[project decision]**
- *Why:* short classes are readable, replaceable and reusable; a `PlayerController` that moves, plays sounds and reads input cannot be changed without touching all three.
- *Source:* [e-book, "Single-responsibility principle"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

```csharp
// ✅ Facade coordinates; each part owns one job.
[RequireComponent(typeof(PlayerInputReader), typeof(PlayerMovement), typeof(PlayerAudio))]
public class PlayerController : MonoBehaviour
{
    private PlayerInputReader m_input;
    private PlayerMovement m_movement;
    private PlayerAudio m_audio;

    private void Awake()
    {
        m_input = GetComponent<PlayerInputReader>();
        m_movement = GetComponent<PlayerMovement>();
        m_audio = GetComponent<PlayerAudio>();
    }
}

// ❌ One component that reads input, moves the transform and plays SFX in OnTriggerEnter.
```

Never name a class after its feature folder (`Player` in `SheNicest.Player`): from any other namespace the simple name resolves to the namespace and does not compile (see [02](./02-project-structure.md)). Likewise never reuse a Unity type name such as `PlayerInput` (the Input System component that [09](./09-packages-systems.md) bans) — hence `PlayerInputReader`.

### Open–closed

- **MUST** add behaviour by adding a class (new state, new ability SO, new `IDamageable` implementer), not by adding a `case` to a `switch` in an existing class. When you find yourself extending a `switch` over an enum for the second time, convert to an abstract class / interface.
- *Source:* [e-book, "Open-closed principle"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md); [Strategy pattern](../reference/design-patterns/course-strategy-pattern.md).

### Liskov substitution and composition over inheritance

- **SHOULD** keep MonoBehaviour inheritance to at most one abstract base (`EnemyBase : MonoBehaviour`, `Archer : EnemyBase`). Deeper trees are a smell; capabilities go into interfaces or sibling components. **[project decision]**
- **NEVER** override a base method with an empty body or `throw new NotImplementedException()` — that is the textbook LSP violation. If a subclass cannot honour the base contract, the hierarchy is wrong.
- **SHOULD** use an abstract class to share *implementation*, an interface to declare a *capability*. A class inherits one base but implements many interfaces.
- *Source:* [e-book, "Liskov substitution principle", "Interfaces versus abstract classes"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

### Interface segregation

- **MUST** keep interfaces small and capability-shaped: `IDamageable`, `IInteractable`, `ISwitchable`, `IExplodable`. A crate implements `IDamageable` without being forced to carry movement members.
- *Source:* [e-book, "Interface segregation principle"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

### Dependency inversion

- **MUST** make the high-level object depend on an interface, not on the concrete low-level class: a `Switch` toggles an `ISwitchable`, not a `Door`. This is what lets a feature stay closed for modification when a new door type appears.
- *Source:* [e-book, "Dependency inversion principle"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

## Wiring dependencies without a DI framework

We use no DI container (no Zenject/VContainer/Extenject). Unity's own mechanisms are enough for a hackathon and keep the Inspector as the single source of truth for wiring. **[project decision]**

Use, in this order of preference:

1. **Serialized reference** — `[SerializeField] private SomeComponent m_thing;` assigned in the prefab/scene. Default for anything on another GameObject or a ScriptableObject asset. *Source:* [SO e-book, "What are ScriptableObjects?"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).
2. **Same-GameObject component** — declare `[RequireComponent(typeof(T))]` and cache with `GetComponent<T>()` in `Awake`. `RequireComponent` adds the dependency automatically when the script is added, so `GetComponent` cannot return null on a correctly set-up prefab — the check runs only when the script is added (`AddComponent`), so when you add `[RequireComponent]` to a script that is already on objects, add the missing component by hand. *Source:* [RequireComponent](../reference/scripting/scriptref-requirecomponent.md); [Programming best practices — cache `GetComponent` in `Awake`](../reference/scripting/manual-programming-best-practices.md).
3. **Constructor parameters** — for plain C# classes (`new StateMachine(this)`, `new MoveCommand(mover, delta)`). *Source:* [e-book, "State pattern"/"Command pattern"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).
4. **Interface through a serialized concrete field** — Unity does not serialize interface-typed fields. Serialize a `MonoBehaviour` (or `ScriptableObject`) field and cast once in `Awake`. *Source:* [e-book, "Serializing interfaces"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).
5. **`[SerializeReference]`** — only for polymorphic *plain* serializable classes inside a host object (e.g. a list of `IEffect` data entries). Not for `UnityEngine.Object` types, not for sharing between hosts (use a ScriptableObject for that). *Source:* [SerializeReference](../reference/scripting/scriptref-serializereference.md).
6. **Event channel / runtime set** — when the dependency is "something, somewhere, that I should not know about". See below.

```csharp
public interface ISwitchable
{
    bool IsActive { get; }
    void Activate();
    void Deactivate();
}

// ✅ Interface dependency serialized through a concrete Unity object.
public class Switch : MonoBehaviour
{
    [SerializeField] private MonoBehaviour m_clientSource; // must implement ISwitchable

    private ISwitchable m_client;

    private void Awake()
    {
        m_client = m_clientSource as ISwitchable;
        Debug.Assert(m_client != null, "Assigned client does not implement ISwitchable.", this);
    }

    public void Toggle()
    {
        if (m_client.IsActive)
        {
            m_client.Deactivate();
        }
        else
        {
            m_client.Activate();
        }
    }
}
```

- **NEVER** use `FindFirstObjectByType`, `FindAnyObjectByType`, `FindObjectsByType`, `GameObject.Find` or `FindWithTag` in gameplay (feature-namespace) code, and never per frame. The API itself documents the call as "very resource intensive". Lookups are tolerated only where wiring is impossible — the `GameBootstrap` accessor below, test fixtures and editor tooling — and then follow the `ByType`-family rules in [04](./04-unity-scripting-rules.md#finding-objects-and-accessing-components) (once, cached, never the obsolete `OfType` family). *Source:* [Object.FindFirstObjectByType](../reference/scripting/scriptref-object-findfirstobjectbytype.md); [Runtime set how-to](../reference/design-patterns/how-to-scriptableobject-based-runtime-set.md).
- **SHOULD** validate required references in `Awake` with `Debug.Assert(..., this)` so a missing Inspector link fails loudly at the object that owns it (Unity's PaddleBallSO sample does this with a `NullRefChecker`). **[project decision]** *Source:* [Debug.Assert](../reference/scripting/scriptref-debug-assert.md) (`Assert(condition, message, context)` overload); [Event channels how-to, "Loose coupling, high cohesion" — the sample's `NullRefChecker`](../reference/design-patterns/how-to-scriptableobjects-event-channels-game-code.md); assertion-stripping rules in [04 Logging](./04-unity-scripting-rules.md#logging).

## ScriptableObject architecture

Five patterns, all from Unity's ScriptableObject e-book. Where the code lives: event-channel classes in `Scripts/Runtime/Events/` (`SheNicest.Events`); ScriptableObject class definitions (config, enum assets, runtime sets, delegate-object bases) in `Scripts/Runtime/Data/` (`SheNicest.Data`), or in the feature folder that alone uses them; contracts (`IState`, `ICommand`, capability interfaces) in `SheNicest.Core`. SO *instances* go to `Assets/SheNicest/Data/<Type>/` (`Data/Events/`, `Data/Config/`, `Data/Levels/`…), one logical thing per asset — see [02 Project structure](./02-project-structure.md). **[project decision]**

### Data containers (read-only config)

Covered above. Additional rules:

- **MUST** expose config through read-only properties over `[SerializeField] private` fields; use `[Range]`/`OnValidate` to keep designer input sane. *Source:* [SO e-book, "Code conventions in this guide", "Architectural benefits"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).
- **MUST** lay out designer-facing *content* assets (investigation objects, plants, puzzles, journal/report entries) with the Odin attributes and the five standard sections defined in [12 Odin Inspector](./12-odin-inspector.md) — the class shape here does not change; Odin only decorates the Inspector, never the serialization. **[project decision]**
- **MUST NOT** mutate a shared config asset at runtime. In the Editor such changes survive exiting Play mode (the asset is not reset) and reach disk on the next save, so they surface as stale state in the next Play session and as modified `.asset` files in Git; in a build they are lost anyway. If an object needs its own mutable copy of SO data, create it with `Instantiate(asset)` or `ScriptableObject.CreateInstance<T>()` and treat the asset as a template. *Source:* [SO e-book, "Modifying ScriptableObject data", "ScriptableObject data versus persistent data"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).
- **SHOULD NOT** use the "ScriptableObject variable" pattern (`IntVariableSO` holding one mutable `value`) for runtime state. Same reason: Editor persistence makes it a merge-conflict and stale-state generator. Runtime state is a C# field, a MonoBehaviour, or a runtime set. **[project decision]**

### Enum-like assets

- **SHOULD** model identities that designers create or compare (team, damage type, item category, player ID) as empty or near-empty ScriptableObjects, compared by reference. Adding, renaming or reordering assets never breaks serialized data, unlike C# enums whose integer values shift. **MAY** put comparison logic on the asset (`IsWinner(other)`).
- **MAY** still use a C# enum for fixed, code-only sets (e.g. `GameState`) that designers never touch.
- *Source:* [SO-based enums](../reference/design-patterns/how-to-scriptableobject-based-enums.md); [SO e-book, "The Extendable enums pattern"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).

```csharp
[CreateAssetMenu(fileName = "Team", menuName = "SheNicest/Enums/Team")]
public class TeamSO : ScriptableObject
{
}

// Usage: reference equality is the comparison.
public bool IsAlly(TeamSO other)
{
    return m_team == other;
}
```

### Delegate objects (strategy)

- **SHOULD** encapsulate swappable behaviour (enemy brain, ability, audio variation) as an abstract ScriptableObject with one method that receives the scene context as a parameter. The MonoBehaviour calls it; the SO never calls into the player loop itself and never stores per-instance state (it is shared by every user of the asset).
- *Source:* [SO e-book, "Pattern: Delegate objects"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md); [Delegate objects how-to](../reference/design-patterns/how-to-scriptableobjects-delegate-objects.md); [e-book, "Strategy pattern"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

```csharp
public abstract class EnemyBrainSO : ScriptableObject
{
    // All scene context comes in as parameters; the asset holds no per-enemy state.
    public abstract void Tick(EnemyController enemy, float deltaTime);
}

[CreateAssetMenu(fileName = "PatrolBrain", menuName = "SheNicest/AI/Patrol Brain")]
public class PatrolBrainSO : EnemyBrainSO
{
    [SerializeField] private float m_speed = 2f;

    public override void Tick(EnemyController enemy, float deltaTime)
    {
        enemy.MoveAlongPatrol(m_speed * deltaTime);
    }
}
```

### Event channels (observer across systems)

- **MUST** route messages between systems (gameplay → UI, gameplay → audio, input → gameplay, game flow → everything) through ScriptableObject event channels. The broadcaster and the listener both reference the channel asset; neither references the other.
- **MUST** implement channels with a C# `event` of type `System.Action` / `Action<T>` plus a public `RaiseEvent` method. The `event` keyword prevents listeners from invoking the delegate. `UnityAction` is reserved for `UnityEvent` fields on listener components. **[project decision — the e-book allows either]**
- **MUST** mark channel fields with `[Header("Listens to")]` / `[Header("Broadcasts on")]` so the flow can be traced in the Inspector.
- **MUST** subscribe in `OnEnable` and unsubscribe in `OnDisable`. A listener destroyed while subscribed leaves a dangling delegate in a project-level asset; with domain reload disabled that delegate survives into the next Play session.
- **SHOULD** create one concrete channel type per payload (`VoidEventChannelSO`, `IntEventChannelSO`, `Vector3EventChannelSO`, `GameObjectEventChannelSO`) from one generic base; add a small struct payload type when more than one value is needed. **[project decision — the how-to uses `GenericEventChannelSO<T,U>`; one struct per message keeps a single generic base and matches 01's "custom args struct" rule]**
- **MAY** add an Editor-only `[CustomEditor]` with a "Raise Event" button in `SheNicest.Editor` for debugging.
- *Source:* [Event channels how-to](../reference/design-patterns/how-to-scriptableobjects-event-channels-game-code.md); [SO e-book, "The Observer pattern", "Static versus non-static events", "Debugging event channels"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md); [Domain reload — static events keep subscribers](../reference/scripting/manual-domain-reloading.md).

```csharp
using System;
using UnityEngine;

namespace SheNicest.Events
{
    [CreateAssetMenu(fileName = "VoidEventChannel", menuName = "SheNicest/Events/Void Event Channel")]
    public class VoidEventChannelSO : ScriptableObject
    {
        public event Action EventRaised;

        public void RaiseEvent()
        {
            EventRaised?.Invoke();
        }
    }

    public abstract class GenericEventChannelSO<T> : ScriptableObject
    {
        public event Action<T> EventRaised;

        public void RaiseEvent(T payload)
        {
            EventRaised?.Invoke(payload);
        }
    }

    [CreateAssetMenu(fileName = "IntEventChannel", menuName = "SheNicest/Events/Int Event Channel")]
    public class IntEventChannelSO : GenericEventChannelSO<int>
    {
    }
}
```

```csharp
// ✅ Listener: symmetric subscribe/unsubscribe, no reference to the broadcaster.
public class ScoreHud : MonoBehaviour
{
    [Header("Listens to")]
    [SerializeField] private IntEventChannelSO m_scoreChanged;

    private void OnEnable()
    {
        m_scoreChanged.EventRaised += ScoreChanged_EventRaised;
    }

    private void OnDisable()
    {
        m_scoreChanged.EventRaised -= ScoreChanged_EventRaised;
    }

    private void ScoreChanged_EventRaised(int score)
    {
        // update the view
    }
}

// ✅ Broadcaster: raises, does not care who listens.
public class ScoreKeeper : MonoBehaviour
{
    [Header("Broadcasts on")]
    [SerializeField] private IntEventChannelSO m_scoreChanged;

    private int m_score;

    public void AddPoints(int points)
    {
        m_score += points;
        m_scoreChanged.RaiseEvent(m_score);
    }
}
```

Codeless listener for designers (wire a sound or particle response on a prefab without code):

```csharp
using UnityEngine;
using UnityEngine.Events;

public class VoidEventListener : MonoBehaviour
{
    [SerializeField] private VoidEventChannelSO m_channel;
    [SerializeField] private UnityEvent m_response;

    private void OnEnable()
    {
        if (m_channel != null)
        {
            m_channel.EventRaised += Channel_EventRaised;
        }
    }

    private void OnDisable()
    {
        if (m_channel != null)
        {
            m_channel.EventRaised -= Channel_EventRaised;
        }
    }

    private void Channel_EventRaised()
    {
        m_response.Invoke();
    }
}
```

Input: project-wide Input Actions are the broadcaster (see [09 Packages and systems](./09-packages-systems.md)). An `InputReaderSO` that relays `InputAction` callbacks as channel events **MAY** be added if more than two or three components consume input; the e-book notes it is overkill for a small game. **[project decision]** *Source:* [SO e-book, "Example: InputReader"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).

### Runtime sets

- **SHOULD** track live scene objects that other systems need to enumerate (enemies, checkpoints, pickups) in a `RuntimeSetSO<T>` asset. Each component adds itself in `OnEnable` and removes itself in `OnDisable`, so prefabs register automatically and the set empties when the scene unloads.
- **MUST** keep the list non-serialized (private field) — a ScriptableObject cannot serialize scene objects and would show "Type mismatch".
- *Source:* [Runtime set how-to](../reference/design-patterns/how-to-scriptableobject-based-runtime-set.md); [SO e-book, "The Runtime Set pattern"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).

```csharp
using System.Collections.Generic;
using UnityEngine;

public abstract class RuntimeSetSO<T> : ScriptableObject
{
    private readonly List<T> m_items = new List<T>();

    public IReadOnlyList<T> Items => m_items;

    public void Add(T item)
    {
        if (!m_items.Contains(item))
        {
            m_items.Add(item);
        }
    }

    public void Remove(T item)
    {
        m_items.Remove(item);
    }
}

[CreateAssetMenu(fileName = "EnemyRuntimeSet", menuName = "SheNicest/Runtime Sets/Enemy")]
public class EnemyRuntimeSetSO : RuntimeSetSO<EnemyController>
{
}

public class EnemyController : MonoBehaviour
{
    [SerializeField] private EnemyRuntimeSetSO m_runtimeSet;

    private void OnEnable()
    {
        m_runtimeSet.Add(this);
    }

    private void OnDisable()
    {
        m_runtimeSet.Remove(this);
    }
}
```

## Observer: which event mechanism to use

| Situation | Use | Notes |
|---|---|---|
| Components inside one feature/prefab (e.g. `Health` → `HealthBar` on the same enemy) | C# `event Action`/`Action<T>` on the subject | Fastest, typed, no asset; observer holds a serialized reference to the subject. |
| Between features or systems (gameplay ↔ UI ↔ audio ↔ game flow) | ScriptableObject event channel | No direct reference, survives scene loads. |
| Designer-authored response on a prefab (play a clip, toggle a light) | `UnityEvent` field on a listener component | Configurable in the Inspector; slower than C# events; not for hot paths. |
| Global, code-only event bus (`static class GameEvents`) | **Not used** | Static events are invisible in the Inspector and keep subscribers alive across Play sessions when domain reload is off. **[project decision]** |

- **MUST** name the event as a verb phrase (`HealthChanged`, `DoorOpened`), raise it from `On<Event>()` in the publisher, and name the subscriber's handler `<Subject>_<Event>` — rules and examples in [01 C# style](./01-csharp-style.md#events-and-handlers).
- **MUST** raise C# events with `?.Invoke()` from the `On<Event>()` method — see [01](./01-csharp-style.md#events-and-handlers). Event-channel assets are the exception: they keep the how-to's public `RaiseEvent()` because the broadcaster component, not the asset, decides when to raise.
- *Why:* the subject must not know its observers; observers must not know each other. Events give that for free in C#; channels add scene-independence; `UnityEvent` adds Inspector wiring at a runtime cost.
- *Source:* [Observer pattern course](../reference/design-patterns/course-create-modular-and-maintainable-code-with-the-observer-pattern.md); [e-book, "Observer pattern", "UnityEvents and UnityActions"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md); [Manual: UnityEvent](../reference/scripting/manual-unity-events.md); [Domain reload](../reference/scripting/manual-domain-reloading.md).

## Singleton: why we avoid it, and the one exception

- **NEVER** introduce a new `static Instance`. Singletons hide dependencies, make unit tests share state, and couple every caller to one concrete class. Both Unity e-books recommend replacing them with event channels (messaging) and runtime sets (shared access).
- **The one tolerated static access point is `GameBootstrap`** (bootstrap scene, `DontDestroyOnLoad`). It owns the game-flow state machine and the handful of persistent services (scene loading, audio mixer access, save/load) and is the only place allowed to hold `static` state. Anything added to it is listed here: *GameBootstrap — game flow, scene loading, persistence.* **[project decision — consistent with project decision 10]**
- **MUST** implement it with the `PersistentSingleton<T>` shape below (first instance wins, duplicates destroy themselves). It is placed in the bootstrap scene, so lazy GameObject creation is removed. *Source:* [patterns demo PersistentSingleton.cs](../reference/design-patterns/github-game-programming-patterns-demo-persistentsingleton-cs.md); [e-book, "Singleton pattern", "Pros and cons"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md); [SO e-book, "Avoiding singletons"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).

```csharp
using UnityEngine;

public abstract class PersistentSingleton<T> : MonoBehaviour where T : Component
{
    private static T s_instance;

    public static T Instance
    {
        get
        {
            if (s_instance == null)
            {
                s_instance = FindFirstObjectByType<T>(); // once, at first access; never per frame
            }

            return s_instance;
        }
    }

    protected virtual void Awake()
    {
        if (s_instance == null)
        {
            s_instance = this as T;
            DontDestroyOnLoad(gameObject);
        }
        else if (s_instance != this)
        {
            Destroy(gameObject);
        }
    }
}

public class GameBootstrap : PersistentSingleton<GameBootstrap>
{
}
```

- **SHOULD** prefer that even `GameBootstrap` is *reached* by event channels (`GameStarted`, `LoadLevelRequested`) rather than by `GameBootstrap.Instance` calls from gameplay code; the static accessor is for the few systems that genuinely need a direct handle.

## State pattern

- **SHOULD** use `IState` + a plain `StateMachine` class for any actor or flow with three or more states, or whenever transitions have conditions. The e-book is explicit that the structure is overkill for "a few states". **[project decision: threshold = 3]**
- **MUST** keep the state machine a plain C# class constructed by its owning MonoBehaviour, with states as plain classes receiving their dependencies through the constructor; the MonoBehaviour calls `Execute()` from `Update` (and a `FixedExecute()` from `FixedUpdate` if physics is involved).
- **SHOULD** expose a `StateChanged` event for animation/UI observers rather than letting states reach into those systems.
- **MAY** use the same machine for game flow in `GameBootstrap` (Boot → MainMenu → Playing → Paused → GameOver) with transitions driven by event channels; scene loading itself follows [11 Scenes and prefabs](./11-scenes-prefabs-workflow.md).
- *Source:* [State pattern course](../reference/design-patterns/course-develop-a-modular-flexible-codebase-with-the-state-programming-pattern.md); [e-book, "State pattern", "Example: Game states"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

```csharp
using System;

public interface IState
{
    void Enter();
    void Execute();
    void Exit();
}

public class StateMachine
{
    public IState CurrentState { get; private set; }

    public event Action<IState> StateChanged;

    public void Initialize(IState startingState)
    {
        CurrentState = startingState;
        startingState.Enter();
        StateChanged?.Invoke(startingState);
    }

    public void TransitionTo(IState nextState)
    {
        CurrentState.Exit();
        CurrentState = nextState;
        nextState.Enter();
        StateChanged?.Invoke(nextState);
    }

    public void Execute()
    {
        if (CurrentState != null)
        {
            CurrentState.Execute();
        }
    }
}

public class IdleState : IState
{
    private readonly PlayerController m_player;
    private readonly StateMachine m_machine;

    public IdleState(PlayerController player, StateMachine machine)
    {
        m_player = player;
        m_machine = machine;
    }

    public void Enter()
    {
    }

    public void Execute()
    {
        if (m_player.MoveInput.sqrMagnitude > 0.01f)
        {
            m_machine.TransitionTo(m_player.WalkState);
        }
    }

    public void Exit()
    {
    }
}
```

## Command pattern

- **SHOULD** use it only when actions must be undone, replayed, queued or buffered (turn planning, level editor, input combos). Plain method calls otherwise.
- **MUST** keep commands as plain classes implementing `ICommand { Execute(); Undo(); }` with their parameters passed through the constructor; the invoker is an *instance* owned by the system that needs it, not a static stack. **[project decision — the e-book's example uses a static stack; an instance avoids static state and lets two systems keep separate histories]**
- **SHOULD** cap the undo/redo stacks and clear the redo stack on a new command.
- *Source:* [Command pattern course](../reference/design-patterns/course-use-the-command-pattern-for-flexible-and-extensible-game-systems.md); [e-book, "Command pattern", "Improvements"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md); [SO e-book, "The Command pattern"](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md).

```csharp
using System.Collections.Generic;

public interface ICommand
{
    void Execute();
    void Undo();
}

public class CommandInvoker
{
    private readonly Stack<ICommand> m_undoStack = new Stack<ICommand>();
    private readonly Stack<ICommand> m_redoStack = new Stack<ICommand>();

    public void ExecuteCommand(ICommand command)
    {
        command.Execute();
        m_undoStack.Push(command);
        m_redoStack.Clear();
    }

    public void Undo()
    {
        if (m_undoStack.Count == 0)
        {
            return;
        }

        ICommand command = m_undoStack.Pop();
        command.Undo();
        m_redoStack.Push(command);
    }

    public void Redo()
    {
        if (m_redoStack.Count == 0)
        {
            return;
        }

        ICommand command = m_redoStack.Pop();
        command.Execute();
        m_undoStack.Push(command);
    }
}
```

## Factory pattern

- **SHOULD** use a factory only when several product types share a creation contract and need per-type set-up (`Initialize()`), or when creation must be combined with pooling. For one prefab, `Instantiate` it from a serialized reference — a factory class adds nothing.
- **MUST** put per-product logic in the product (`IProduct.Initialize()`), not in `if`/`switch` chains in the factory.
- Shape when needed: `IProduct { void Initialize(); }`, `abstract class Factory : MonoBehaviour { public abstract IProduct GetProduct(Vector3 position); }`, one concrete factory per product prefab that instantiates, calls `Initialize()` and returns the product. Combine with the object pool below when the products are short-lived.
- *Source:* [Factory pattern course](../reference/design-patterns/course-how-to-use-the-factory-pattern-for-object-creation-at-runtime.md); [e-book, "Factory pattern", "Pros and cons", "Improvements"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

## Object pool

- **MUST** pool anything created and destroyed repeatedly during play (projectiles, impact VFX, floating damage numbers, spawned enemies in waves) with `UnityEngine.Pool.ObjectPool<T>`. Do not write a custom pool; do not `Instantiate`/`Destroy` per shot.
- **MUST** construct the pool once in `Awake` with all four callbacks (`createFunc`, `actionOnGet`, `actionOnRelease`, `actionOnDestroy`), `collectionCheck = true` (throws in the Editor on double release), and explicit `defaultCapacity`/`maxSize`. Items released above `maxSize` are destroyed by the pool.
- **MUST** reset "dirty" state when an item is released (velocity, timers, trail renderers) so the next `Get` starts clean. Deactivate on release so pooled objects stop receiving `Update`.
- **SHOULD** give the pooled component an `IObjectPool<T>` property so it can release itself (on timeout, collision, off-screen).
- Pool lifetime across scene swaps, `Clear()` between levels, sizing and the collection pools (`ListPool` and friends) are in [05 §4 Object pooling](./05-performance.md#4-object-pooling); the pattern and its shape are defined here.
- *Source:* [Object pooling course](../reference/design-patterns/course-use-object-pooling-to-boost-performance-of-c-scripts-in-unity.md); [ObjectPool\<T0\> API](../reference/scripting/scriptref-pool-objectpool-1.md); [e-book, "UnityEngine.Pool", "Improvements"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md).

```csharp
using UnityEngine;
using UnityEngine.Pool;

public class ProjectileLauncher : MonoBehaviour
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

    public Projectile Fire(Vector3 position, Quaternion rotation)
    {
        Projectile projectile = m_pool.Get();
        projectile.transform.SetPositionAndRotation(position, rotation);
        return projectile;
    }

    private Projectile CreateProjectile()
    {
        Projectile instance = Instantiate(m_projectilePrefab);
        instance.Pool = m_pool;
        return instance;
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

[RequireComponent(typeof(Rigidbody))]
public class Projectile : MonoBehaviour
{
    private Rigidbody m_rigidbody;

    public IObjectPool<Projectile> Pool { get; set; }

    private void Awake()
    {
        m_rigidbody = GetComponent<Rigidbody>();
    }

    public void Release()
    {
        m_rigidbody.linearVelocity = Vector3.zero; // reset dirty state before returning
        Pool.Release(this);
    }
}
```

## UI: MVP by default, MVVM data binding where it removes code

Runtime UI is UI Toolkit **[project decision]**: the 6.3 manual's comparison page lists uGUI as the general runtime recommendation and UI Toolkit as the alternative "often used for multi-resolution menus and HUD"; we choose UI Toolkit because UXML/USS are text files that diff and merge cleanly and are easy for AI agents to author, avoid scene/prefab conflicts, and are Unity's active development direction. Escape hatches (keyframed/Timeline UI, serialized `UnityEvent` needs, TMP 3D text) and all UI Toolkit conventions are in [09](./09-packages-systems.md#ui-toolkit-runtime-ui). The View is UXML + USS; the code side follows Model–View–Presenter:

- **MUST** put UI code in a presenter MonoBehaviour per screen/panel (the component [09](./09-packages-systems.md#controllers) calls the document's *controller*; class names end in `Presenter`, e.g. `HealthPresenter`, `PauseMenuPresenter`) that (1) holds a serialized `UIDocument`, (2) queries its elements with `Q<T>("name")` in `OnEnable` — the UI Document loads its UXML in `OnEnable` and clears it in `OnDisable`, so element references taken anywhere else go stale — (3) subscribes to model/channel events and element events, (4) unsubscribes in `OnDisable`. The presenter converts model values to text/colour; it contains no gameplay rules. *Source:* [Manual: Create a UI Document component — lifecycle](../reference/packages/manual-uie-create-ui-document-component.md).
- **MUST** keep gameplay code ignorant of UI: it raises events (channel or C#), the presenter listens. User input from the view (button clicks) goes presenter → event channel → gameplay, never presenter → gameplay component. **[project decision — the e-book's presenter calls the model directly; we route through a channel so UI never references a gameplay type]**
- **MAY** use UI Toolkit runtime data binding (`DataBinding`, `BindingMode.ToTarget`, set in UI Builder or with `SetBinding`) instead of presenter code for read-only displays whose data source is a ScriptableObject or plain C# object. The e-book suggests it pays off for larger UIs; for a hackathon use it where it deletes more code than it adds. **[project decision]**
- *Source:* [e-book, "Model View Presenter (MVP)", "Model-View-ViewModel"](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md); [MVC/MVP course](../reference/design-patterns/course-build-a-modular-codebase-with-mvc-and-mvp-programming-patterns.md); [MVVM course](../reference/design-patterns/course-model-view-viewmodel-pattern.md); [Manual: Runtime data binding](../reference/packages/manual-uie-runtime-binding.md); [Manual: Get started with runtime binding](../reference/packages/manual-uie-get-started-runtime-binding.md).

```csharp
using UnityEngine;
using UnityEngine.UIElements;

public class HealthPresenter : MonoBehaviour
{
    [SerializeField] private UIDocument m_document;

    [Header("Listens to")]
    [SerializeField] private IntEventChannelSO m_healthChanged;

    [Header("Broadcasts on")]
    [SerializeField] private VoidEventChannelSO m_restartRequested;

    private Label m_valueLabel;
    private Button m_restartButton;

    private void OnEnable()
    {
        VisualElement root = m_document.rootVisualElement;
        m_valueLabel = root.Q<Label>("health-value");
        m_restartButton = root.Q<Button>("restart-button");

        m_restartButton.clicked += RestartButton_Clicked;
        m_healthChanged.EventRaised += HealthChanged_EventRaised;
    }

    private void OnDisable()
    {
        m_restartButton.clicked -= RestartButton_Clicked;
        m_healthChanged.EventRaised -= HealthChanged_EventRaised;
    }

    private void HealthChanged_EventRaised(int health)
    {
        m_valueLabel.text = health.ToString();
    }

    private void RestartButton_Clicked()
    {
        m_restartRequested.RaiseEvent();
    }
}
```

UXML/USS conventions and the UI Toolkit API details belong to [09 Packages and systems](./09-packages-systems.md).

## Dependency direction: assemblies and namespaces

Assemblies (project decision 3) and the only allowed reference directions:

```
SheNicest.Tests.EditMode ──▶ SheNicest.Editor ──▶ SheNicest.Runtime ──▶ Unity engine + package assemblies only
SheNicest.Tests.PlayMode ───────────────────────┘
```

- **MUST NOT** reference `SheNicest.Editor` from `SheNicest.Runtime` (it is Editor-only and would break builds), nor any test assembly from either. `SheNicest.Tests.EditMode` may reference `SheNicest.Editor` (so editor tooling can be EditMode-tested); `SheNicest.Tests.PlayMode` references `SheNicest.Runtime` only. Unity forbids cyclic references outright; if two assemblies need each other the split is wrong. The canonical asmdef JSON lives in [02](./02-project-structure.md).
- **MUST** put `UnityEditor` usages in `SheNicest.Editor` or behind `#if UNITY_EDITOR`.
- *Why:* because the arrow only points one way, a change in Editor or test code can never affect runtime code, and runtime code stays reusable and build-safe.
- *Source:* [Manual: Introduction to assemblies](../reference/project-structure/manual-assembly-definitions-intro.md); [Manual: Referencing assemblies](../reference/project-structure/manual-assembly-definitions-referencing.md); [Programming best practices — compilation considerations](../reference/scripting/manual-programming-best-practices.md).

Inside `SheNicest.Runtime`, namespaces mirror folders and carry the same one-way rule **[project decision]**:

```
SheNicest.Core          ← IState/StateMachine, ICommand, Log, capability interfaces
                          (IDamageable, IInteractable, ISwitchable)
SheNicest.Events        ← VoidEventChannelSO, GenericEventChannelSO<T> and concrete channels
SheNicest.Data          ← SO class definitions: *ConfigSO, enum assets, RuntimeSetSO<T>, delegate-object bases
SheNicest.<Feature>     ← Player, Cameras, UI, Enemies, Combat … references Core/Events/Data only
SheNicest.App           ← GameBootstrap, SceneLoader, game-flow states; may reference Core/Events/Data
                          and feature public APIs
```

- **MUST NOT** reference another feature's concrete types from a feature namespace. Cross-feature needs go through a `Core` interface, an `Events` channel asset or `Data` assets. This keeps the single runtime assembly splittable into per-feature assemblies later without refactoring. Initial folder set and dependency direction (`Core`/`Events`/`Data` ← features ← `App`) are owned by [02](./02-project-structure.md).
- **SHOULD** keep `Core`, `Events` and `Data` free of gameplay rules — they hold contracts, channels, data shapes and reusable machinery only.

## Anti-patterns

- ❌ `public static GameManager Instance` on every manager → ✅ event channels for messages, runtime sets for lookups, serialized references for wiring; only `GameBootstrap` is static.
- ❌ `FindFirstObjectByType<PlayerController>()` in gameplay code to reach another feature → ✅ a serialized reference, a runtime set, or an event carrying the object; if a lookup is unavoidable (bootstrap, tests, editor tooling), the rules in [04](./04-unity-scripting-rules.md#finding-objects-and-accessing-components).
- ❌ One `PlayerController.cs` that reads input, moves, animates, plays audio and updates the HUD → ✅ `PlayerInputReader`, `PlayerMovement`, `PlayerAnimator`, `PlayerAudio`, a `HealthPresenter` listening to a channel.
- ❌ `switch (enemyType)` growing a new `case` per enemy → ✅ an `EnemyBrainSO` strategy or an `EnemyBase` with one override.
- ❌ Subclass that overrides a method with `{ }` or throws `NotImplementedException` → ✅ split the interface (ISP) or the hierarchy (LSP).
- ❌ Mutating a shared `...ConfigSO` at runtime (`config.MaxHealth -= 10`) → ✅ per-instance field on the MonoBehaviour, or `Instantiate(config)` as a runtime copy.
- ❌ `IntVariableSO` assets as the game's mutable state → ✅ plain C# model owned by a component, exposed through events.
- ❌ `Instantiate`/`Destroy` per bullet → ✅ `ObjectPool<Projectile>` with reset-on-release.
- ❌ Subscribing in `Awake`/`Start` and never unsubscribing → ✅ `OnEnable` `+=` / `OnDisable` `-=` pairs.
- ❌ `static class GameEvents { public static event Action Scored; }` → ✅ a `VoidEventChannelSO` asset (inspectable, no stale subscribers across Play sessions).
- ❌ UI script calling `player.GetComponent<Health>().Restore()` → ✅ presenter raises `RestartRequested` channel; gameplay listens.
- ❌ `[SerializeField] private IDamageable m_target;` (silently not serialized) → ✅ serialize the concrete `MonoBehaviour`/`ScriptableObject` and cast in `Awake`, or `[SerializeReference]` for plain classes.
- ❌ State machine, command buffer and factory built "because we might need them" → ✅ KISS: add the pattern when the second state/undo/product actually arrives.

## Review checklist

- [ ] Every new class is the right kind: MonoBehaviour only if it needs a scene object or callbacks; ScriptableObject only for config/enum/channel/set/strategy; plain C# for everything testable.
- [ ] No new `static Instance`, static event bus or static mutable field outside `GameBootstrap`.
- [ ] No `Find*`/`GameObject.Find` calls in gameplay code; dependencies are serialized references, `RequireComponent` + `GetComponent` in `Awake`, or constructor parameters.
- [ ] Cross-feature communication goes through `Core` interfaces, `Events` channel assets or `Data` assets; no feature references another feature's concrete type.
- [ ] Every `+=` on an event has a matching `-=` in `OnDisable` (or `OnDestroy` for subscriptions made in `Awake`).
- [ ] Channel fields are marked `[Header("Listens to")]` / `[Header("Broadcasts on")]`.
- [ ] No runtime writes to shared ScriptableObject assets; runtime copies use `Instantiate`/`CreateInstance`.
- [ ] Repeated spawn/destroy uses `ObjectPool<T>` with `collectionCheck = true`, explicit sizes and reset-on-release.
- [ ] State logic with ≥ 3 states uses `IState`/`StateMachine` as plain classes; commands and factories exist only where undo/variety is real.
- [ ] UI code is a presenter: queries in `OnEnable`, unsubscribes in `OnDisable`, no gameplay rules, no direct calls into gameplay components.
- [ ] No class over ~300 lines; no MonoBehaviour hierarchy deeper than one abstract base; no empty or throwing overrides.
- [ ] Assembly references point only Tests.EditMode → Editor → Runtime and Tests.PlayMode → Runtime; `UnityEditor` usage is in `SheNicest.Editor` or `#if UNITY_EDITOR`.

## Sources

1. [ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md](../reference/design-patterns/ebook-level-up-your-code-with-design-patterns-and-solid-e-book.md) — Level up your code with design patterns and SOLID (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/2g8gww5kf6gsb2krfpjhcv/Level_up_your_code_with_design_patterns_and_SOLID_e-book.pdf
2. [ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md) — Create modular game architecture with ScriptableObjects (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/5xhgncq5b6p565fqvhb5kx5/Modular_game_architecture_with_ScriptableObjects_Unity_6_Final.pdf
3. [course-create-modular-and-maintainable-code-with-the-observer-pattern.md](../reference/design-patterns/course-create-modular-and-maintainable-code-with-the-observer-pattern.md) — Create modular and maintainable code with the observer pattern (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/create-modular-and-maintainable-code-with-the-observer-pattern
4. [course-develop-a-modular-flexible-codebase-with-the-state-programming-pattern.md](../reference/design-patterns/course-develop-a-modular-flexible-codebase-with-the-state-programming-pattern.md) — Develop a modular, flexible codebase with the state programming pattern (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/develop-a-modular-flexible-codebase-with-the-state-programming-pattern
5. [course-use-object-pooling-to-boost-performance-of-c-scripts-in-unity.md](../reference/design-patterns/course-use-object-pooling-to-boost-performance-of-c-scripts-in-unity.md) — Use object pooling to boost performance of C# scripts in Unity (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity
6. [course-use-the-command-pattern-for-flexible-and-extensible-game-systems.md](../reference/design-patterns/course-use-the-command-pattern-for-flexible-and-extensible-game-systems.md) — Use the command pattern for flexible and extensible game systems (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/use-the-command-pattern-for-flexible-and-extensible-game-systems
7. [course-how-to-use-the-factory-pattern-for-object-creation-at-runtime.md](../reference/design-patterns/course-how-to-use-the-factory-pattern-for-object-creation-at-runtime.md) — How to use the factory pattern for object creation at runtime (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/how-to-use-the-factory-pattern-for-object-creation-at-runtime
8. [course-build-a-modular-codebase-with-mvc-and-mvp-programming-patterns.md](../reference/design-patterns/course-build-a-modular-codebase-with-mvc-and-mvp-programming-patterns.md) — Build a modular codebase with MVC and MVP programming patterns (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/build-a-modular-codebase-with-mvc-and-mvp-programming-patterns
9. [course-model-view-viewmodel-pattern.md](../reference/design-patterns/course-model-view-viewmodel-pattern.md) — Model-View-ViewModel pattern (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/model-view-viewmodel-pattern
10. [course-strategy-pattern.md](../reference/design-patterns/course-strategy-pattern.md) — Strategy pattern (Unity 6) — https://learn.unity.com/course/design-patterns-unity-6/tutorial/strategy-pattern
11. [how-to-separate-game-data-logic-scriptable-objects.md](../reference/design-patterns/how-to-separate-game-data-logic-scriptable-objects.md) — Separate game data and logic with ScriptableObjects — https://unity.com/how-to/separate-game-data-logic-scriptable-objects
12. [how-to-scriptableobjects-event-channels-game-code.md](../reference/design-patterns/how-to-scriptableobjects-event-channels-game-code.md) — Use ScriptableObjects as event channels in game code — https://unity.com/how-to/scriptableobjects-event-channels-game-code
13. [how-to-scriptableobject-based-runtime-set.md](../reference/design-patterns/how-to-scriptableobject-based-runtime-set.md) — How to use a ScriptableObject-based runtime set — https://unity.com/how-to/scriptableobject-based-runtime-set
14. [how-to-scriptableobject-based-enums.md](../reference/design-patterns/how-to-scriptableobject-based-enums.md) — Use ScriptableObject-based enums in your Unity project — https://unity.com/how-to/scriptableobject-based-enums
15. [how-to-scriptableobjects-delegate-objects.md](../reference/design-patterns/how-to-scriptableobjects-delegate-objects.md) — Use ScriptableObjects as delegate objects — https://unity.com/how-to/scriptableobjects-delegate-objects
16. [how-to-get-started-with-scriptableobjects-demo.md](../reference/design-patterns/how-to-get-started-with-scriptableobjects-demo.md) — Get started with the Unity ScriptableObjects demo — https://unity.com/how-to/get-started-with-scriptableobjects-demo
17. [github-game-programming-patterns-demo-persistentsingleton-cs.md](../reference/design-patterns/github-game-programming-patterns-demo-persistentsingleton-cs.md) — patterns demo: PersistentSingleton.cs — https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/3_Singleton/Scripts/Pattern/PersistentSingleton.cs
18. [manual-class-scriptableobject.md](../reference/scripting/manual-class-scriptableobject.md) — ScriptableObject (Unity 6.3 Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html
19. [scriptref-pool-objectpool-1.md](../reference/scripting/scriptref-pool-objectpool-1.md) — ObjectPool\<T0\> (Unity 6.3 Scripting API) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.html
20. [manual-unity-events.md](../reference/scripting/manual-unity-events.md) — Inspector-configurable custom events (UnityEvent) — https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html
21. [manual-programming-best-practices.md](../reference/scripting/manual-programming-best-practices.md) — Unity programming best practices — https://docs.unity3d.com/6000.3/Documentation/Manual/programming-best-practices.html
22. [manual-domain-reloading.md](../reference/scripting/manual-domain-reloading.md) — Enter Play mode with domain reload disabled — https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html
23. [scriptref-requirecomponent.md](../reference/scripting/scriptref-requirecomponent.md) — Scripting API: RequireComponent — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RequireComponent.html
24. [scriptref-object-findfirstobjectbytype.md](../reference/scripting/scriptref-object-findfirstobjectbytype.md) — Scripting API: Object.FindFirstObjectByType — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html
25. [scriptref-serializereference.md](../reference/scripting/scriptref-serializereference.md) — Scripting API: SerializeReference — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeReference.html
26. [manual-assembly-definitions-intro.md](../reference/project-structure/manual-assembly-definitions-intro.md) — Introduction to assemblies in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-intro.html
27. [manual-assembly-definitions-referencing.md](../reference/project-structure/manual-assembly-definitions-referencing.md) — Referencing assemblies — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html
28. [manual-uie-runtime-binding.md](../reference/packages/manual-uie-runtime-binding.md) — Runtime data binding (UI Toolkit) — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding.html
29. [manual-uie-get-started-runtime-binding.md](../reference/packages/manual-uie-get-started-runtime-binding.md) — Get started with runtime binding — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-runtime-binding.html
30. [manual-uie-create-ui-document-component.md](../reference/packages/manual-uie-create-ui-document-component.md) — Create a UI Document component (lifecycle) — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-create-ui-document-component.html
31. [scriptref-debug-assert.md](../reference/scripting/scriptref-debug-assert.md) — Scripting API: Debug.Assert — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Assert.html
