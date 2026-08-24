# Third-party plugin records

> **Scope:** Exceptions and unavoidable deviations for content under `Assets/ThirdParty/` and `Assets/Plugins/`, as required by [docs/guidelines/02-project-structure.md](guidelines/02-project-structure.md) §5. One entry per package; when adding one, record the exact version, path, *why* it's an exception, and every file you had to touch (so the edit can be re-applied after a vendor update).

## Odin Inspector and Serializer (Sirenix) — `Assets/Plugins/Sirenix/`

- **Version:** 4.0.2.3. Imported 2026-08-24 as a team decision (each teammate holds a seat licence).
- **Vendor-required path.** Odin installs to and locates itself from `Assets/Plugins/Sirenix/` (`Odin Inspector/Assets/Editor/OdinPathLookup.asset`, the `Config/Editor/*.asset` files and the per-platform `Assemblies/` sub-folders are resolved relative to it), so it stays there instead of `Assets/ThirdParty/`.
- **No local edits.**
- Odin writes `ODIN_INSPECTOR*` scripting defines into `ProjectSettings/ProjectSettings.asset` per active build target group. The Odin serializer is deliberately unused — see [12 Odin Inspector](guidelines/12-odin-inspector.md), the owner guideline.

## DOTween (Demigiant) — `Assets/Plugins/Demigiant/DOTween/`

- **Placement exception.** Imported via the vendor's `.unitypackage`, which installs to `Assets/Plugins/Demigiant/DOTween/` by convention. Left there rather than moved to `Assets/ThirdParty/Demigiant/` because `DOTween.dll` is a compiled managed binary — the folder it belongs in per [02](guidelines/02-project-structure.md) §2 ("`Assets/Plugins/` — native and managed plug-in binaries only"). Its `Modules/` and `Editor/` companion source files ride along in the same tree rather than being split out, to keep the vendor's internal layout intact for future updates.
- **Assembly definitions added** (the one tolerated edit inside a vendor folder, per [02](guidelines/02-project-structure.md) §5): `DOTween.Modules.asmdef` at the DOTween root (covers `DOTween.dll` + `Modules/`) and `Editor/DOTween.Editor.asmdef` (editor-only, references `DOTween.Modules`, covers `DOTweenEditor.dll`). Neither shipped with the Asset Store package. `RootsDance.Runtime.asmdef` references `DOTween.Modules`.
- **No `Resources/` folder.** DOTween's Utility Panel (*Tools > Demigiant > DOTween Utility Panel > Setup DOTween...*) normally writes `Assets/Resources/DOTweenSettings.asset`, which conflicts with the project's non-negotiable "never create a `Resources/` folder" rule ([AGENTS.md](../AGENTS.md) #19, [02](guidelines/02-project-structure.md) §4). That asset only carries *default* tween settings (ease, safe mode, log behaviour, recycle) that DOTween otherwise falls back to hardcoded defaults for if the asset is absent — it is not required for `DG.Tweening` extension methods to compile or run. All module files under `Modules/` are compiled unconditionally by default (each is guarded by an opt-out define, e.g. `#if !DOTWEEN_NOPHYSICS`, that nothing in this project sets), so they work without ever running Setup.
  - Instead, the same defaults are set from code once, in [`GameBootstrap.Awake()`](../Assets/RootsDance/Scripts/Runtime/App/GameBootstrap.cs): `DOTween.Init(recycleAllByDefault: false, useSafeMode: true, logBehaviour: LogBehaviour.ErrorsOnly)`.
  - **Do not** run "Setup DOTween..." in a way that leaves `Assets/Resources/DOTweenSettings.asset` behind. If a teammate needs to disable a specific module (e.g. `DOTWEEN_NOPHYSICS2D` because a feature genuinely never needs it), open the Utility Panel, apply the module change, then delete the generated `Resources/DOTweenSettings.asset` + folder afterward — the module toggle itself is a scripting-define change, not a dependency on the settings asset.
  - **Unverified:** this repo currently has no Unity Editor access to confirm in-Editor that DOTween runs cleanly (zero console errors/warnings) with no settings asset present. A teammate should open the project once and confirm before relying on this pattern further.
- **Usage:** `using DG.Tweening;` in any `RootsDance.Runtime` file that needs it.

## IngameDebugConsole (yasirkula) — UPM package

Installed as a normal UPM package (`com.yasirkula.ingamedebugconsole`, via the OpenUPM scoped registry added to `Packages/manifest.json`), not vendored under `Assets/`. No exception needed — this is the preferred path per [09-packages-systems.md](guidelines/09-packages-systems.md); no entry required here.
