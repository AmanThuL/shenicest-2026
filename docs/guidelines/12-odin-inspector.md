# 12. Odin Inspector

> **Scope:** How Odin Inspector is used in this project — what it is for (designer-facing Inspectors for content ScriptableObjects and prefabs), what it is *not* for (serialization, architecture, runtime code), the approved attribute vocabulary, the standard layout of a content asset, validation, editor tooling, and how the plug-in itself is maintained.
> **Applies to:** all C# under `Assets/RootsDance/Scripts` and `Assets/RootsDance/Tests`; the vendor folder `Assets/Plugins/Sirenix/`; the Odin define symbols in `ProjectSettings/`.
> **Status:** Odin Inspector **4.0.2.3** on Unity 6000.3 LTS · last reviewed 2026-08-24

Serialization semantics are owned by [04 Unity scripting rules](./04-unity-scripting-rules.md); ScriptableObject class shapes by [03 Architecture](./03-architecture-patterns.md); where vendor code lives by [02 Project structure](./02-project-structure.md); what gets committed by [06 Version control](./06-version-control.md); the tunables workflow by [11 Scenes, prefabs and team workflow](./11-scenes-prefabs-workflow.md). This document only adds the Odin-specific rules on top of those.

**Why Odin at all.** The game is a fixed-flow narrative exploration/puzzle game: a large number of hand-authored content nodes (investigation objects, plants, puzzles/area states, journal and official-report entries, dialogue) with IDs like `FL-001`, `PUZZLE-A01`, `JOURNAL-005`, prerequisites, results and scene consequences. That data lives in ScriptableObject assets (rule 12 in `AGENTS.md`), and the stock Inspector turns a class with 15 fields and 4 lists into an unreadable wall. Odin gives those assets grouped sections, dropdowns for IDs and assets, inline validation and one-click helpers — which is what lets a designer configure content without a programmer. It was chosen by the team (2026-08-24) over Luban/Excel pipelines *for now*: ScriptableObject + Odin first, an external table pipeline only if the content count ever makes Inspector editing painful. **[project decision]**

## TL;DR — rules at a glance

