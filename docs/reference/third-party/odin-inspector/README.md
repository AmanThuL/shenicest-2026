# Odin Inspector 4.0.2.3 — offline reference (third-party)

Version-exact documentation for the Odin Inspector build committed in this repository, generated from the XML documentation files that Sirenix ships next to the DLLs. It is the source for [guideline 12 — Odin Inspector](../../../guidelines/12-odin-inspector.md). Unlike the rest of `docs/reference/`, nothing here was downloaded: the vendor XML is already in `Assets/Plugins/Sirenix/Assemblies/`.

| File | Generated from | Contents |
|---|---|---|
| [attributes.md](attributes.md) | `Sirenix.OdinInspector.Attributes.xml` | All 113 public attributes in `Sirenix.OdinInspector` — summary, remarks, vendor examples, constructors with parameter docs, fields/properties. **Grep this before using an attribute.** |
| [support-types.md](support-types.md) | `Sirenix.OdinInspector.Attributes.xml` | Enums and helper types used as attribute parameters (`InfoMessageType`, `TitleAlignments`, `ButtonSizes`, `InlineEditorObjectFieldModes`, `ValueDropdownList<T>` …). |
| [editor-api.md](editor-api.md) | `Sirenix.OdinInspector.Editor.xml` | Selected editor types for `SheNicest.Editor` tooling: `OdinEditorWindow`, `OdinMenuEditorWindow`, `OdinMenuTree`, `OdinMenuItem`, drawer base classes, `InspectorProperty`, `PropertyTree`. |
| [serialization.md](serialization.md) | `Sirenix.Serialization.xml` | The Odin serializer types (`SerializedMonoBehaviour`, `SerializedScriptableObject`, `[OdinSerialize]` …). **Documented so they are recognised — this project does not use them** (guideline 12, rule 2). |

Quick lookups:

```bash
# one attribute, with constructors and examples
grep -n '^### `RequiredAttribute`' -A 30 docs/reference/third-party/odin-inspector/attributes.md
# does an attribute exist in this version at all?
grep -c '^### `TableMatrixAttribute`' docs/reference/third-party/odin-inspector/attributes.md
```

## Installed build (facts, 2026-08-24)

| Item | Value |
|---|---|
| Version | `4.0.2.3` — `Assets/Plugins/Sirenix/Odin Inspector/Version.txt` |
| Install path | `Assets/Plugins/Sirenix/` (Odin's default; kept there — see [`docs/third-party.md`](../../../third-party.md)) |
| Runtime assemblies (in builds, kept by `Assemblies/link.xml`) | `Sirenix.OdinInspector.Attributes`, `Sirenix.Utilities`, `Sirenix.Serialization`, `Sirenix.Serialization.Config` |
| Editor assemblies | `Sirenix.OdinInspector.Editor`, `Sirenix.Utilities.Editor`, `Sirenix.Reflection.Editor` |
| Per-platform variants | `Assemblies/NoEditor/` and `Assemblies/NoEmitAndNoEditor/` hold the Player builds of `Sirenix.Serialization` / `Sirenix.Utilities`; selection is done by the `.dll.meta` platform settings |
| Auto-referenced | Yes (`isExplicitlyReferenced: 0` in every `.dll.meta`) — no asmdef change is needed to use the attributes |
| Scripting defines (written by Odin per active build target group) | `ODIN_INSPECTOR;ODIN_INSPECTOR_3;ODIN_INSPECTOR_3_1;ODIN_INSPECTOR_3_2;ODIN_INSPECTOR_3_3` |
| Config assets | `Odin Inspector/Config/Editor/InspectorConfig.asset`, `GeneralDrawerConfig.asset`, `OdinModuleConfig.asset`, `OdinVisualDesignerConfig.asset` |
| Active modules | `Odin Inspector/Modules/Unity.Mathematics/` (asmdef `Sirenix.OdinInspector.Modules.UnityMathematics`, activated because URP depends on `com.unity.mathematics`); Addressables, Entities and Localization modules are dormant `.data` archives |
| Not present | Odin Validator (separate product); Odin demos (folder empty) |
| Vendor links (from `Assets/Plugins/Sirenix/Readme.txt`) | Tutorials https://odininspector.com/tutorials · API https://odininspector.com/documentation · Release notes https://odininspector.com/patch-notes |

## Regenerate after an Odin upgrade

```bash
python3 docs/reference/_tools/build_odin_reference.py   # standard library only
```

Then update the version in this README, in guideline 12 and in guideline 09, and commit together with the vendor folder change (`chore(odin): …`).
