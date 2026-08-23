# 01. C# code style and naming

> **Scope:** How C# source in this repository is named, formatted, laid out and commented, and the exact `.editorconfig` that encodes it.
> **Applies to:** every `.cs` file under `Assets/SheNicest/Scripts` and `Assets/SheNicest/Tests` (assemblies `SheNicest.Runtime`, `SheNicest.Editor`, `SheNicest.Tests.*`). Third-party code under `Assets/ThirdParty` and `Assets/Plugins` is left as shipped.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

This document follows Unity's *C# style guide (Unity 6 edition)* as written, with the choices it leaves open settled below and marked **[project decision]**. Where this guide is silent, Microsoft's C# conventions apply. Lifecycle and serialization semantics live in [04 Unity scripting rules](./04-unity-scripting-rules.md), architecture in [03](./03-architecture-patterns.md), performance in [05](./05-performance.md), folders and assemblies in [02](./02-project-structure.md).

## TL;DR — rules at a glance

1. **MUST** Use PascalCase for namespaces, types, methods, properties, events, enum members and public fields; camelCase for locals and parameters.
2. **MUST** Prefix non-public instance fields `m_camelCase`, non-public static fields `s_camelCase`, constants and `static readonly` fields `k_PascalCase`; prefix interfaces with `I`.
3. **MUST** Write an explicit access modifier on every member and type; drop redundant initializers (`= 0`, `= null`, `= false`).
4. **MUST** Name booleans and bool-returning methods as questions (`m_isDead`, `HasKey`, `IsGameOver()`); methods start with a verb, types are nouns, `ScriptableObject` classes end with `SO` (`EnemyConfigSO`), enums are singular nouns (plural only for `[Flags]`).
5. **MUST** Allman braces, 4-space indentation (no tabs), braces on every block including single statements, one statement and one declaration per line, lines ≤ 120 columns.
6. **MUST** One `MonoBehaviour`/`ScriptableObject` per file, file name = class name, one namespace per file; namespace is `SheNicest.<FeatureFolder>`; `using` directives outside the namespace, `System` first, unused ones removed.
7. **MUST** Expose Inspector data with `[SerializeField] private` fields (plus `[Tooltip]`/`[Range]`), never public fields on `MonoBehaviour`/`ScriptableObject`; give read access through properties.
8. **MUST** Order members: constants/statics → serialized fields → other fields → properties → events → Unity messages (fixed order, see *Class layout*) → public methods → private methods → nested types.
9. **MUST** Name events as verb phrases (`Damaged`, `DoorOpened`, `OpeningDoor`) typed `System.Action`/`Action<T>`; raise them from `OnXxx()`; handle them in `Subject_Xxx()` (ScriptableObject event-channel listeners: `On<ChannelField>`, see [03](./03-architecture-patterns.md)).
10. **SHOULD** Use `var` only when the type is written on the right-hand side (`new T(...)`, an explicit cast to a non-built-in type) or for `foreach` variables; built-in types (`int`, `float`, `string`…) are always written explicitly, even for literals.
11. **SHOULD** Comment the *why* with `// Sentence.`; put `/// <summary>` on public types and non-obvious public members; a `[Tooltip]` replaces the comment on a serialized field.
12. **SHOULD** Run the IDE's *Format Document* before committing; the repo-root `.editorconfig` (appendix) is the single source of formatting truth — never add per-folder overrides.
13. **NEVER** Use `record`, `init` setters, file-scoped namespaces or any feature newer than C# 9; never `#region`; never commented-out code, author/date headers, or column-aligned declarations.
14. **NEVER** Use `??`, `?.` or `is null` on a `UnityEngine.Object` reference (see [04](./04-unity-scripting-rules.md)); the `.editorconfig` turns those IDE suggestions off.
15. **NEVER** Let the IDE add `readonly` to a `[SerializeField]` field or fold it into an auto-property — Unity does not serialize `readonly` fields.

## Language level

Write C# 9.0 and nothing newer. Unity 6.3 compiles with Roslyn at C# 9.0 and rejects init-only setters, covariant return types and module initializers; records depend on init-only setters and must never appear in serialized types. **NEVER** use `record`, `init`, file-scoped namespaces (`namespace X;`), raw string literals (`"""`), collection expressions (`[a, b]`), `required` or primary constructors on classes — `record` and `init` are C# 9 but need the `IsExternalInit` type Unity does not ship, and the rest are C# 10–12; the Microsoft conventions show all of them, none are used here. **[project decision: no `IsExternalInit` shim]**

