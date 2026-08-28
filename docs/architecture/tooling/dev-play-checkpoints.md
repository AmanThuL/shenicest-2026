# Dev Play: start the game from any checkpoint

Editor-only tooling for quick iteration. One click opens the Main level's scenes, enters Play, puts the Player at a
station and seeds the world state that the route would have produced by then — no boot screen, no main menu, no
dragging two scenes into the Hierarchy. Nothing here ships: every script lives in `RootsDance.Editor`.

**Menu:** `RootsDance > Dev Play > Window` (dock it next to the Inspector). Added 2026-08-27.

## What a checkpoint is

`DevCheckpointSO` assets under `Assets/RootsDance/Data/DevPlay/` (create more with
`Create > RootsDance > Editor > Dev Checkpoint`, or re-run `RootsDance > Dev Play > Create Default Checkpoints`,
which only adds the missing defaults and never overwrites a tuned one).

| Section | Field | Meaning |
|---|---|---|
| Where | Label | List entry; prefix with the station id (`00-09 …`) so the list sorts along the route. |
| Where | Level | `LevelSO` whose scenes get opened (`Data/Levels/Main.asset`). |
| Where | Anchor Name | A child of `_Anchors` in `Main_Environment` — the orange spheres `TerrainGreyboxBuilder` places (`Anchor_00-09_MainGate` …). Preferred: move the sphere, the checkpoint follows. |
| Where | Position | Used when Anchor Name is empty or the anchor is missing from the scene. |
| Where | Yaw | Facing in degrees around Y; 0 looks down +Z (the route direction). |
| Where | Snap To Ground / Ground Clearance | Raycast down from 50 m above the target (triggers ignored) and stand `clearance` above the highest hit — terrain or lab geometry. Default 1 m (the capsule is 1.5 m tall, centred on the root). |
| World State | Time of day | `Level Default` (emit nothing — the level's `TimeOfDayController` decides), `Day` or `Night`. Applied *before* the flags, as a `SetTimeOfDayCommand`, so the lighting is already right on the first frame you control. |
| World State | Flags | `WorldFlags` ids raised before you take control, applied in order. Dropdown lists every constant in `WorldFlags.cs`. |
| World State | Recorded Targets | `InvestigationTargetSO`s already in the official report (`AddReportEntryCommand`). |

The defaults follow the opening route: `00-01 Wake` (nothing raised) → `00-04 Radio briefing` (left start area) →
`00-05 Helmet unlock` (+ briefing started/finished, helmet removable) → `00-06 Grass belt` (+ helmet removed, entered
grass belt) → `00-07 Grass platform`, `00-09 Main gate`, `00-10 Sign`, `00-11 Poster`, `00-16 Service entrance`
(+ first investigation done, soil + 毯茅 recorded). Yaw is 0 everywhere — tune by eye and save the asset.

## How it applies (and why it respects the architecture)

`DevPlaySession.PlayFrom(checkpoint)`:

1. Edit mode: `OpenLevelScenes` (first scene Single, rest Additive; skipped when already loaded; asks to save dirty
   scenes first), remembers the checkpoint path in `SessionState` (survives the Play-entry domain reload), calls
   `EditorApplication.EnterPlaymode()`.
2. On `EnteredPlayMode` it polls `EditorApplication.update` until `GameBootstrap.Instance` and the
   `FirstPersonController` exist (20 s timeout, error logged), then:
   - teleports the Player: `CharacterController` disabled → `SetPositionAndRotation` → re-enabled →
     `Physics.SyncTransforms()`; Cinemachine hard-locks to the head so the camera follows;
   - enqueues `SetTimeOfDayCommand` / `RaiseFlagCommand` / `AddReportEntryCommand` on `GameBootstrap.Commands` — the
     same path trigger volumes and the investigation service use (D1/D7 in `运行时架构说明书.md`). Nothing writes
     `WorldState` directly.
3. Play mode: the same button reads **Go here** and applies immediately without restarting.

Flags are monotonic (D8): **Go here** can move you back along the route but never un-raises a flag. To reset state,
stop Play and use **Play here** again. Teleporting into a `TriggerVolume` raises that volume's flag as usual.

**Time of day is the carve-out.** It is a discrete world-state *value*, not a flag, and it is not monotonic: **Go
here** on a checkpoint whose Time of day is `Day` or `Night` really does switch the world, in both directions, as
often as you like. `Level Default` is the opt-out and stays value 0, so a checkpoint authored before this field
existed still means "leave the level alone". Every default checkpoint is `Night`, because the whole pre-lab route
(00-01 … 00-16) plays at night; `RootsDance > Dev Play > Set All Checkpoints To Night` rewrites the committed assets
in place (Create Default Checkpoints never overwrites an existing one). The live section of the window shows the
current phase with **Day** / **Night** buttons that enqueue the same command by hand.

The window also shows the live world state while playing (every `WorldFlags` id with a **Raise** button, report
entry count) — the checkpoint dropdown and this list share `WorldFlagCatalog`, so a new flag constant appears in
both without further wiring.

## From the shell (AI agents)

With the Editor open and the Unity CLI (`unity command …`), the same entry points are callable through `eval`:

```csharp
var cp = UnityEditor.AssetDatabase.LoadAssetAtPath<RootsDance.Editor.DevPlay.DevCheckpointSO>(
    "Assets/RootsDance/Data/DevPlay/00-09_MainGate.asset");
RootsDance.Editor.DevPlay.DevPlaySession.PlayFrom(cp);
```

Opening `Main_Environment` takes longer than the CLI's default 5 s main-thread budget: pass `-- --timeout 60000`
(or open the scenes first with `open_scene`, then call `PlayFrom`, which is instant). While playing, calling
`PlayFrom` again teleports. Read `WorldAccess.State.HasFlag(...)` to verify.

## Files

- `Scripts/Editor/DevPlay/DevCheckpointSO.cs` — the asset (Odin `TitleGroup`s `Where` / `World State`).
- `Scripts/Editor/DevPlay/CheckpointTimeOfDay.cs` — `LevelDefault` / `Day` / `Night`; the authoring enum, mapped onto
  `RootsDance.Core.TimeOfDay` by `DevCheckpointSeed.TryToRuntime`.
- `Scripts/Editor/DevPlay/DevCheckpointSeed.cs` — pure logic: commands to enqueue, position resolution.
- `Scripts/Editor/DevPlay/WorldFlagCatalog.cs` — every `WorldFlags` constant by reflection.
- `Scripts/Editor/DevPlay/DevPlaySession.cs` — open scenes, enter Play, apply.
- `Scripts/Editor/DevPlay/DevPlayWindow.cs` — the window.
- `Scripts/Editor/DevPlay/DevCheckpointDefaults.cs` — the default set, plus `RootsDance > Dev Play > Set All
  Checkpoints To Night` (`SetAllTimeOfDayToNight`, no dialogs — batch-callable via `-executeMethod`).
- `Tests/EditMode/DevPlay/` — seed and catalog tests.