1. **MUST** treat Odin as an **Editor-UX layer only**: attributes from the `Sirenix.OdinInspector` namespace on `[SerializeField] private` fields, on `[Button]` helper methods and on `[ShowInInspector]` debug members. Everything in [04](./04-unity-scripting-rules.md) about what Unity serializes stays exactly as it is — Odin attributes never change it.
2. **NEVER** use the Odin serializer: no `SerializedMonoBehaviour`, `SerializedScriptableObject`, `SerializedBehaviour`, `SerializedComponent`, `SerializedStateMachineBehaviour`, `[OdinSerialize]`, `[ShowOdinSerializedPropertiesInInspector]` or `using Sirenix.Serialization`. Data that Unity cannot serialize (dictionaries, polymorphic plain classes, nested lists) is remodelled per [04](./04-unity-scripting-rules.md#script-serialization), not rescued with Odin.
3. **NEVER** reference `Sirenix.OdinInspector.Editor` or `Sirenix.Utilities*` from `RootsDance.Runtime`, tests or `_Sandbox/`; Odin editor windows, custom drawers and validators live in `RootsDance.Editor`. Runtime code only ever sees attributes.
4. **NEVER** wrap Odin attributes in `#if ODIN_INSPECTOR` and **NEVER** hand-edit the `ODIN_INSPECTOR*` scripting define symbols — Odin is a hard dependency of this project and manages its own defines.
5. **MUST** pick attributes from the [approved vocabulary](#approved-attribute-vocabulary). Anything else is allowed only with a one-line reason in the PR and after checking it exists in the version-exact [attribute reference](../reference/third-party/odin-inspector/attributes.md).
6. **MUST** lay out every content ScriptableObject with the five standard `[TitleGroup]` sections, in this order, using exactly these names: `"Basic Info"`, `"Interaction"`, `"Conditions"`, `"Result"`, `"Scene Change"`. Omit a section that the type has no fields for; never invent a sixth without a team decision.
7. **MUST** mark every reference field on a content asset `[Required]` (plus `[AssetsOnly]` when it must be a project asset); **MUST** validate ID strings with `[ValidateInput]` backed by a pure-C# validator in `RootsDance.Data` that has EditMode tests.
8. **SHOULD** use `[ValueDropdown]` / `[AssetSelector]` for picking IDs and assets under `Assets/RootsDance/Data/`, `[InlineEditor]` (one level deep, never nested) to edit a referenced asset in place, and `[ListDrawerSettings(ListElementLabelName = "…")]` or `[TableList]` so list elements show their ID instead of `Element 0`.
9. **MUST** keep Unity's own attribute where one exists — `[Tooltip]`, `[Range]`, `[Min]`, `[TextArea]`, `[FormerlySerializedAs]`, `[SerializeReference]`; Odin groups replace `[Header]` and `[Space]`; `[PropertyRange]` / `[MinValue]` / `[MaxValue]` only when the bound is dynamic (a member name or expression).
10. **MAY** add `[Button]` methods for **idempotent designer helpers** (fill an ID from the asset name, sort a list, refresh a preview). **NEVER** put gameplay logic behind a button, and a helper that needs `UnityEditor` APIs is an Odin editor window or drawer in `RootsDance.Editor`, not a `#if UNITY_EDITOR` block in a runtime class.
11. **MAY** show runtime state with `[ShowInInspector]` only together with `[ReadOnly]` and only in the *runtime debug* block of a MonoBehaviour (see [class layout](#attribute-layout-and-class-position)); `[ShowInInspector]` never turns a member into data — it does not serialize.
12. **MUST** write attributes in the order *Unity serialization → Odin group → Odin behaviour*, on one line while the declaration fits in 120 columns, otherwise one attribute per line with the group first.
13. **NEVER** edit anything under `Assets/Plugins/Sirenix/` (the Odin `Config/Editor/*.asset` files count as single-owner files like `ProjectSettings/`); upgrades are re-imports into the same path, announced first, in their own `chore(odin):` commit that also re-runs the reference generator.
14. **MUST** keep validation and helper *logic* in plain C# (`RootsDance.Data`/`RootsDance.Core`) so it is EditMode-testable; Odin drawing itself is never tested.
15. **MUST** grep the offline Odin reference before using an attribute or editor type you are not sure about (`grep -n "### \`<Name>Attribute\`" docs/reference/third-party/odin-inspector/attributes.md`) — Odin 4.0 is newer than every agent's training data.

## What is installed and where

| Item | Value |
|---|---|
| Product / version | Odin Inspector and Serializer **4.0.2.3** (`Assets/Plugins/Sirenix/Odin Inspector/Version.txt`) |
| Location | `Assets/Plugins/Sirenix/` — Odin's own install path; it stays there (exception to [02](./02-project-structure.md) section 5, recorded in [`docs/third-party.md`](../third-party.md)) |
| Assemblies | `Sirenix.OdinInspector.Attributes` (runtime, the attributes), `Sirenix.Utilities`, `Sirenix.Serialization`, `Sirenix.Serialization.Config` (runtime, shipped in builds, `link.xml` keeps them), `Sirenix.OdinInspector.Editor`, `Sirenix.Utilities.Editor`, `Sirenix.Reflection.Editor` (Editor only) |
| Referencing | The DLLs are *auto-referenced* precompiled assemblies: all four `RootsDance.*` asmdefs see `Sirenix.OdinInspector` without an asmdef edit |
| Define symbols | `ODIN_INSPECTOR;ODIN_INSPECTOR_3;ODIN_INSPECTOR_3_1;ODIN_INSPECTOR_3_2;ODIN_INSPECTOR_3_3`, written by Odin into `ProjectSettings/ProjectSettings.asset` for the **active build target group** (Standalone today). Odin adds them for Web the first time someone switches platform — expected churn, commit it with the platform switch, never hand-edit |
| Odin config assets | `Assets/Plugins/Sirenix/Odin Inspector/Config/Editor/{InspectorConfig,GeneralDrawerConfig,OdinModuleConfig,OdinVisualDesignerConfig}.asset` — committed, single-owner |
| Modules | `Modules/Unity.Mathematics` is active (HDRP depends on `com.unity.mathematics`); Addressables/Entities/Localization modules are dormant `.data` files |
| Not installed | **Odin Validator** (separate product) — attributes that depend on it (`[Optional]`, "reference required by default") do nothing; **Odin Serializer usage** (forbidden, rule 2); the Odin `Demos/` folder is empty on purpose |
| Licence | Per-seat (Sirenix EULA). Every teammate holds their own Odin licence; committing the vendor folder is fine on that basis **[project decision, confirmed 2026-08-24]** |

- *Source:* the vendor files listed above; the generated [reference README](../reference/third-party/odin-inspector/README.md).

## Why "Inspector only, never the serializer"

**Unity's serializer stays the source of truth; the Odin serializer is never enabled.**
- *Why:* (1) `.asset`, `.prefab` and `.unity` files stay plain, line-oriented YAML that Git can diff and UnityYAMLMerge can merge — Odin-serialized members are stored as a binary/base64 blob plus a reference list, which turns every designer edit into an opaque conflict (non-negotiable 16 in `AGENTS.md`). (2) The Web build target has no JIT; Odin ships a `NoEmit` build of its serializer for that case, but it needs AOT support generation — a step nobody has time to babysit in a jam. (3) Odin remains removable: strip the attributes and every asset still loads. (4) [04](./04-unity-scripting-rules.md) already tells you how to model dictionaries and polymorphism (`[Serializable]` pair lists, `[SerializeReference]`), so the serializer solves a problem we do not have.
- *Source:* [Serialization rules (6.3 Manual)](../reference/scripting/manual-script-serialization-rules.md); [Odin serializer types](../reference/third-party/odin-inspector/serialization.md) (documented so they are recognised, not used); Git/YAML reasoning in [06](./06-version-control.md). **[project decision]**

## Approved attribute vocabulary

Everything below is in `Sirenix.OdinInspector` and exists in 4.0.2.3 (verified against the shipped XML docs; exact constructor signatures are in the [attribute reference](../reference/third-party/odin-inspector/attributes.md)). Prefer the leftmost column's Unity attribute when both columns solve the same problem.

| Purpose | Use | Notes |
|---|---|---|
| Section headers on content assets | `[TitleGroup("Basic Info")]` … (the five standard names) | Replaces `[Header]`. Every field carries its group attribute; a `TitleGroup` is always visible. |
| Collapsible, rarely-edited block | `[FoldoutGroup("Debug", expanded: false)]` | For advanced/optional blocks only; the five standard sections are never foldouts. |
| Bordered sub-box inside a section | `[BoxGroup("Basic Info/Identity")]` | Slash path nests a box inside the `TitleGroup`. |
| Tabs (only when a type has ≥ 3 variants of the same shape) | `[TabGroup("Modes", "Observe")]` | Rare; ask before introducing tabs on a content type. |
| Side-by-side small fields | `[HorizontalGroup("Basic Info/Row")]` | Only for pairs like min/max; never for whole sections. |
| Label text / read-only display | `[LabelText("Investigation ID")]`, `[ReadOnly]`, `[HideLabel]` | `[ReadOnly]` is Inspector-only — code can still write the field. |
| Required reference | `[Required]`, `[Required("Message")]`, `[AssetsOnly]`, `[SceneObjectsOnly]` | Rule 7: every reference on a content asset. |
| Custom validation | `[ValidateInput("IsValidId", "Use the form FL-001")]` | Validator method takes the value and returns `bool`; logic lives in a static class in `RootsDance.Data`. |
| Explanatory / conditional message | `[InfoBox("…")]`, `[InfoBox("…", InfoMessageType.Warning, "m_isLocked")]` | Third argument is a bool member that shows/hides the box. |
| Choose from a list | `[ValueDropdown("GetPuzzleIds")]`, `[AssetSelector(Paths = "Assets/RootsDance/Data/Puzzles")]` | Getter returns `IList`; `ValueDropdownList<T>` for label/value pairs. |
| Conditional show / enable | `[ShowIf("m_canSample")]`, `[HideIf(...)]`, `[EnableIf(...)]`, `[DisableIf(...)]`, `[ShowIf("m_type", ObjectType.Plant)]` | Condition is a member name or Odin expression (`"@m_count > 0"`). |
| Lists of content | `[ListDrawerSettings(ListElementLabelName = "Id", ShowIndexLabels = false)]`, `[TableList(AlwaysExpanded = true)]` | `ListElementLabelName` names a field/property on the element type. |
| Edit referenced asset in place | `[InlineEditor]`, `[InlineEditor(InlineEditorObjectFieldModes.Boxed)]` | One level deep only (rule 8). |
| Numeric bounds with a dynamic limit | `[MinValue(0)]`, `[MaxValue("m_maxSamples")]`, `[PropertyRange(0, "m_max")]`, `[MinMaxSlider(0f, 10f, true)]` | Static bounds use Unity's `[Range]`/`[Min]`. |
| Enum as buttons | `[EnumToggleButtons]` | Small enums (≤ 5 members) on content assets. |
| Designer helper | `[Button]`, `[Button("Fill Id From Name")]`, `[ButtonGroup("Basic Info/Tools")]`, `[InlineButton("ClearResult", "Clear")]` | Rule 10: idempotent, no gameplay, no `UnityEditor` calls in runtime classes. |
| Runtime debug display | `[ShowInInspector, ReadOnly]` on a property/field | Rule 11; not serialized. |
| Preview / image | `[PreviewField(64)]`, `[PreviewField(64, ObjectFieldAlignment.Left)]` | Sprites/textures/prefabs on content assets. |
| Search a long asset | `[Searchable]` on the class | Content assets with many fields. |
| Text | `[MultiLineProperty(4)]` only where Unity's `[TextArea]` cannot be used (properties) | Fields keep `[TextArea]`. |
| Editor-time reaction | `[OnValueChanged("RefreshPreview")]`, `[OnInspectorInit("…")]` | Editor only; never rely on it for data integrity — that is `OnValidate`'s job ([04](./04-unity-scripting-rules.md)). |
| Play-mode guards | `[DisableInPlayMode]`, `[HideInPlayMode]`, `[HideInEditorMode]` | Rare; content assets are editable at all times by default. |
| Fall back to Unity drawing | `[DrawWithUnity]` | Escape hatch when an Odin drawer misbehaves on a type; note it in the PR. |
| Type-level notes | `[TypeInfoBox("…")]` on the class | One sentence saying what the asset is for. |

**Not approved without a team decision:** `[TableMatrix]`, `[ColorPalette]`, `[CustomValueDrawer]`, `[ShowDrawerChain]`, `[ShowPropertyResolver]`, `[DrawWithVisualElements]`, `[Wrap]`, `[Toggle]`/`[ToggleGroup]`, `[ProgressBar]`, `[FilePath]`/`[FolderPath]`, `[Image]`, `[HideMonoScript]`, `[HideNetworkBehaviourFields]`, `[DisallowModificationsIn]`, `[Optional]` (needs Odin Validator), `[PropertyOrder]` (fix the member order in code instead; the group `order` parameter is fine), and everything in `Sirenix.OdinInspector.Editor` from runtime code.

- *Why:* One shared vocabulary means every content asset looks the same to the designer and every reviewer knows what to expect; a small set keeps agents from reaching for obscure attributes with behaviour nobody on the team has checked. **[project decision]**
- *Source:* [attribute reference](../reference/third-party/odin-inspector/attributes.md) (all 113 public attributes with the vendor's summaries, constructors and examples), [support types](../reference/third-party/odin-inspector/support-types.md) (`InfoMessageType`, `TitleAlignments`, `ButtonSizes`, `ValueDropdownList<T>` …).

## The standard content asset

The canonical shape of a content ScriptableObject — this is the `InvestigationObject` layout from the team's plug-in review, written as project code. Copy it for `PlantSO`, `PuzzleSO`, `JournalEntrySO`, `ReportEntrySO` and keep the five section names.

```csharp
// Assets/RootsDance/Scripts/Runtime/Data/InvestigationObjectSO.cs
using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace RootsDance.Data
{
    /// <summary>One hand-authored investigation node: what the player can do with it and what it unlocks.</summary>
    [CreateAssetMenu(fileName = "InvestigationObject", menuName = "RootsDance/Content/Investigation Object")]
    [TypeInfoBox("One investigation node. IDs follow the pattern PREFIX-000 (e.g. FL-001). Sections: Basic Info → Interaction → Conditions → Result → Scene Change.")]
    public class InvestigationObjectSO : ScriptableObject
    {
        // ---- Basic Info -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Basic Info"), Required, ValidateInput("IsValidId", "Use the form FL-001.")]
        private string m_id;

        [SerializeField, TitleGroup("Basic Info"), Required]
        private string m_displayName;

        [SerializeField, TitleGroup("Basic Info"), EnumToggleButtons]
        private InvestigationObjectType m_type;

        [SerializeField, TitleGroup("Basic Info"), TextArea(2, 4)]
        private string m_description;

        // ---- Interaction ------------------------------------------------------------------------
        [SerializeField, TitleGroup("Interaction")]
        private bool m_canObserve = true;

        [SerializeField, TitleGroup("Interaction")]
        private bool m_canSample;

        [SerializeField, TitleGroup("Interaction"), ShowIf("m_canSample"), Range(0.5f, 10f)]
        [Tooltip("Seconds the sampling animation runs before the result is shown.")]
        private float m_sampleDuration = 2f;

        // ---- Conditions -------------------------------------------------------------------------
        [SerializeField, TitleGroup("Conditions"), AssetSelector(Paths = "Assets/RootsDance/Data/Investigation")]
        [ListDrawerSettings(ListElementLabelName = "Id", ShowIndexLabels = false)]
        private List<InvestigationObjectSO> m_requiredInvestigations = new List<InvestigationObjectSO>();

        [SerializeField, TitleGroup("Conditions"), AssetSelector(Paths = "Assets/RootsDance/Data/Puzzles")]
        private PuzzleSO m_requiredPuzzle;

        // ---- Result -----------------------------------------------------------------------------
        [SerializeField, TitleGroup("Result"), Required, AssetsOnly, InlineEditor]
        private ReportEntrySO m_reportEntry;

        [SerializeField, TitleGroup("Result"), AssetsOnly, InlineEditor]
        private JournalEntrySO m_journalEntry;

        // ---- Scene Change -----------------------------------------------------------------------
        [SerializeField, TitleGroup("Scene Change"), AssetSelector(Paths = "Assets/RootsDance/Data/SceneFlags")]
        [ListDrawerSettings(ListElementLabelName = "Id")]
        private List<SceneFlagSO> m_flagsToSet = new List<SceneFlagSO>();

        public string Id => m_id;
        public string DisplayName => m_displayName;
        public InvestigationObjectType Type => m_type;
        public string Description => m_description;
        public bool CanObserve => m_canObserve;
        public bool CanSample => m_canSample;
        public float SampleDuration => m_sampleDuration;
        public IReadOnlyList<InvestigationObjectSO> RequiredInvestigations => m_requiredInvestigations;
        public PuzzleSO RequiredPuzzle => m_requiredPuzzle;
        public ReportEntrySO ReportEntry => m_reportEntry;
        public JournalEntrySO JournalEntry => m_journalEntry;
        public IReadOnlyList<SceneFlagSO> FlagsToSet => m_flagsToSet;

        [Button("Fill Id From Asset Name"), ButtonGroup("Basic Info/Tools")]
        private void FillIdFromAssetName()
        {
            // Idempotent: derives the ID from the asset file name, never touches gameplay state.
            m_id = ContentId.FromAssetName(name);
        }

        // Odin calls this in the Editor with the field's current value; the rule itself is testable C#.
        private static bool IsValidId(string value)
        {
            return ContentId.IsValid(value);
        }
    }
}
```

```csharp
// Assets/RootsDance/Scripts/Runtime/Data/ContentId.cs — pure C#, covered by EditMode tests.
using System.Text.RegularExpressions;

namespace RootsDance.Data
{
    /// <summary>Content IDs are PREFIX-NNN: 2–8 upper-case letters, a dash, 2–4 digits (FL-001, PUZZLE-A01 is *not* valid).</summary>
    public static class ContentId
    {
        private static readonly Regex k_Pattern = new Regex("^[A-Z]{2,8}-[0-9]{2,4}$", RegexOptions.Compiled);

        public static bool IsValid(string id)
        {
            return !string.IsNullOrEmpty(id) && k_Pattern.IsMatch(id);
        }

        public static string FromAssetName(string assetName)
        {
            return string.IsNullOrEmpty(assetName) ? string.Empty : assetName.Trim().ToUpperInvariant();
        }
    }
}
```

Points to notice:

- Every field is still `[SerializeField] private` with a read-only property — [01](./01-csharp-style.md) rule 7 and [03](./03-architecture-patterns.md) are untouched; Odin only decorates.
- `[Tooltip]`, `[Range]` and `[TextArea]` are Unity's. Odin honours them.
- The section comment lines (`// ---- Basic Info ----`) are optional; the `TitleGroup` names are what matter.
- `[ValidateInput]` and `[Button]` point at *private* members by name — Odin resolves them by reflection, which is fine in Editor code. The logic they call is in a plain static class so an EditMode test (`ContentId_IsValid_RejectsLowerCasePrefix`) covers it without Odin.
- The ID pattern in `ContentId` is a placeholder decision: change the regex when the team fixes the naming scheme, in one place, with its test. **[project decision]**
- *Source:* team plug-in review (2026-08-24, `InvestigationObject` field list); [ScriptableObject data containers](./03-architecture-patterns.md#data-containers-read-only-config); [`ValidateInputAttribute`](../reference/third-party/odin-inspector/attributes.md#validateinputattribute), [`AssetSelectorAttribute`](../reference/third-party/odin-inspector/attributes.md#assetselectorattribute), [`ListDrawerSettingsAttribute`](../reference/third-party/odin-inspector/attributes.md#listdrawersettingsattribute), [`ButtonAttribute`](../reference/third-party/odin-inspector/attributes.md#buttonattribute).

## Attribute layout and class position

**Order attributes *Unity serialization → Odin group → Odin behaviour*, one line while the declaration fits in 120 columns; otherwise one attribute line per concern with the group first, `[Tooltip]` last.**

```csharp
// ✅ fits on one line
[SerializeField, TitleGroup("Interaction"), ShowIf("m_canSample"), Range(0.5f, 10f)] private float m_sampleDuration = 2f;

// ✅ too long: stacked, group first, Tooltip last, declaration on its own line
[SerializeField, TitleGroup("Conditions"), AssetSelector(Paths = "Assets/RootsDance/Data/Investigation")]
[ListDrawerSettings(ListElementLabelName = "Id", ShowIndexLabels = false)]
[Tooltip("Every listed object must be investigated before this one becomes interactable.")]
private List<InvestigationObjectSO> m_requiredInvestigations = new List<InvestigationObjectSO>();

// ❌ group hidden in the middle, Unity attribute after Odin ones
[Required, SerializeField, LabelText("ID"), TitleGroup("Basic Info")] private string m_id;
```

- *Why:* A reader scanning a class sees "is it serialized? → which section? → how is it drawn?" in that order, and the group name lines up vertically across fields. **[project decision]**, consistent with the member order in [01](./01-csharp-style.md#class-layout).

**Member position.** Odin does not change [01](./01-csharp-style.md)'s class layout: serialized fields stay together at the top in *section order*; `[ShowInInspector, ReadOnly]` debug members go in the *other fields / properties* block; `[Button]` methods are private methods at the bottom, right above the private validators they share a purpose with. Do not use `[PropertyOrder]` to reorder — move the member.

**MonoBehaviours.** Odin is mostly for content assets, but the same rules apply to prefab components: `[Required]` on serialized references that must be wired (Odin shows the error in the Inspector *before* the `NullReferenceException` in Play mode), `[TitleGroup]`/`[FoldoutGroup]` when a component passes ~8 fields, `[ShowInInspector, ReadOnly]` for runtime debug values. Never `[Button]` on gameplay methods (`Die()`, `OpenDoor()`); expose a debug console command instead when that tooling exists.

## Validation

**`[Required]` on every reference field of a content asset; `[ValidateInput]` for string IDs and any cross-field rule; `OnValidate` stays the clamp of last resort.**
- *Why:* A missing reference discovered when the designer saves the asset costs seconds; the same one discovered in Play mode by the person integrating the level costs the team half an hour. Unity's `OnValidate` still runs (and still follows [04](./04-unity-scripting-rules.md) — clamp only, no allocations, no scene changes); Odin's attributes give the *message in the Inspector*.
- *Source:* [`RequiredAttribute`](../reference/third-party/odin-inspector/attributes.md#requiredattribute), [`ValidateInputAttribute`](../reference/third-party/odin-inspector/attributes.md#validateinputattribute) ("ValidateInput refuses invalid values"), [`InfoBoxAttribute`](../reference/third-party/odin-inspector/attributes.md#infoboxattribute); [OnValidate rules in 04](./04-unity-scripting-rules.md#script-serialization).

**Validator methods are `private static bool Name(T value)` (or `Name(T value, ref string errorMessage)` when the message depends on the value) and delegate to a pure static class.** Never put the rule inline in the SO — it cannot be EditMode-tested there without Odin, and two content types would duplicate it.
- *Source:* [`ValidateInputAttribute`](../reference/third-party/odin-inspector/attributes.md#validateinputattribute) (parameter named `value`; condition is a resolved string); [08 Testing](./08-testing-tooling.md).

**Odin Validator is not installed.** Do not rely on project-wide validation rules, the Validator window or `[Optional]`. If the team later buys it, this section is where its rules go.

## Editor tooling (RootsDance.Editor only)

**MAY** build one **Content Browser** as an `OdinMenuEditorWindow` in `Assets/RootsDance/Scripts/Editor/Content/` that lists every content asset under `Assets/RootsDance/Data/` by type and lets the designer edit it in place. This is the Odin feature that scales with "dozens of areas, hundreds of investigation nodes"; do it when the second content type exists, not before.
- *Why:* One window with a tree of `FL-001`, `PUZZLE-A01`, `JOURNAL-005` replaces Project-window hunting; it is ~40 lines with Odin's menu tree. **[project decision]**
- *Source:* [`OdinMenuEditorWindow`, `OdinMenuTree`, `OdinMenuItem`](../reference/third-party/odin-inspector/editor-api.md).

```csharp
// Assets/RootsDance/Scripts/Editor/Content/ContentBrowserWindow.cs — RootsDance.Editor
using Sirenix.OdinInspector.Editor;
using UnityEditor;

namespace RootsDance.Editor.Content
{
    public class ContentBrowserWindow : OdinMenuEditorWindow
    {
        private const string k_DataRoot = "Assets/RootsDance/Data";

        [MenuItem("RootsDance/Content Browser")]
        private static void Open()
        {
            GetWindow<ContentBrowserWindow>("Content").Show();
        }

        protected override OdinMenuTree BuildMenuTree()
        {
            var tree = new OdinMenuTree(supportsMultiSelect: false);
            tree.Config.DrawSearchToolbar = true;
            tree.AddAllAssetsAtPath("Investigation", k_DataRoot + "/Investigation", typeof(RootsDance.Data.InvestigationObjectSO), true);
            tree.AddAllAssetsAtPath("Puzzles", k_DataRoot + "/Puzzles", typeof(RootsDance.Data.PuzzleSO), true);
            return tree;
        }
    }
}
```

**Custom drawers (`OdinValueDrawer<T>`, `OdinAttributeDrawer<T>`) and attribute processors need a team decision.** The attribute vocabulary plus one browser window is the expected total Odin footprint for the jam.

**Runtime UI is unaffected.** Odin draws the *Inspector* (IMGUI with optional embedded VisualElements) and touches Editor UI only; runtime UI is uGUI per [09](./09-packages-systems.md#ugui-runtime-ui). Do not use `[DrawWithVisualElements]`.

## Runtime and build impact

- Attributes are metadata; Odin does no work in a Player. `Sirenix.OdinInspector.Attributes`, `Sirenix.Utilities`, `Sirenix.Serialization` and `Sirenix.Serialization.Config` are linked into builds (Odin's `link.xml` preserves them) — about 1 MB, accepted. Never delete the `Assemblies/NoEditor` / `NoEmitAndNoEditor` folders: they are the per-platform builds Odin selects through import settings.
- [05 Performance](./05-performance.md) is untouched: an Odin attribute never allocates at runtime. A `[ShowInInspector]` *property* with a getter that allocates is still a bug — Odin evaluates it every Inspector repaint in the Editor.
- Web target: Odin's `NoEmit` serializer build is what ends up in a Web player; since the serializer is unused (rule 2) no AOT scan is needed.
- *Source:* `Assets/Plugins/Sirenix/Assemblies/link.xml`; the `.dll.meta` platform settings in the same folder.

## Maintaining the plug-in

- **NEVER** edit, move or delete files under `Assets/Plugins/Sirenix/`. The folder is Odin's required path (`OdinPathLookup.asset` and the config assets are located relative to it); the exception to "vendor packages go to `Assets/ThirdParty/`" is recorded in [`docs/third-party.md`](../third-party.md).
- The four config assets under `Odin Inspector/Config/Editor/` change when someone touches **Tools > Odin Inspector > Preferences**. Treat them like `ProjectSettings/` ([11](./11-scenes-prefabs-workflow.md) single-owner files): do not commit a preference change unless it is deliberate, announced and in its own `chore(odin):` commit.
- **Upgrading:** announce in the team channel; import the new `.unitypackage` over the existing folder (Package Manager › *My Assets* or *Assets > Import Package*) with the Editor closed to other work; check the Console is clean; run `python3 docs/reference/_tools/build_odin_reference.py`; update the version line at the top of this guideline and in [09](./09-packages-systems.md); commit everything as one `chore(odin): upgrade Odin Inspector to x.y.z` commit including the `ProjectSettings` define change if any.
- Git: the DLLs and `ConfigData.bytes` go through LFS automatically (`*.dll`, `*.bytes` in `.gitattributes`); `.pdb` and `.xml` are ordinary files; commit every `.meta` ([06](./06-version-control.md)).
- *Source:* [02 section 5](./02-project-structure.md#5-thirdparty-and-plugins), [06 what to commit](./06-version-control.md#what-to-commit-what-to-ignore), [09 package policy](./09-packages-systems.md).

## Anti-patterns

- ❌ `public class PlantSO : SerializedScriptableObject { [OdinSerialize] private Dictionary<string, int> m_stats; }` → ✅ `ScriptableObject` with a `[Serializable] struct StatEntry { string Key; int Value; }` list (Unity-serializable, diffable).
- ❌ `[ShowInInspector] private List<Clue> m_clues;` used as the data field → ✅ `[SerializeField] private List<ClueSO> m_clues;` (`ShowInInspector` does not serialize).
- ❌ `[Header("Basic Info")]` mixed with `[TitleGroup("Interaction")]` on the same class → ✅ Odin groups everywhere on that class; the five standard names.
- ❌ `[TitleGroup("Identity")]` / `[TitleGroup("General")]` / `[TitleGroup("基本信息")]` → ✅ `[TitleGroup("Basic Info")]` — one spelling, one language, across every content type.
- ❌ `[Button] private void OpenDoor()` on `DoorController` → ✅ no button; a debug command or an EditMode/PlayMode test.
- ❌ `#if ODIN_INSPECTOR using Sirenix.OdinInspector; #endif` → ✅ plain `using Sirenix.OdinInspector;` — Odin is not optional here.
- ❌ `using Sirenix.OdinInspector.Editor;` in `RootsDance.Runtime` (breaks the Player build) → ✅ move the window/drawer to `RootsDance.Editor`.
- ❌ `[ValidateInput("@m_id.StartsWith(\"FL-\")")]` expression inlined in the attribute → ✅ named validator method calling `ContentId.IsValid`.
- ❌ `[PropertyOrder(-1)]` to move a field up → ✅ move the field in the source.
- ❌ `[InlineEditor]` on a field whose asset itself has `[InlineEditor]` fields → ✅ one level; open the inner asset from the object field.
- ❌ Editing `Assets/Plugins/Sirenix/Odin Inspector/Config/Editor/InspectorConfig.asset` to "fix" a drawer for yourself → ✅ `[DrawWithUnity]` on the affected field, plus a note in the PR.
- ❌ Adding `ODIN_INSPECTOR_3_3` to the WebGL define list by hand → ✅ switch platform in the Editor and let Odin write it.

## Review checklist

- [ ] No `Serialized*` base class, `[OdinSerialize]`, `using Sirenix.Serialization`, or `[ShowOdinSerializedPropertiesInInspector]` anywhere under `Assets/RootsDance/`.
- [ ] No `Sirenix.OdinInspector.Editor` / `Sirenix.Utilities` usage outside `Scripts/Editor/`.
- [ ] No `#if ODIN_INSPECTOR`; no hand edits to the define symbols; no changes under `Assets/Plugins/Sirenix/` in a non-`chore(odin)` commit.
- [ ] Every content SO uses the five standard `TitleGroup` names in order, every reference is `[Required]`, every ID string has `[ValidateInput]` backed by `ContentId` (or the equivalent tested static class).
- [ ] Attributes ordered *Unity → group → Odin*, one line ≤ 120 columns or stacked with the group first.
- [ ] Only approved attributes, or an unapproved one with a stated reason and a link to its entry in the attribute reference.
- [ ] `[Button]` methods are idempotent helpers with no gameplay side effects and no `UnityEditor` calls; `[ShowInInspector]` is paired with `[ReadOnly]` and never carries data.
- [ ] Any new `[ValidateInput]`/`[Button]` logic is in a plain static class with an EditMode test.
- [ ] Unity's own `[Tooltip]`/`[Range]`/`[Min]`/`[TextArea]`/`[FormerlySerializedAs]` are still used where applicable.
- [ ] An Odin upgrade commit also regenerated `docs/reference/third-party/odin-inspector/` and updated the version line in this guideline and in [09](./09-packages-systems.md).

## Sources

1. [Odin reference README](../reference/third-party/odin-inspector/README.md) — installed version, layout, defines, generation procedure (project-generated from the vendor XML docs).
2. [attributes.md](../reference/third-party/odin-inspector/attributes.md) — all 113 public attributes in `Sirenix.OdinInspector` 4.0.2.3 with the vendor's summaries, constructors, properties and examples.
3. [support-types.md](../reference/third-party/odin-inspector/support-types.md) — enums and helper types used by attribute parameters.
4. [editor-api.md](../reference/third-party/odin-inspector/editor-api.md) — `OdinEditorWindow`, `OdinMenuEditorWindow`, `OdinMenuTree`, drawer base classes (selected types).
5. [serialization.md](../reference/third-party/odin-inspector/serialization.md) — the Odin serializer types, documented so that they are recognised and avoided.
6. [manual-script-serialization-rules.md](../reference/scripting/manual-script-serialization-rules.md) — Unity 6.3 Manual: Serialization rules — https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html
7. [manual-class-scriptableobject.md](../reference/scripting/manual-class-scriptableobject.md) — Unity 6.3 Manual: ScriptableObject — https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html
8. [manual-plug-ins.md](../reference/project-structure/manual-plug-ins.md) — Unity 6.3 Manual: Integrating third-party code libraries (plug-ins) — https://docs.unity3d.com/6000.3/Documentation/Manual/plug-ins.html
9. Team plug-in review, 2026-08-24 (Odin strongly recommended for the vertical slice; ScriptableObject + Odin before any table pipeline) — internal document, not in the repo.
10. Odin Inspector product documentation — https://odininspector.com/documentation (online; the offline files above are the version-exact source for this project).