- *Why:* A file that does not compile blocks the whole team's Editor; the shim only buys records, which Unity serialization cannot use anyway.
- *Source:* [C# compiler and language version reference](../reference/csharp-style/manual-csharp-compiler.md) (`IsExternalInit` caveat, no records in serialized types); Microsoft's newer-syntax examples are in [Common C# code conventions](../reference/csharp-style/learn-microsoft-com-coding-conventions.md). Version attribution of the C# 10–12 features is general C# knowledge, not from the references.

## Naming

### Casing by identifier kind

| Identifier | Casing | Example |
|---|---|---|
| Namespace | PascalCase, dot-separated | `SheNicest.Player` |
| Class, struct, enum, delegate | PascalCase noun | `PlayerHealth`, `WeaponType` |
| ScriptableObject class | PascalCase noun + `SO` suffix | `EnemyConfigSO`, `VoidEventChannelSO` |
| Interface | `I` + PascalCase adjective/noun | `IDamageable`, `IInteractable` |
| Method | PascalCase verb phrase | `ApplyDamage`, `FindTarget` |
| Property | PascalCase noun (or question for bool) | `MaxHealth`, `IsDead` |
| Event | PascalCase verb phrase | `Damaged`, `DoorOpened` |
| Public field (serializable structs only) | PascalCase | `MovementSpeed` |
| Non-public instance field | `m_` + camelCase | `m_currentHealth` |
| Non-public static field | `s_` + camelCase | `s_instanceCount` |
| Constant / `static readonly` (any accessibility) | `k_` + PascalCase | `k_MaxItems`, `k_SpeedHash` |
| Enum member | PascalCase | `WeaponType.RocketLauncher` |
| Parameter, local variable | camelCase | `damageAmount`, `hitCount` |
| Generic type parameter | `T` or `T` + descriptive | `T`, `TEvent` |

- *Why:* The prefixes tell a reader the storage class of a field at a glance without `this.`; everything else follows the .NET conventions every IDE and analyzer expects.
- *Source:* [Style guide e-book, Naming conventions](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (m_/s_/k_, `k_PascalCase` constants), [StyleExample.cs](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md), [Microsoft capitalization conventions](../reference/csharp-style/learn-microsoft-com-capitalization-conventions.md), [Microsoft identifier names](../reference/csharp-style/learn-microsoft-com-identifier-names.md) (generic `T` prefix). `static readonly` → `k_` follows the Boss Room `.editorconfig` **[project decision]**.

### Fields

- **MUST** prefix `m_`/`s_`/`k_` exactly as in the table; the part after the prefix is camelCase for `m_`/`s_` and PascalCase for `k_` (`m_movementSpeed`, not `m_MovementSpeed`).
- **MUST** write the access modifier (`private int m_health;`, never `int m_health;`) and order modifiers `public/private/protected/internal, static, readonly, …` (encoded in the appendix).
- **MUST** drop redundant initializers: no `= 0`, `= null`, `= false`.
- **MUST** declare one field per line.
- **MUST NOT** repeat the class name in a member (`Player.Score`, not `Player.PlayerScore`).
- **MUST NOT** use Hungarian notation, abbreviations (except accepted math/loop names like `i`, `dt`, `uv`) or jokes.

- *Why:* Explicit modifiers remove ambiguity for readers and tools; the guide lets teams omit `private`, but Microsoft's guidance and our `.editorconfig` (`dotnet_style_require_accessibility_modifiers`) require it **[project decision]**. Fields already default to `0`/`null`/`false`.
- *Source:* [Naming and code style tips](../reference/csharp-style/how-to-naming-and-code-style-tips-c-scripting-unity.md) ("it's generally considered good practice to specify access level modifiers"; redundant initializers; one declaration per line; redundant names), [Style guide e-book](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (Hungarian notation, abbreviations), [Microsoft general naming conventions](../reference/csharp-style/learn-microsoft-com-general-naming-conventions.md).

```csharp
// ✅
public class Launcher : MonoBehaviour
{
    private const float k_MinForce = 1f;
    private static readonly int k_FireHash = Animator.StringToHash("Fire");
    private static int s_activeCount; // Mutable static: reset via [RuntimeInitializeOnLoadMethod], see 04.

    [SerializeField] private float m_force = 10f;
    private bool m_isArmed;
}

// ❌
public class Launcher : MonoBehaviour
{
    const float MIN_FORCE = 1f;          // constants are k_PascalCase
    static int activeCount = 0;          // s_ prefix, no redundant initializer
    public float force = 10f;            // public field on a MonoBehaviour
    bool armed, _isArmed;                // no modifier, two per line, not a question
}
```

### Booleans, methods and parameters

- **MUST** name booleans (fields, properties, locals) as a question with a verb prefix: `isDead`, `hasKey`, `canJump`, `IsGrounded`.
- **MUST** start method names with a verb (`GetDirection`, `FindTarget`, `ApplyDamage`); methods returning `bool` ask a question (`IsGameOver`, `HasStartedTurn`, `TryGetTarget`).
- **MUST** name parameters camelCase like locals; **SHOULD** keep methods to ≤ 3 parameters and split flag-controlled methods into two (`GetAngleInDegrees` / `GetAngleInRadians`).
- **SHOULD** put the unit in the name when it is not obvious (`elapsedTimeInSeconds`, `GetDistanceToTargetInMeters`).

- *Why:* The call site then reads as English (`if (IsGameOver())`, `if (m_isDead)`) and a name never lies about its unit.
- *Source:* [Style guide e-book, Fields and variables / Methods](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [Unity blog: create your own C# code style](../reference/csharp-style/blog-clean-up-your-code-how-to-create-your-own-c-code-style.md).

### Types, interfaces and enums

- **MUST** name classes and structs with PascalCase nouns or noun phrases, no prefixes. Make the name unambiguous across the project (`PhysicsSolver`, not `Solver`); append `Attribute` to attribute types.
- **MUST** end every `ScriptableObject`-derived class name with `SO` (`EnemyConfigSO`, `VoidEventChannelSO`); the asset *files* created from it do not carry the suffix (`Data/Enemies/HoverBot.asset`, naming in [02](./02-project-structure.md)). **[project decision — Unity's ScriptableObject e-book convention]**
- **MUST** prefix interfaces with `I` followed by an adjective or capability: `IDamageable`, `IInteractable`, `IPoolable`.
- **MUST** name enums with a **singular** PascalCase noun and PascalCase members, no prefix/suffix (`WeaponType.Knife`). `[Flags]` enums are **plural** (`AttackModes`) and may column-align their binary comments — the one place column alignment is allowed.
- **MUST** declare an enum that is shared by several classes at namespace level in its own file; an enum used by one class only may be nested in it.

- *Why:* Type names read as things, method names as actions; singular enums read naturally at the use site (`WeaponType.Knife`).
- *Source:* [Style guide e-book, Enums / Classes and interfaces](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [StyleExample.cs](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md), [Microsoft identifier names](../reference/csharp-style/learn-microsoft-com-identifier-names.md) (`Attribute` suffix, singular/plural enums), [ScriptableObject e-book, naming](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md) ("add a 'Data' or 'SO' suffix at the end of the class name" — we pick `SO`). File placement of enums **[project decision]**.

```csharp
public enum WeaponType
{
    Knife,
    Gun,
    RocketLauncher,
}

[Flags]
public enum AttackModes
{
    None = 0,                          // 000000
    Melee = 1,                         // 000001
    Ranged = 2,                        // 000010
    Special = 4,                       // 000100
    MeleeAndSpecial = Melee | Special, // 000101
}
```

### Events and handlers

- **MUST** name an event with a verb phrase describing the state change; present participle for *before* (`OpeningDoor`), past participle for *after* (`DoorOpened`, `PointsScored`).
- **MUST** declare gameplay events as `public event Action` / `Action<T>`; create a custom args struct only when more than one value is needed (same threshold as [03](./03-architecture-patterns.md)). `EventHandler`/`EventArgs` are not used. **[project decision — Unity allows either]**
- **MUST** raise an event from a method named `On<Event>` in the publisher (`OnDoorOpened()` → `DoorOpened?.Invoke()`); `?.Invoke` is correct here because a delegate is not a `UnityEngine.Object`.
- **SHOULD** name the subscriber's handler `<Subject>_<Event>` (`PlayerHealth_Died`) and pair every `+=` in `OnEnable` with a `-=` in `OnDisable` (lifecycle detail in [04](./04-unity-scripting-rules.md)).
- **Exception — ScriptableObject event channels** ([03](./03-architecture-patterns.md)): the channel's event is always `EventRaised`, its raising method `RaiseEvent(...)`, and a listener's handler is named `On<ChannelField>` (`OnScoreChanged`, `OnEventRaised`) because the listener, not the channel, owns the method. **[project decision — adapted from Unity's ScriptableObject e-book, whose channels expose `RaiseEvent()` and an `OnEventRaised` delegate]**

- *Why:* `On…` is reserved for raisers and for event-channel listeners (and Unity messages like `OnEnable`), so a reader can tell publisher from subscriber by name alone in C# events, and spot a channel listener by the same prefix.
- *Source:* [Style guide e-book, Events and event handlers](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) ("Create custom EventArgs only as necessary"), [StyleExample.cs](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md), [ScriptableObject e-book, event channels](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md) (`RaiseEvent`/`OnEventRaised`). Event channels and the observer pattern itself: [03 Architecture](./03-architecture-patterns.md).

```csharp
// Publisher
public event Action<int> Damaged;
public event Action Died;

private void OnDied()
{
    Died?.Invoke();
}

// Subscriber
private void OnEnable()
{
    m_playerHealth.Died += PlayerHealth_Died;
}

private void OnDisable()
{
    m_playerHealth.Died -= PlayerHealth_Died;
}

private void PlayerHealth_Died()
{
    ShowGameOverScreen();
}
```

### Namespaces and files

- **MUST** put every type in a namespace rooted at `SheNicest`; sub-namespaces mirror the feature folder under `Scripts/Runtime` (or `Scripts/Editor`): `Assets/SheNicest/Scripts/Runtime/Player/PlayerHealth.cs` → `namespace SheNicest.Player`. Editor code is `SheNicest.Editor.<Feature>`, tests `SheNicest.Tests.EditMode`/`SheNicest.Tests.PlayMode`. **[project decision]**
- **MUST** use PascalCase namespace segments without underscores; never `Scripts`, `Runtime` or `Assets` as a segment.
- **MUST** keep exactly one `MonoBehaviour` or `ScriptableObject` per file, and the file name must equal that class name. Small helper types (a `[Serializable]` struct, a private enum, an interface used only here) may share the file, but they must be in the same namespace — a file with a `MonoBehaviour`/`ScriptableObject` may not contain more than one namespace.
- **MUST** use block-scoped `namespace X { … }` (file-scoped is C# 10).
- **SHOULD** give each non-Unity public type its own file too; nested private types are fine.

- *Why:* Unity resolves a component's class by file name and refuses a `MonoBehaviour` file that spans namespaces; mirrored folders let agents find a type from its full name and vice versa.
- *Source:* [Naming scripts (6.3 Manual)](../reference/csharp-style/manual-naming-scripts.md), [Style guide e-book, Namespaces](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [Project organization e-book, Code standards](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) ("break your folder structure up by the namespace"). Folder layout and assembly definitions: [02 Project structure](./02-project-structure.md).

### Word choice and acronyms

- **MUST** favour readability over brevity (`HorizontalAlignment`, `CanScrollHorizontally`), and pronounceable, searchable names.
- **MUST** cap acronyms the Microsoft way: two-letter acronyms stay upper in PascalCase (`IOStream`, `UIDocument`) and lower at the start of camelCase (`ioStream`); longer acronyms are words (`HtmlTag`, `Json`); `Id`, `Ok` are words, not `ID`/`OK`.
- **MUST NOT** use special or non-ASCII characters in identifiers.

- *Why:* Consistent casing makes names predictable for both humans and code completion; non-ASCII identifiers break some Unity command-line tooling.
- *Source:* [Microsoft capitalization conventions](../reference/csharp-style/learn-microsoft-com-capitalization-conventions.md), [Microsoft general naming conventions](../reference/csharp-style/learn-microsoft-com-general-naming-conventions.md), [Style guide e-book, Identifier names](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md).

UI Toolkit names (USS classes, UXML names) are not C# identifiers; they use BEM kebab-case — see [09 Packages and systems](./09-packages-systems.md) and the [UI Toolkit naming conventions](../reference/csharp-style/manual-naming-conventions.md).

## Formatting

### Braces and indentation

- **MUST** use Allman style: every opening brace on its own line, aligned with the statement that owns it; `else`, `catch`, `finally` start a new line.
- **MUST** indent with 4 spaces; tabs are never stored (the `.editorconfig` converts them).
- **MUST** brace every `if`/`else`/`for`/`foreach`/`while`/`using` body, even a single statement, and put that statement on its own line.
- **MUST** indent `case` labels one level inside `switch` and their bodies one more; end every `switch` with a `default` case even when all values are covered.
- **MAY** keep `{ get; set; }`, `{ get; private set; }` and an empty `{ }` body on one line.

- *Why:* Uniform braces make diffs minimal and breakpoints trivial; a forgotten brace on a one-liner is the classic silent bug when a second statement is added.
- *Source:* [Formatting best practices](../reference/csharp-style/how-to-formatting-best-practices-c-scripting-unity.md) ("Don't omit braces – not even for single-line statements"; switch with default), [Style guide e-book, Brace or indentation style](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (Allman, 4 spaces), encoded as `csharp_new_line_before_open_brace = all` etc. in the [Graphics repo `.editorconfig`](../reference/csharp-style/github-graphics-editorconfig.md).

```csharp
// ✅
if (!showMouse)
{
    Cursor.lockState = CursorLockMode.Locked;
    Cursor.visible = false;
}
else
{
    Cursor.lockState = CursorLockMode.None;
    Cursor.visible = true;
}

switch (mode)
{
    case FireMode.Single:
        FireOnce();
        break;
    case FireMode.Burst:
        FireBurst();
        break;
    default:
        Log.Warning($"Unhandled fire mode {mode}.", this); // SheNicest.Core.Log wrapper, see 04.
        break;
}

// ❌
if (!showMouse) Cursor.visible = false;
for (int i = 0; i < 10; i++)
    for (int j = 0; j < 10; j++)
        DoSomething(j);
```

### Horizontal spacing

- **MUST** put one space after a comma, after `if`/`for`/`while`/`switch` keywords, and around binary and comparison operators (`if (x == y)`, `a = b + c`).
- **MUST NOT** put spaces inside parentheses or brackets, between a method name and `(`, after a cast, or before `,`/`;` (`CollectItem(myObject, 0, 1);`, `x = dataArray[index];`, `(int)value`).
- **MUST NOT** column-align declarations or assignments; one space between type and name.
- **SHOULD** add parentheses to make mixed arithmetic/relational clauses explicit: `if ((startX > endX) && (startX > previousX))`.

- *Why:* These are the defaults every C# formatter produces; deviating creates whitespace-only diffs on every edit.
- *Source:* [Formatting best practices, Horizontal spacing](../reference/csharp-style/how-to-formatting-best-practices-c-scripting-unity.md), [Style guide e-book](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (column alignment), [Microsoft coding conventions](../reference/csharp-style/learn-microsoft-com-coding-conventions.md) (parentheses for clarity), spacing keys in the [Open Project #1 `.editorconfig`](../reference/csharp-style/github-open-project-1-editorconfig.md).

### Line length and wrapping

- **MUST** keep lines ≤ 120 columns **[project decision — the guide allows 80–120]**; break a long expression into named locals rather than wrapping it.
- **SHOULD** break before a binary operator and indent continuation lines one level (4 spaces); align LINQ/query clauses under `from`.
- **MUST** write one statement per line and one declaration per line.

- *Why:* Side-by-side diffs and code review stay readable at 120; named locals document intent better than a wrapped one-liner.
- *Source:* [Style guide e-book, Horizontal spacing](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) ("Decide on a standard line width (80-120 characters)"), [Microsoft coding conventions, Style/Layout](../reference/csharp-style/learn-microsoft-com-coding-conventions.md) (breaks before binary operators, one statement per line).

### Vertical spacing

- **MUST** separate members (fields-group, each property, each method, each nested type) with exactly one blank line; no blank line after an opening brace or before a closing brace; never two or more consecutive blank lines. **[project decision — the guide suggests "two blank lines between…" but says to keep this minimal]**
- **SHOULD** group related fields without blank lines, separated from the next group by one blank line; **SHOULD** keep methods that call each other adjacent, caller above callee.

- *Why:* A single rule is mechanical for agents and formatters; extra blank lines are where reviewers disagree and where merges conflict pointlessly.
- *Source:* [Style guide e-book, Vertical spacing / The newspaper metaphor](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [Microsoft coding conventions](../reference/csharp-style/learn-microsoft-com-coding-conventions.md) ("Add at least one blank line between method definitions and property definitions").

### `using` directives

- **MUST** place all `using` directives at the top of the file, outside the namespace; `System.*` first, then every other namespace in plain alphabetical order (so `SheNicest.*` sorts before `Unity*`), no blank lines between groups — exactly what the IDE's *Sort usings* produces from `dotnet_sort_system_directives_first = true` / `dotnet_separate_import_directive_groups = false` in the appendix.
- **MUST** remove unused `using` lines before committing (any `using` a template or IDE adds that the file does not need).
- **MUST NOT** use `using static` or aliases except to resolve a genuine name clash (`using Random = UnityEngine.Random;` is the accepted case). **[project decision]**

- *Why:* `using` inside a namespace resolves relative to that namespace and can silently bind to a different type when a new namespace appears; `UnityEngine.Random` vs `System.Random` is the one clash every Unity file hits.
- *Source:* [Microsoft coding conventions, "Place the using directives outside the namespace declaration"](../reference/csharp-style/learn-microsoft-com-coding-conventions.md), [StyleExample.cs](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md) ("Remove unused lines"), `csharp_using_directive_placement = outside_namespace` in the [Open Project #1 `.editorconfig`](../reference/csharp-style/github-open-project-1-editorconfig.md).

### Regions and headers

- **NEVER** use `#region`. A class that needs regions is too big — split it (see [03](./03-architecture-patterns.md)).
- **NEVER** add file headers with author, date or "created by" lines; Git carries that. Legal headers, if a third-party license requires one, link to the license file instead of inlining it.

- *Why:* Regions hide complexity instead of removing it; bylines go stale on the first edit and conflict on every merge.
- *Source:* [Style guide e-book, Regions / Comments](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [StyleExample.cs](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md). The project-organization e-book suggests a dated header template; the style guide's "avoid attributions" wins here **[project decision]**.

## Class layout

- **MUST** order members top-down as: constants and static fields → serialized fields → other instance fields → properties → events → Unity messages in this fixed order (`Awake`, `OnEnable`, `Start`, `FixedUpdate`, collision/trigger callbacks, `Update`, `LateUpdate`, `OnDisable`, `OnDestroy`; Editor-only `OnValidate` and `OnDrawGizmos` go last regardless of when they run) → public methods → private methods → nested types. Within a group, order by importance, not alphabetically. The split of "fields" into constants/statics/serialized/other is ours. **[project decision]**
- **MUST** keep Unity messages `private` (they are called by the engine, not by code) and never `public`/`virtual` unless a subclass genuinely overrides them.
- **SHOULD** read like a newspaper: the high-level method (`ThrowBall`) above the helpers it calls (`SetInitialVelocity`, `CalculateTrajectory`).
- **SHOULD** keep classes small and single-purpose; when a class grows past a screenful of fields or ~300 lines, split it by responsibility ([03](./03-architecture-patterns.md)). **[project decision — the guide gives no number]**

- *Why:* A fixed order lets a reader (or agent) jump to "the serialized surface", "the lifecycle" or "the API" without scanning; it also minimizes merge conflicts because two people adding methods land in predictable places.
- *Source:* [Style guide e-book, Class organization / The newspaper metaphor](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (Fields, Properties, Events/Delegates, MonoBehaviour methods, Public methods, Private methods), [StyleExample.cs](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md). Execution order itself: [04 Unity scripting rules](./04-unity-scripting-rules.md).

The canonical file — every rule in this document applied at once (`IDamageable` lives in its own file, `IDamageable.cs`, in the same namespace):

```csharp
// IDamageable.cs
namespace SheNicest.Player
{
    public interface IDamageable
    {
        void ApplyDamage(int amount);
    }
}
```

```csharp
// PlayerHealth.cs
using System;
using UnityEngine;

namespace SheNicest.Player
{
    /// <summary>
    /// Tracks the player's hit points and announces damage and death.
    /// </summary>
    public class PlayerHealth : MonoBehaviour, IDamageable
    {
        private const int k_MinHealth = 0;

        [Tooltip("Hit points at spawn.")]
        [SerializeField] private int m_maxHealth = 100;

        [Tooltip("Fraction of incoming damage that armor absorbs.")]
        [Range(0f, 1f)]
        [SerializeField] private float m_armor = 0.2f;

        private int m_currentHealth;
        private bool m_isDead;

        public int CurrentHealth => m_currentHealth;
        public int MaxHealth => m_maxHealth;
        public bool IsDead => m_isDead;

        public event Action<int> Damaged;
        public event Action Died;

        private void Awake()
        {
            m_currentHealth = m_maxHealth;
        }

        /// <summary>
        /// Applies <paramref name="amount"/> of damage after armor and raises
        /// <see cref="Damaged"/> and, on reaching zero, <see cref="Died"/>.
        /// </summary>
        public void ApplyDamage(int amount)
        {
            if (m_isDead)
            {
                return;
            }

            int absorbedAmount = Mathf.RoundToInt(amount * (1f - m_armor));
            m_currentHealth = Mathf.Max(k_MinHealth, m_currentHealth - absorbedAmount);
            OnDamaged(absorbedAmount);

            if (m_currentHealth == k_MinHealth)
            {
                m_isDead = true;
                OnDied();
            }
        }

        public bool CanSurvive(int amount)
        {
            return m_currentHealth > amount;
        }

        private void OnDamaged(int amount)
        {
            Damaged?.Invoke(amount);
        }

        private void OnDied()
        {
            Died?.Invoke();
        }
    }
}
```

## Properties vs fields and `[SerializeField]`

- **MUST** never expose a public field on a `MonoBehaviour` or `ScriptableObject`. Inspector-editable data is a `[SerializeField] private` (or `protected`) field; code reads it through a property.
- **MUST** write read-only properties expression-bodied (`public int MaxHealth => m_maxHealth;`); anything with a setter uses `{ get; private set; }` or explicit `get =>`/`set =>` accessors on separate lines. Prefer a private setter; make it public only when external writes are part of the design.
- **MUST** put `[SerializeField]` on the same line as the field, after `[Tooltip]`/`[Range]`/`[Header]` lines: `[SerializeField] private float m_speed = 5f;` **[project decision]**
- **MUST** attach a `[Tooltip("…")]` to every serialized field whose meaning or unit is not obvious from its name; the tooltip replaces the comment.
- **SHOULD** use `[Range(min, max)]` for tunable numbers and `[Header("…")]` to group long Inspector lists; group related values in a `[Serializable]` struct/class with PascalCase public fields (the only place public fields are allowed).
- **MAY** use `[field: SerializeField] public int MaxHealth { get; private set; }` when a property must be both serialized and auto-implemented; prefer the explicit backing field because the Inspector label and YAML key then match the field name. In 6.3 `[SerializeField]` compiles only on fields, so `[SerializeField]` directly on a property is an error.
- **MUST** use a method, not a property, for anything that computes, allocates or has side effects (`GetDistanceToTarget()`, not `DistanceToTarget`).
- Renaming a serialized field requires `[FormerlySerializedAs]` — rule in [04](./04-unity-scripting-rules.md).

- *Why:* A public field lets any script overwrite tuning data; `[SerializeField] private` keeps the Inspector workflow and the encapsulation. Unity serializes neither `static`, `const` nor `readonly` fields, which is why the IDE must not "helpfully" add `readonly`.
- *Source:* [Style guide e-book, Properties / Serialization](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [Scripting API: SerializeField](../reference/scripting/scriptref-serializefield.md), [Serialization rules](../reference/scripting/manual-script-serialization-rules.md) (not static/const/readonly), [Upgrade to Unity 6.3 — SerializeField restriction to fields](../reference/unity6-release/manual-upgradeguideunity63.md) (`[field: SerializeField]`), [TooltipAttribute](../reference/scripting/scriptref-tooltipattribute.md), [RangeAttribute](../reference/scripting/scriptref-rangeattribute.md), [HeaderAttribute](../reference/scripting/scriptref-headerattribute.md), [FormerlySerializedAsAttribute](../reference/scripting/scriptref-serialization-formerlyserializedasattribute.md).

```csharp
// ✅
[Serializable]
public struct PlayerStats
{
    public int MovementSpeed;
    public int HitPoints;
    public bool HasHealthPotion;
}

[Header("Tuning")]
[Tooltip("Units per second on flat ground.")]
[SerializeField] private float m_moveSpeed = 5f;
[SerializeField] private PlayerStats m_stats;

public float MoveSpeed => m_moveSpeed;

// ❌
public float moveSpeed = 5f;                       // public field, wrong casing
[SerializeField] public float MoveSpeed2;          // attribute + public is redundant
[SerializeField] private readonly float m_gravity; // readonly is never serialized
[SerializeField] public int Health { get; set; }   // compile error in 6.3
```

## Comments and documentation

- **SHOULD** comment only what the code cannot say: the *why*, a non-obvious constraint, a workaround with its issue link. If a comment explains *what* a block does, extract a well-named method instead.
- **MUST** write `//` comments on their own line above the code, one space after `//`, starting with a capital and ending with a period. Trailing comments are allowed only for `[Flags]` bit tables.
- **MUST** put a `/// <summary>` on every public type and on public methods whose name and signature do not fully explain them; use `<param>`, `<returns>`, `<paramref>` and `<see cref="…"/>` when they add information. Private members get a summary only when non-obvious.
- **MUST NOT** leave commented-out code, dev-diary comments, `TODO`s without an owner, or decorative `/***` banners. A `TODO` reads `// TODO(name): what, by when.` and is removed when done. **[project decision on the TODO format]**
- **MUST NOT** write `/* … */` block comments except for a multi-line license notice required by a third party.

- *Why:* Comments that restate code rot on the first refactor; summaries feed IntelliSense and agent context, which is where they pay for themselves.
- *Source:* [Style guide e-book, Comments](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [Microsoft coding conventions, Comment style](../reference/csharp-style/learn-microsoft-com-coding-conventions.md), [Microsoft recommended XML tags](../reference/csharp-style/learn-microsoft-com-recommended-tags.md) (`<summary>` at minimum).

## `var`, strings and LINQ (style level)

### `var`

- **SHOULD** use `var` when the type is written on the right-hand side — `new T(...)` or an explicit cast to a non-built-in type — and for `foreach` iteration variables; **MUST** write the type when it comes from a method call or property (`int maximum = ExampleClass.ResultSoFar();`, not `var`).
- **MUST NOT** use `var` for built-in types at all (`int count = 27;`, `float speed = GetSpeed();`) — this is `csharp_style_var_for_built_in_types = false` in the appendix.
- **MAY** use target-typed `new()` for field initializers where the type is on the left (`private readonly List<int> m_ids = new();`); for locals prefer `var ids = new List<int>();`. **[project decision]**

- *Why:* Reviewers and agents read diffs without hover types; `var` is only free when the type is already on the line. In `foreach`, `var` guarantees the element type the enumerator provides and avoids a silent implicit conversion.
- *Source:* [Style guide e-book, Fields and variables](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (`var` when clear from context, `foreach` rationale), [Microsoft coding conventions, Implicitly typed local variables](../reference/csharp-style/learn-microsoft-com-coding-conventions.md) (clear only for `new`, cast, literal; we exclude literals so the prose matches `csharp_style_var_for_built_in_types = false`, and Microsoft discourages `var` in `foreach` — Unity's guidance wins; both **[project decision]**), [Microsoft coding conventions, `new` operator](../reference/csharp-style/learn-microsoft-com-coding-conventions.md).

```csharp
var enemies = new List<Enemy>();                 // ✅ type visible on the right
var boxCollider = (BoxCollider)hit.collider;     // ✅ explicit cast
int activeCount = m_spawner.GetActiveCount();    // ✅ explicit: the type comes from a call
int maxEnemies = 8;                              // ✅ built-in type, written even for a literal

foreach (var enemy in enemies)                   // ✅ matches the enumerator's element type
{
    enemy.Tick();
}

var result = m_spawner.Spawn();                  // ❌ what is result?
```

### Strings

- **SHOULD** build short strings with interpolation (`$"{name}: {score}"`), never `+` chains; use `System.Text.StringBuilder` when appending in a loop.
- **MUST** use language keywords for types (`string`, `int`, `float`), not `String`, `Int32`, `Single`.
- **SHOULD** hoist strings used as Unity lookups into constants or hashed IDs (`private static readonly int k_SpeedHash = Animator.StringToHash("Speed");`) — the rule is stylistic here; the performance reasoning is in [05](./05-performance.md).
- **NEVER** use raw string literals (`"""`) — C# 11.

- *Why:* Interpolated strings read as the sentence they produce; repeated concatenation allocates a new string per `+`.
- *Source:* [Microsoft coding conventions, String data / Language guidelines](../reference/csharp-style/learn-microsoft-com-coding-conventions.md), [Unity programming best practices](../reference/scripting/manual-programming-best-practices.md) ("Avoid repeated string operations like concatenation"), [Animator.StringToHash](../reference/scripting/scriptref-animator-stringtohash.md).

### LINQ

- **MAY** use LINQ in Editor code, tests and one-off initialization where it is clearer than a loop.
- LINQ in `Update`/`FixedUpdate`/`LateUpdate` or any per-frame path is banned by [05 Performance](./05-performance.md) (allocation rules); this section only covers how LINQ is written where it is allowed.
- **SHOULD** give query variables meaningful names and use `var` for query results (they are often anonymous or deeply generic types).

- *Why:* Where LINQ is allowed, a readable query beats a hand-rolled loop; where it is not, 05 owns the reasoning.
- *Source:* [Unity programming best practices](../reference/scripting/manual-programming-best-practices.md) ("Avoid use of LINQ in runtime code, and especially in the context of the per-frame Update or FixedUpdate"), [Microsoft coding conventions, LINQ queries](../reference/csharp-style/learn-microsoft-com-coding-conventions.md).

### Null checks on Unity objects (style hook only)

**NEVER** apply `??`, `?.` or `is null` to a `UnityEngine.Object` reference — rule and rationale in [04](./04-unity-scripting-rules.md); `?.Invoke` on a C# event is fine. The appendix sets `dotnet_style_null_propagation`, `dotnet_style_coalesce_expression` and `dotnet_style_prefer_is_null_check_over_reference_equality_method` to `false` so the IDE stops suggesting the unsafe forms.

- *Source:* [Object (6.3 Manual), Custom equality operators](../reference/scripting/manual-class-object.md); the `.editorconfig` keys are in [Microsoft code-style rule options](../reference/csharp-style/learn-microsoft-com-code-style-rule-options.md).

## Script templates

New scripts from **Assets > Create > Scripting** come from text templates. Project-level templates live in `Assets/ScriptTemplates/` (a sanctioned root-level folder — Unity only reads templates there; it is listed in the folder tree of [02 Project structure](./02-project-structure.md)) and override the Editor's defaults; relaunch the Editor after adding or editing them. Keep only the templates we change. **[project decision — folder location fixed by Unity, the decision is to ship project templates at all]**

- *Why:* Every new file then starts in project style with the namespace, an explicit modifier on `Awake`, and without the unused `Update` method and comments an agent would otherwise have to delete.
- *Source:* [Style guide e-book, Appendix: Script templates](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) (paths, `/Assets/ScriptTemplates`, keywords, `PriorityNumber-MenuPath-DefaultName.FileExtension.txt` naming, 6.x file names), [Project organization e-book, Code standards](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) (default template with `#ROOTNAMESPACEBEGIN#`/`#ROOTNAMESPACEEND#`), [How to customize Unity script templates (Unity Support)](../reference/csharp-style/hc-210223733-how-to-customize-unity-script-templates.md) (keep `#SCRIPTNAME#`, relaunch the Editor), [Unity patterns demo templates](../reference/csharp-style/github-game-programming-patterns-demo-81-c-script-newbehaviourscript-cs-txt.md).

Keywords: `#SCRIPTNAME#` is the file name you typed; `#NOTRIM#` keeps a blank line between braces; `#ROOTNAMESPACEBEGIN#`/`#ROOTNAMESPACEEND#` wrap the class in a namespace block when a root namespace is available — the asmdef's *Root Namespace* (set in [02](./02-project-structure.md)) and, as fallback, **Edit > Project Settings > Editor > C# Project Generation > Root namespace** (set it to `SheNicest`). *(Observed 6000.3 Editor behaviour; the manual documents the settings but not the keyword expansion.)* After creating a file, change the namespace to the folder's sub-namespace (`SheNicest.Player`) if the expansion only produced the root.

`Assets/ScriptTemplates/1-Scripting__MonoBehaviour Script-NewMonoBehaviourScript.cs.txt`:

```text
using UnityEngine;

#ROOTNAMESPACEBEGIN#
public class #SCRIPTNAME# : MonoBehaviour
{
    private void Awake()
    {
        #NOTRIM#
    }
}
#ROOTNAMESPACEEND#
```

`Assets/ScriptTemplates/2-Scripting__ScriptableObject Script-NewScriptableObjectScript.cs.txt`:

```text
using UnityEngine;

#ROOTNAMESPACEBEGIN#
[CreateAssetMenu(fileName = "#SCRIPTNAME#", menuName = "SheNicest/#SCRIPTNAME#")]
public class #SCRIPTNAME# : ScriptableObject
{
    #NOTRIM#
}
#ROOTNAMESPACEEND#
```

The template cannot strip the `SO` suffix, so after creating the file edit the attribute to `fileName = "<Name without SO>"` and `menuName = "SheNicest/<Category>/<Display Name>"` (e.g. `fileName = "EnemyConfig", menuName = "SheNicest/Enemies/Enemy Config"`), matching the examples in [03](./03-architecture-patterns.md) — asset files never carry the `SO` suffix.

- *Source for `CreateAssetMenu(fileName, menuName)`:* [ScriptableObject (6.3 Manual)](../reference/scripting/manual-class-scriptableobject.md). The `SheNicest/` menu root is a **[project decision]**.

## Applying the `.editorconfig`

- **MUST** keep the file in the appendix at the repository root as `.editorconfig` (`root = true`); never add nested `.editorconfig` files under `Assets/`.
- **MUST** set **Edit > Project Settings > Editor > Line Endings For New Scripts > Mode = Unix** so files Unity creates already match `end_of_line = lf`.
- **SHOULD** run *Format Document* (Visual Studio: **Edit > Advanced > Format Document**, Ctrl+K Ctrl+D; Rider/VS Code have equivalents) before every commit; Visual Studio, Rider and VS Code (with the EditorConfig extension) read the file natively. IDE setup and optional Roslyn analyzers: [08 Testing and tooling](./08-testing-tooling.md).
- Naming rules in the file surface as IDE **warnings** **[project decision — Boss Room uses `suggestion`]**; Unity's own compiler does not run IDE style rules, so a style violation never breaks a build — reviewers and agents enforce it.

- *Why:* One file that travels with the repo beats exported IDE settings; it takes precedence over personal editor preferences and works in every editor the team uses.
- *Source:* [Style guide e-book, What is EditorConfig? / Code formatting in Visual Studio](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md), [Microsoft code-style rule options](../reference/csharp-style/learn-microsoft-com-code-style-rule-options.md), [How to debug game code with Roslyn Analyzers](../reference/csharp-style/how-to-debugging-with-rosyln-analyzers.md), [Editor settings — Line Endings For New Scripts](../reference/version-control/manual-class-editormanager.md), [EditorSettings.lineEndingsForNewScripts](../reference/csharp-style/scriptref-editorsettings-lineendingsfornewscripts.md), [Assembly Definition Inspector — Root Namespace](../reference/project-structure/manual-class-assemblydefinitionimporter.md).

## Anti-patterns

- ❌ `public float speed;` on a MonoBehaviour → ✅ `[SerializeField] private float m_speed;` + `public float Speed => m_speed;`
- ❌ `int health;` (no modifier, no prefix) → ✅ `private int m_health;`
- ❌ `const int MAX_ENEMIES = 8;` / `static readonly int SpeedHash` → ✅ `private const int k_MaxEnemies = 8;` / `private static readonly int k_SpeedHash`
- ❌ `bool dead;` / `bool Dead()` → ✅ `bool m_isDead;` / `bool IsDead()`
- ❌ `public enum WeaponTypes { knife, gun }` → ✅ `public enum WeaponType { Knife, Gun }`
- ❌ `public class EnemyConfig : ScriptableObject` → ✅ `public class EnemyConfigSO : ScriptableObject` (asset: `HoverBot.asset`, no suffix)
- ❌ `public event Action OnDoorOpen;` raised inline → ✅ `public event Action DoorOpened;` raised from `OnDoorOpened()` (event channels keep `EventRaised`/`RaiseEvent`, listeners `On<ChannelField>`)
- ❌ `if (x) DoThing();` / K&R `if (x) {` → ✅ Allman braces on a separate line, always
- ❌ `var hp = GetHealth();` → ✅ `int hitPoints = GetHealth();`
- ❌ `m_rigidbody?.AddForce(f)` / `m_target ?? fallback` → ✅ `if (m_rigidbody != null) { … }` / `if (m_target == null) { m_target = fallback; }`
- ❌ `[SerializeField] private readonly Transform m_anchor;` → ✅ drop `readonly`; Unity cannot serialize it
- ❌ `#region Unity Methods … #endregion` → ✅ member ordering from *Class layout*, split the class if it is long
- ❌ `// Created by X on 2026-08-23` / `// float oldSpeed = 3f;` → ✅ delete; Git has it
- ❌ `namespace SheNicest.Scripts.Runtime.Player` / `namespace SheNicest;` → ✅ `namespace SheNicest.Player { … }`
- ❌ `using UnityEngine;` inside the namespace, or left-over unused usings → ✅ outside, sorted, trimmed
- ❌ `public record Stats(int Hp);` / `public int Hp { get; init; }` → ✅ `[Serializable] public struct Stats { public int HitPoints; }`
- ❌ `public float Speed = 1f;` aligned in columns with other fields → ✅ one space between type and name
- ❌ `enemies.Where(e => e.IsAlive).ToList()` in `Update` → ✅ `for` loop over a cached list

## Review checklist

- [ ] Every type lives in `SheNicest.<Feature>` matching its folder; one `MonoBehaviour`/`ScriptableObject` per file; file name = class name.
- [ ] Casing and prefixes match the table (`m_`, `s_`, `k_`, `I`, PascalCase members, camelCase locals/parameters); no Hungarian notation, abbreviations, puns or redundant class-name repeats.
- [ ] Every member has an explicit access modifier; no `= 0`/`= null`/`= false` initializers; one declaration per line.
- [ ] Booleans and bool methods read as questions; methods start with verbs; enums are singular (plural for `[Flags]`).
- [ ] ScriptableObject classes end with `SO`; their asset files do not.
- [ ] Events are verb-phrase `Action`s raised from `On<Event>()`, subscribed in `OnEnable`, unsubscribed in `OnDisable`, handled in `Subject_Event()` (event-channel listeners: `On<ChannelField>`).
- [ ] Allman braces, 4 spaces, braces on every block, `default` in every `switch`, ≤ 120 columns, one blank line between members, no column alignment.
- [ ] `using` directives outside the namespace, `System` first, then alphabetical, none unused; no `#region`; no headers; no commented-out code.
- [ ] Member order: constants/statics → serialized fields → fields → properties → events → Unity messages → public → private → nested.
- [ ] No public fields on Unity objects; `[SerializeField] private` with `[Tooltip]` where needed; no `readonly` on serialized fields; renamed serialized fields carry `[FormerlySerializedAs]`.
- [ ] `var` only with `new`/cast to a non-built-in type/`foreach`, never for built-in types; no `??`/`?.`/`is null` on `UnityEngine.Object`; no LINQ in per-frame code ([05](./05-performance.md)).
- [ ] No C# features above 9.0 (`record`, `init`, file-scoped namespace, raw strings, collection expressions, `required`).
- [ ] Public types and non-obvious public methods have `/// <summary>`; comments explain *why*, are sentences, and sit on their own line.
- [ ] The file was formatted with the IDE against the repo `.editorconfig` and shows no naming-rule warnings.

## Sources

1. [ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) — Use a C# style guide for clean and scalable game code (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/f5vqx76rkt57bw9rjptcbcpv/Use_a_C__style_guide_for_clean_and_scalable_game_code_Unity_6_edition_e-book.pdf
2. [github-unity-code-style-guide-styleexample-cs.md](../reference/csharp-style/github-unity-code-style-guide-styleexample-cs.md) — StyleExample.cs (Unity C# style guide example script) — https://raw.githubusercontent.com/thomasjacobsen-unity/Unity-Code-Style-Guide/master/StyleExample.cs
3. [github-unity-code-style-guide-readme.md](../reference/csharp-style/github-unity-code-style-guide-readme.md) — Unity-Code-Style-Guide README — https://raw.githubusercontent.com/thomasjacobsen-unity/Unity-Code-Style-Guide/master/README.md
4. [how-to-naming-and-code-style-tips-c-scripting-unity.md](../reference/csharp-style/how-to-naming-and-code-style-tips-c-scripting-unity.md) — Naming and code style tips for C# scripting in Unity — https://unity.com/how-to/naming-and-code-style-tips-c-scripting-unity
5. [how-to-formatting-best-practices-c-scripting-unity.md](../reference/csharp-style/how-to-formatting-best-practices-c-scripting-unity.md) — Formatting best practices for C# scripting in Unity — https://unity.com/how-to/formatting-best-practices-c-scripting-unity
6. [blog-clean-up-your-code-how-to-create-your-own-c-code-style.md](../reference/csharp-style/blog-clean-up-your-code-how-to-create-your-own-c-code-style.md) — Clean up your code: How to create your own C# code style — https://unity.com/blog/engine-platform/clean-up-your-code-how-to-create-your-own-c-code-style
7. [github-com-unity-multiplayer-samples-coop-editorconfig.md](../reference/csharp-style/github-com-unity-multiplayer-samples-coop-editorconfig.md) — Boss Room sample: .editorconfig — https://raw.githubusercontent.com/Unity-Technologies/com.unity.multiplayer.samples.coop/main/.editorconfig
8. [github-graphics-editorconfig.md](../reference/csharp-style/github-graphics-editorconfig.md) — Unity Graphics repo: .editorconfig (6000.3) — https://raw.githubusercontent.com/Unity-Technologies/Graphics/6000.3/staging/.editorconfig
9. [github-open-project-1-editorconfig.md](../reference/csharp-style/github-open-project-1-editorconfig.md) — Unity Open Project #1: .editorconfig — https://raw.githubusercontent.com/UnityTechnologies/open-project-1/main/UOP1_Project/.editorconfig
10. [learn-microsoft-com-code-style-rule-options.md](../reference/csharp-style/learn-microsoft-com-code-style-rule-options.md) — Microsoft: Code-style rule options (.editorconfig) — https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options
11. [learn-microsoft-com-coding-conventions.md](../reference/csharp-style/learn-microsoft-com-coding-conventions.md) — Microsoft: Common C# code conventions — https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions
12. [learn-microsoft-com-identifier-names.md](../reference/csharp-style/learn-microsoft-com-identifier-names.md) — Microsoft: C# identifier names — https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/identifier-names
13. [learn-microsoft-com-capitalization-conventions.md](../reference/csharp-style/learn-microsoft-com-capitalization-conventions.md) — Microsoft: Capitalization Conventions — https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions
14. [learn-microsoft-com-general-naming-conventions.md](../reference/csharp-style/learn-microsoft-com-general-naming-conventions.md) — Microsoft: General Naming Conventions — https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/general-naming-conventions
15. [learn-microsoft-com-recommended-tags.md](../reference/csharp-style/learn-microsoft-com-recommended-tags.md) — Microsoft: Recommended XML tags for C# documentation comments — https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/recommended-tags
16. [manual-csharp-compiler.md](../reference/csharp-style/manual-csharp-compiler.md) — Unity 6.3 Manual: C# compiler and language version reference — https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html
17. [manual-naming-scripts.md](../reference/csharp-style/manual-naming-scripts.md) — Unity 6.3 Manual: Naming scripts — https://docs.unity3d.com/6000.3/Documentation/Manual/naming-scripts.html
18. [scriptref-editorsettings-lineendingsfornewscripts.md](../reference/csharp-style/scriptref-editorsettings-lineendingsfornewscripts.md) — Scripting API: EditorSettings.lineEndingsForNewScripts — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorSettings-lineEndingsForNewScripts.html
19. [how-to-debugging-with-rosyln-analyzers.md](../reference/csharp-style/how-to-debugging-with-rosyln-analyzers.md) — How to debug game code with Roslyn Analyzers — https://unity.com/how-to/debugging-with-rosyln-analyzers
20. [hc-210223733-how-to-customize-unity-script-templates.md](../reference/csharp-style/hc-210223733-how-to-customize-unity-script-templates.md) — How to customize Unity script templates (Unity Support) — https://support.unity.com/hc/en-us/articles/210223733-How-to-customize-Unity-script-templates
21. [github-game-programming-patterns-demo-81-c-script-newbehaviourscript-cs-txt.md](../reference/csharp-style/github-game-programming-patterns-demo-81-c-script-newbehaviourscript-cs-txt.md) — game-programming-patterns-demo MonoBehaviour script template — https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/ScriptTemplates/81-C%23%20Script-NewBehaviourScript.cs.txt
22. [manual-naming-conventions.md](../reference/csharp-style/manual-naming-conventions.md) — Unity 6.3 Manual: UI Toolkit naming conventions — https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/naming-conventions.html
23. [scriptref-serializefield.md](../reference/scripting/scriptref-serializefield.md) — Scripting API: SerializeField — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html
24. [manual-script-serialization-rules.md](../reference/scripting/manual-script-serialization-rules.md) — Unity 6.3 Manual: Serialization rules — https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html
25. [manual-upgradeguideunity63.md](../reference/unity6-release/manual-upgradeguideunity63.md) — Upgrade to Unity 6.3 (SerializeField restriction to fields) — https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html
26. [scriptref-serialization-formerlyserializedasattribute.md](../reference/scripting/scriptref-serialization-formerlyserializedasattribute.md) — Scripting API: Serialization.FormerlySerializedAsAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Serialization.FormerlySerializedAsAttribute.html
27. [scriptref-tooltipattribute.md](../reference/scripting/scriptref-tooltipattribute.md) — Scripting API: TooltipAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/TooltipAttribute.html
28. [scriptref-rangeattribute.md](../reference/scripting/scriptref-rangeattribute.md) — Scripting API: RangeAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RangeAttribute.html
29. [scriptref-headerattribute.md](../reference/scripting/scriptref-headerattribute.md) — Scripting API: HeaderAttribute — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HeaderAttribute.html
30. [manual-class-object.md](../reference/scripting/manual-class-object.md) — Object (Unity 6.3 Manual), custom equality operators — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html
31. [manual-programming-best-practices.md](../reference/scripting/manual-programming-best-practices.md) — Unity 6.3 Manual: Unity programming best practices — https://docs.unity3d.com/6000.3/Documentation/Manual/programming-best-practices.html
32. [scriptref-animator-stringtohash.md](../reference/scripting/scriptref-animator-stringtohash.md) — Scripting API: Animator.StringToHash — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html
33. [manual-class-scriptableobject.md](../reference/scripting/manual-class-scriptableobject.md) — ScriptableObject (Unity 6.3 Manual) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html
34. [ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md](../reference/project-structure/ebook-best-practices-for-project-organization-and-version-control-unity-6-ed.md) — Best practices for project organization and version control (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/hnnjs88z588fn62jggh9br6/Best_practices_for_project_organization_and_version_control_Unity_6_edition.pdf
35. [manual-class-editormanager.md](../reference/version-control/manual-class-editormanager.md) — Unity 6.3 Manual: Editor settings (Line Endings For New Scripts, C# Project Generation > Root namespace) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-EditorManager.html
36. [manual-class-assemblydefinitionimporter.md](../reference/project-structure/manual-class-assemblydefinitionimporter.md) — Unity 6.3 Manual: Assembly Definition Inspector window reference (Root Namespace) — https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html
37. [ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md](../reference/design-patterns/ebook-modular-game-architecture-with-scriptableobjects-unity-6-final.md) — Create modular game architecture with ScriptableObjects (Unity 6 edition) — https://cdn.bfldr.com/S5BC9Y64/at/5xhgncq5b6p565fqvhb5kx5/Modular_game_architecture_with_ScriptableObjects_Unity_6_Final.pdf

## Appendix: .editorconfig

Copy this file verbatim to the repository root as `.editorconfig`. It merges the Unity style guide's settings with the formatting keys of the Graphics and Open Project #1 files and the naming-rule structure of Boss Room, with this project's prefixes. Keys whose values deviate from Unity's files are commented with the reason.

```ini
# EditorConfig for shenicest-2026 — the executable form of docs/guidelines/01-csharp-style.md.
# Derived from Unity's C# style guide (Unity 6 edition) and Unity-staff .editorconfig files
# (Boss Room, Graphics 6000.3, Open Project #1). https://editorconfig.org/
root = true

#### All files ####
[*]
end_of_line = lf
charset = utf-8
indent_style = space
indent_size = 4
tab_width = 4
trim_trailing_whitespace = true
insert_final_newline = true

#### Formats whose layout is fixed by the tool that writes them ####
[*.{md,markdown}]
# Trailing whitespace is significant in Markdown.
trim_trailing_whitespace = false

[*.json]
indent_size = 2

[*.asmdef]
indent_size = 4

[*.{cg,cginc,glslinc,hlsl,shader}]
indent_size = 4

[*.{uss,uxml}]
indent_size = 4

[{Makefile,makefile}]
# Tab characters are part of the Makefile format.
indent_style = tab

[*.{bat,cmd}]
end_of_line = crlf

#### C# ####
[*.cs]
# Informational: Rider draws a margin guide at this column; the Roslyn formatter in
# Visual Studio/VS Code ignores it. Reviewers enforce the limit.
max_line_length = 120

# New lines — Allman style everywhere.
csharp_new_line_before_open_brace = all
csharp_new_line_before_else = true
csharp_new_line_before_catch = true
csharp_new_line_before_finally = true
csharp_new_line_before_members_in_object_initializers = true
csharp_new_line_before_members_in_anonymous_types = true
csharp_new_line_between_query_expression_clauses = true

# Indentation.
csharp_indent_block_contents = true
csharp_indent_braces = false
csharp_indent_case_contents = true
csharp_indent_case_contents_when_block = false
csharp_indent_switch_labels = true
csharp_indent_labels = one_less_than_current

# Spacing.
csharp_space_after_cast = false
csharp_space_after_keywords_in_control_flow_statements = true
csharp_space_between_parentheses = false
csharp_space_before_colon_in_inheritance_clause = true
csharp_space_after_colon_in_inheritance_clause = true
csharp_space_around_binary_operators = before_and_after
csharp_space_between_method_declaration_parameter_list_parentheses = false
csharp_space_between_method_declaration_empty_parameter_list_parentheses = false
csharp_space_between_method_declaration_name_and_open_parenthesis = false
csharp_space_between_method_call_parameter_list_parentheses = false
csharp_space_between_method_call_empty_parameter_list_parentheses = false
csharp_space_between_method_call_name_and_opening_parenthesis = false
csharp_space_after_comma = true
csharp_space_before_comma = false
csharp_space_after_dot = false
csharp_space_before_dot = false
csharp_space_after_semicolon_in_for_statement = true
csharp_space_before_semicolon_in_for_statement = false
csharp_space_around_declaration_statements = false
csharp_space_before_open_square_brackets = false
csharp_space_between_empty_square_brackets = false
csharp_space_between_square_brackets = false

# Wrapping — one statement per line; `{ get; set; }` may stay on one line.
csharp_preserve_single_line_statements = false
csharp_preserve_single_line_blocks = true
dotnet_style_operator_placement_when_wrapping = beginning_of_line
dotnet_style_allow_multiple_blank_lines_experimental = false

# using directives — outside the namespace, System first, no group gaps.
csharp_using_directive_placement = outside_namespace
dotnet_sort_system_directives_first = true
dotnet_separate_import_directive_groups = false

# Namespaces — C# 9 has block-scoped only. Folders mirror namespaces minus
# Scripts/Runtime, so the IDE's folder-match check would be wrong: off.
csharp_style_namespace_declarations = block_scoped
dotnet_style_namespace_match_folder = false

# Modifiers — always explicit. Unity never serializes readonly fields, so the
# IDE must not add readonly to [SerializeField] fields.
dotnet_style_require_accessibility_modifiers = for_non_interface_members
csharp_preferred_modifier_order = public,private,protected,internal,static,extern,new,virtual,abstract,sealed,override,readonly,unsafe,volatile,async
dotnet_style_readonly_field = false

# this. qualification — the m_/s_/k_ prefixes make it redundant.
dotnet_style_qualification_for_field = false
dotnet_style_qualification_for_property = false
dotnet_style_qualification_for_method = false
dotnet_style_qualification_for_event = false

# Language keywords (int, string, float) over BCL names (Int32, String, Single).
dotnet_style_predefined_type_for_locals_parameters_members = true
dotnet_style_predefined_type_for_member_access = true

# var — only when the type is apparent on the right-hand side; never for built-in types.
csharp_style_var_for_built_in_types = false
csharp_style_var_when_type_is_apparent = true
csharp_style_var_elsewhere = false

# Expression-bodied members — properties and accessors yes, methods and constructors no.
csharp_style_expression_bodied_properties = true
csharp_style_expression_bodied_accessors = true
csharp_style_expression_bodied_indexers = true
csharp_style_expression_bodied_lambdas = true
csharp_style_expression_bodied_methods = false
csharp_style_expression_bodied_constructors = false
csharp_style_expression_bodied_operators = false
csharp_style_expression_bodied_local_functions = false
# We keep explicit m_ backing fields for [SerializeField]; never suggest auto-properties.
dotnet_style_prefer_auto_properties = false

# Braces on every block.
csharp_prefer_braces = true

# Null checks — ?? ?. and `is null` bypass UnityEngine.Object's custom ==.
# Keep the IDE from suggesting them; ?.Invoke on delegates stays allowed.
dotnet_style_null_propagation = false
dotnet_style_coalesce_expression = false
dotnet_style_prefer_is_null_check_over_reference_equality_method = false
csharp_style_conditional_delegate_call = true

# Parentheses for clarity in mixed expressions.
dotnet_style_parentheses_in_arithmetic_binary_operators = always_for_clarity
dotnet_style_parentheses_in_relational_binary_operators = always_for_clarity
dotnet_style_parentheses_in_other_binary_operators = always_for_clarity
dotnet_style_parentheses_in_other_operators = never_if_unnecessary

# Initializers.
dotnet_style_object_initializer = true
dotnet_style_collection_initializer = true

# Unity messages routinely ignore parameters (OnCollisionEnter(Collision) ...).
dotnet_code_quality_unused_parameters = all:silent

# No file headers — version control carries authorship.
file_header_template = unset

#### Naming ####
# Styles
dotnet_naming_style.pascal_case.required_prefix =
dotnet_naming_style.pascal_case.required_suffix =
dotnet_naming_style.pascal_case.word_separator =
dotnet_naming_style.pascal_case.capitalization = pascal_case

dotnet_naming_style.camel_case.required_prefix =
dotnet_naming_style.camel_case.required_suffix =
dotnet_naming_style.camel_case.word_separator =
dotnet_naming_style.camel_case.capitalization = camel_case

dotnet_naming_style.begins_with_i.required_prefix = I
dotnet_naming_style.begins_with_i.required_suffix =
dotnet_naming_style.begins_with_i.word_separator =
dotnet_naming_style.begins_with_i.capitalization = pascal_case

dotnet_naming_style.begins_with_m_.required_prefix = m_
dotnet_naming_style.begins_with_m_.required_suffix =
dotnet_naming_style.begins_with_m_.word_separator =
dotnet_naming_style.begins_with_m_.capitalization = camel_case

dotnet_naming_style.begins_with_s_.required_prefix = s_
dotnet_naming_style.begins_with_s_.required_suffix =
dotnet_naming_style.begins_with_s_.word_separator =
dotnet_naming_style.begins_with_s_.capitalization = camel_case

dotnet_naming_style.begins_with_k_.required_prefix = k_
dotnet_naming_style.begins_with_k_.required_suffix =
dotnet_naming_style.begins_with_k_.word_separator =
dotnet_naming_style.begins_with_k_.capitalization = pascal_case

# Symbols
dotnet_naming_symbols.interface.applicable_kinds = interface
dotnet_naming_symbols.interface.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.interface.required_modifiers =

dotnet_naming_symbols.types.applicable_kinds = class, struct, interface, enum, delegate
dotnet_naming_symbols.types.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.types.required_modifiers =

dotnet_naming_symbols.non_field_members.applicable_kinds = property, event, method
dotnet_naming_symbols.non_field_members.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.non_field_members.required_modifiers =

dotnet_naming_symbols.public_fields.applicable_kinds = field
dotnet_naming_symbols.public_fields.applicable_accessibilities = public
dotnet_naming_symbols.public_fields.required_modifiers =

dotnet_naming_symbols.non_public_const_fields.applicable_kinds = field
dotnet_naming_symbols.non_public_const_fields.applicable_accessibilities = internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.non_public_const_fields.required_modifiers = const

dotnet_naming_symbols.public_const_fields.applicable_kinds = field
dotnet_naming_symbols.public_const_fields.applicable_accessibilities = public
dotnet_naming_symbols.public_const_fields.required_modifiers = const

dotnet_naming_symbols.public_static_readonly_fields.applicable_kinds = field
dotnet_naming_symbols.public_static_readonly_fields.applicable_accessibilities = public
dotnet_naming_symbols.public_static_readonly_fields.required_modifiers = readonly, static

dotnet_naming_symbols.non_public_static_readonly_fields.applicable_kinds = field
dotnet_naming_symbols.non_public_static_readonly_fields.applicable_accessibilities = internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.non_public_static_readonly_fields.required_modifiers = readonly, static

dotnet_naming_symbols.non_public_static_fields.applicable_kinds = field
dotnet_naming_symbols.non_public_static_fields.applicable_accessibilities = internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.non_public_static_fields.required_modifiers = static

dotnet_naming_symbols.non_public_fields.applicable_kinds = field
dotnet_naming_symbols.non_public_fields.applicable_accessibilities = internal, private, protected, protected_internal, private_protected
dotnet_naming_symbols.non_public_fields.required_modifiers =

dotnet_naming_symbols.method_parameters.applicable_kinds = parameter
dotnet_naming_symbols.method_parameters.applicable_accessibilities =
dotnet_naming_symbols.method_parameters.required_modifiers =

dotnet_naming_symbols.local.applicable_kinds = local
dotnet_naming_symbols.local.applicable_accessibilities = local
dotnet_naming_symbols.local.required_modifiers =

# Rules — Roslyn orders these by specificity (accessibilities, then modifiers, then kinds),
# not by file order. A "static" group also matches const fields, so the const and
# static-readonly rules are split by accessibility so they outrank the s_ and public-field
# rules (see the Microsoft naming-rules page linked from the code-style rule options).
# Severity is warning so violations are visible in the IDE.
dotnet_naming_rule.interface_should_be_begins_with_i.severity = warning
dotnet_naming_rule.interface_should_be_begins_with_i.symbols = interface
dotnet_naming_rule.interface_should_be_begins_with_i.style = begins_with_i

dotnet_naming_rule.types_should_be_pascal_case.severity = warning
dotnet_naming_rule.types_should_be_pascal_case.symbols = types
dotnet_naming_rule.types_should_be_pascal_case.style = pascal_case

dotnet_naming_rule.non_field_members_should_be_pascal_case.severity = warning
dotnet_naming_rule.non_field_members_should_be_pascal_case.symbols = non_field_members
dotnet_naming_rule.non_field_members_should_be_pascal_case.style = pascal_case

dotnet_naming_rule.non_public_const_fields_should_be_begins_with_k_.severity = warning
dotnet_naming_rule.non_public_const_fields_should_be_begins_with_k_.symbols = non_public_const_fields
dotnet_naming_rule.non_public_const_fields_should_be_begins_with_k_.style = begins_with_k_

dotnet_naming_rule.public_const_fields_should_be_begins_with_k_.severity = warning
dotnet_naming_rule.public_const_fields_should_be_begins_with_k_.symbols = public_const_fields
dotnet_naming_rule.public_const_fields_should_be_begins_with_k_.style = begins_with_k_

dotnet_naming_rule.public_static_readonly_fields_should_be_begins_with_k_.severity = warning
dotnet_naming_rule.public_static_readonly_fields_should_be_begins_with_k_.symbols = public_static_readonly_fields
dotnet_naming_rule.public_static_readonly_fields_should_be_begins_with_k_.style = begins_with_k_

dotnet_naming_rule.non_public_static_readonly_fields_should_be_begins_with_k_.severity = warning
dotnet_naming_rule.non_public_static_readonly_fields_should_be_begins_with_k_.symbols = non_public_static_readonly_fields
dotnet_naming_rule.non_public_static_readonly_fields_should_be_begins_with_k_.style = begins_with_k_

dotnet_naming_rule.non_public_static_fields_should_be_begins_with_s_.severity = warning
dotnet_naming_rule.non_public_static_fields_should_be_begins_with_s_.symbols = non_public_static_fields
dotnet_naming_rule.non_public_static_fields_should_be_begins_with_s_.style = begins_with_s_

dotnet_naming_rule.public_fields_should_be_pascal_case.severity = warning
dotnet_naming_rule.public_fields_should_be_pascal_case.symbols = public_fields
dotnet_naming_rule.public_fields_should_be_pascal_case.style = pascal_case

dotnet_naming_rule.non_public_fields_should_be_begins_with_m_.severity = warning
dotnet_naming_rule.non_public_fields_should_be_begins_with_m_.symbols = non_public_fields
dotnet_naming_rule.non_public_fields_should_be_begins_with_m_.style = begins_with_m_

dotnet_naming_rule.method_parameters_should_be_camel_case.severity = warning
dotnet_naming_rule.method_parameters_should_be_camel_case.symbols = method_parameters
dotnet_naming_rule.method_parameters_should_be_camel_case.style = camel_case

dotnet_naming_rule.local_should_be_camel_case.severity = warning
dotnet_naming_rule.local_should_be_camel_case.symbols = local
dotnet_naming_rule.local_should_be_camel_case.style = camel_case
```
