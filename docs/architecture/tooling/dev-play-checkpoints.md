# Dev Play: start the game from any checkpoint

Editor-only tooling for quick iteration. One click opens the selected checkpoint's level scenes, enters Play, puts the Player at a
station and seeds the world state that the route would have produced by then — no boot screen, no main menu, no
dragging two scenes into the Hierarchy. Nothing here ships: every script lives in `RootsDance.Editor`.

**Menu:** `RootsDance > Dev Play > Window` (dock it next to the Inspector). Added 2026-08-27.

For ordinary exported test builds, use the separate [checkpoint rescue panel](build-checkpoint-rescue.md): it exports
these definitions as runtime-safe records and performs a full reset/reload instead of additive teleport/seeding.

## What a checkpoint is

`DevCheckpointSO` assets under `Assets/RootsDance/Data/DevPlay/` (create more with
`Create > RootsDance > Editor > Dev Checkpoint`, or re-run `RootsDance > Dev Play > Create Default Checkpoints`,
which only adds the missing defaults and never overwrites a tuned one).

| Section | Field | Meaning |
|---|---|---|
| Where | Label | List entry; prefix with the station id (`00-09 …`) so the list sorts along the route. |
| Where | Level | `LevelSO` whose scenes get opened (`Data/Levels/Main.asset`). |
| Where | Anchor Name | A direct child of `_Anchors` in any loaded part of the checkpoint's level. Main uses the orange spheres placed by `TerrainGreyboxBuilder`; Briggs Interior keeps its four anchors in `BriggsInterior_Gameplay`. Preferred: move the anchor, then update the asset fallback position to match. |
| Where | Position | Used when Anchor Name is empty or the anchor is missing from the scene. |
| Where | Yaw | Facing in degrees around Y; 0 looks down +Z (the route direction). |
| Where | Snap To Ground / Ground Clearance | Raycast down from 50 m above the target (triggers ignored) and stand `clearance` above the highest hit — terrain or lab geometry. Default 0.05 m: the Player root is the feet (capsule 1.7 m tall, centre y 0.85), so the root stands just above the ground. |
| World State | Time of day | `Level Default` (emit nothing — the level's `TimeOfDayController` decides), `Day` or `Night`. Applied *before* the flags, as a `SetTimeOfDayCommand`, so the lighting is already right on the first frame you control. |
| World State | Flags | `WorldFlags` ids raised before you take control, applied in order. Dropdown lists every constant in `WorldFlags.cs`. |
| World State | Recorded Targets | `InvestigationTargetSO`s already in the official report (`AddReportEntryCommand`). |

The defaults follow the opening route: `00-01 Wake` (nothing raised) → `00-04 Radio briefing` (left start area) →
`00-05 Helmet unlock` (+ briefing started/finished, helmet removable) → `00-06 Grass belt` (+ helmet removed, entered
grass belt) → `00-07 Grass platform`, `00-09 Main gate`, `00-10 Sign`, `00-11 Poster`
(+ first investigation done, soil + 毯茅 recorded). Yaw is 0 everywhere — tune by eye and save the asset.

Briggs Interior has four authored checkpoints under `Data/DevPlay/BriggsInterior/`. Their current anchors and fallback
positions are documented in [02章 Briggs Interior 实验室室内设计与实现](../../design/02章BriggsInterior实验室室内设计与实现.md#11-玩家出生与-dev-play-checkpoint).

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
3. Play mode: the same button reads **Go here**. A checkpoint in the current level applies immediately without
   restarting. A checkpoint in another level changes to **Loading...** while the existing runtime `SceneLoader`
   keeps `Bootstrap`, unloads every old content scene, loads the target `LevelSO` scenes in order, and makes the
   first scene active. Dev Play applies the checkpoint only after that load completes, so its Player and anchors
   come from the requested chapter rather than the chapter being left.

Flags are monotonic (D8): **Go here** can move you back along the route or into another chapter but never un-raises
a flag. A Play-mode chapter switch deliberately preserves the Bootstrap and its world state. To reset state, stop
Play and use **Play here** again. Teleporting into a `TriggerVolume` raises that volume's flag as usual.

**Time of day is the carve-out.** It is a discrete world-state *value*, not a flag, and it is not monotonic: **Go
here** on a checkpoint whose Time of day is `Day` or `Night` really does switch the world, in both directions, as
often as you like. `Level Default` is the opt-out and stays value 0, so a checkpoint authored before this field
existed still means "leave the level alone". The 00-01 … 00-11 outdoor checkpoints use `Level Default`, which now
resolves to the Main level's yellow `PollutedDay` state; Briggs Interior checkpoints remain explicitly `Night`.
`RootsDance > Dev Play > Set All Checkpoints To Level Default` rewrites the outdoor committed assets in place and
skips the `BriggsInterior/` subfolder (Create Default Checkpoints never overwrites an existing one). The live section
of the window shows the current phase with **Day** / **Polluted** / **Night** buttons that enqueue the same command
by hand.

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

## 让一次 playtest 便宜下来

两个可用的加速开关按收益排序。下面也记录了为什么当前不能关闭 Domain Reload，避免再次引入同一故障。

### 1. Flow 关卡：不加载那 1072 件装饰

`Main_Environment` 有 **1072 个 prefab 实例**（chainlink_post 93、dry_branches 92、tree0X_winter 约 250…），
而验证一个触发、一段通讯或一条报告条目一件都用不上——这些正是每次进 Play 等待的大头。

`RootsDance > Dev > Build Flow Level` 生成 `Main_DevGround.unity` 与 `Data/Levels/Main_Flow.asset`，
后者只加载 **裸地形 + `Main_Gameplay`**。在 Dev Play 窗口里把 checkpoint 的 Level 改成 `Main_Flow` 即可。

地面用的是**同一份 `Main_TerrainData`、同一个 transform**，不是一块平板：路线从出生点 y≈3 爬到草带 y≈6.7，
`Main_Gameplay` 里每个触发体积都是贴着这个曲面摆的，换成平地后半程的触发就会悬在空中——
那种"省事的捷径"会让测试结果不可信。太阳与 Global Volume 也照抄 Main：曝光决定画面能不能读，
一个长得跟游戏完全不一样的测试关就不再是在测这个游戏。

场景是**生成物**，重跑覆盖，不要在里面摆任何东西。

### 2. Domain Reload 已恢复（不要关）

`Edit > Project Settings > Editor > Enter Play Mode Settings` 当前会同时 **Reload Domain** 和 **Reload Scene**
（`m_EnterPlayModeOptions: 0`，2026-09-02 起）。2026-08-29 曾只保留 Reload Scene；但 Unity 6000.3.22f1
配合 Input System 1.20.0 时，连续进 Play 会让上一轮的 `InputActionState` monitor 留在原生输入管理器里，鼠标
同步事件随后成组报 `Map index out of range`、`Control index out of range`、`Binding index out of range` 和
`NullReferenceException`。恢复 Domain Reload 后连续两轮 Play 均不再复现，所以在 Unity/Input System 升级并
重新验证以前，不要重新关闭它。

`Scripts/Runtime/App/PlaySessionReset.cs`（`RuntimeInitializeLoadType.SubsystemRegistration`）仍保留为静态状态的
防御性复位，并让未来重新评估 Faster Enter Play Mode 时不必从零审计：

- `ScannableTarget` / `GroundPickup` 的自注册表；
- `FlashlightBeamBroadcaster.Beam`（上一次会话的光束）；
- `DOTween.Clear(true)`——它的补间池和驱动物件分处两侧，物件随 Play 结束销毁，池不会。

`WorldAccess` 每次都从 bootstrap 现取；`PersistentSingleton<T>` 也在 `PlaySessionReset` 中显式复位。
**新增任何可变 static，仍要在这里加一行**，这样无论是否启用 Faster Enter Play Mode 都保持确定性。

### 3. `RootsDance > Dev > Cheap Rendering`

一个带勾选的菜单开关。打开后，进入 Play 时压一个 priority 10000 的全局 Volume（高于工程里最高的 20），
关掉体积雾、SSAO、PSX 后处理，并把阴影距离压到 40 m、级联降到 1。退出 Play 自动消失，磁盘上没有任何改动。

**不做成第二份 HDRP 资产**，是个决定：切换管线资产会重建管线并重编着色器变体，把省下的时间又花回去，
而且两份资产会在所有没人记得同步的字段上慢慢分叉。

它**不会禁用任何场景物件**：哪些 prop 是装饰、哪些是谜题的一部分是内容问题，判断错了流程就没法测——
要去掉装饰用上面的 Flow 关卡。

### 已经关掉的、以及不必调的

`HDRP_Desktop` 里 SSR、SSGI、SSS、Decals、RayTracing、MSAA、Water **都已经是关的**，不用再找。

地形的 `treeDistance: 5000` 和 `detailObjectDistance: 80` 看着吓人但**没有成本**：
地形里 0 棵树、0 个 detail prototype，植被全是那 1072 个 prefab 实例。别在这两个值上浪费时间。

真正没吃到的红利在别处：那 1072 件装饰**没有一件标了 Batching Static**，
`gpuResidentDrawerSettings.mode: 0`（GPU Resident Drawer 关闭），`m_OcclusionCullingData` 为空（没烘遮挡剔除）。
也就是每件都是独立 draw call 加独立阴影投射。这三项都是"打开"而不是"关掉"，需要各自验证一轮，尚未做。

## Files

- `Scripts/Editor/DevPlay/DevCheckpointSO.cs` — the asset (Odin `TitleGroup`s `Where` / `World State`).
- `Scripts/Editor/DevPlay/CheckpointTimeOfDay.cs` — `LevelDefault` / `Day` / `Night`; the authoring enum, mapped onto
  `RootsDance.Core.TimeOfDay` by `DevCheckpointSeed.TryToRuntime`.
- `Scripts/Editor/DevPlay/DevCheckpointSeed.cs` — pure logic: commands to enqueue, position resolution.
- `Scripts/Editor/DevPlay/WorldFlagCatalog.cs` — every `WorldFlags` constant by reflection.
- `Scripts/Editor/DevPlay/DevPlaySession.cs` — open scenes, enter Play, apply.
- `Scripts/Editor/DevPlay/DevPlayWindow.cs` — the window.
- `Scripts/Editor/DevPlay/DevCheckpointDefaults.cs` — the default set, plus `RootsDance > Dev Play > Set All
  Checkpoints To Level Default` (`SetAllTimeOfDayToLevelDefault`, no dialogs — batch-callable via `-executeMethod`;
  Briggs Interior is intentionally excluded).
- `Scripts/Editor/DevPlay/DevFlowLevelBuilder.cs` — 生成 `Main_DevGround.unity` 与 `Main_Flow.asset`。
- `Scripts/Editor/DevPlay/DevCheapRendering.cs` — `Cheap Rendering` 开关与它压的那个 Volume。
- `Scripts/Runtime/App/PlaySessionReset.cs` — 关闭 domain reload 后每次会话的静态复位。
- `Tests/EditMode/DevPlay/` — seed and catalog tests.
