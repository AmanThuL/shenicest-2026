# Chapter House 室内关卡实施记录

> 素材来源与授权: [第三方记录 — Chapter house (chapel)](../../third-party.md) 与 [Metal bridge](../../third-party.md)
> 模型源: `SourceArt/Corridor/RootsDance_Corridor_Blockout.blend`
> 生成器: `Assets/RootsDance/Scripts/Editor/Environment/ChapterHouseInteriorLevelBuilder.cs`
> 菜单: `RootsDance > Build Chapter House Interior`
> 范围: 把处理过的 chapter house 做成可进入、可行走、可 Dev Play 的室内关卡

**这一关的剧情只有一处：桥上与小花的初次相遇（02-04）。** 它由
`RootsDance > Content > Wire Narrative Runtime` 写进 `_Narrative`，本文件的生成器不碰它——
关卡负责几何、锚点和 checkpoint，叙事挂在锚点上。`_Triggers` 只有一个去温室的
portal（见第 5 节），`_Interactables` 仍是空的。
相遇的三拍（现身 / 回头 / 台词）写在[对话与场景序列 2.3b](../../architecture/systems/对话与场景序列.md)。

---

## 1. 模型用的是哪一个

用的是**处理过的**那份：`SourceArt/Corridor/RootsDance_Corridor_Blockout.blend`。
教堂在那里被拆成 21 块重新摆过——两面带圆窗洞的山墙改成沿走廊对望，布料状地形沉到地板之下，
一条金属桥横在厅里——**这套摆法就是关卡本身**；原封不动的教堂只是它的用料。

工程里还留着未处理的 `Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouse.obj`，
但没有任何关卡引用它。

Unity 侧的模型是 `Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouseCorridor.fbx`，
经 `Tools/blender/export_fbx.py` 导出，manifest 在 `SourceArt/Export/ChapterHouseCorridor.export.json`，
导入设置由 `Tools/unity/model_import_profiles.json` 的 `static_chapterhouse` 条目套用
（scale **1.511**、mesh 可读、**不生成材质**）。生成器只校验这套设置生效，不重复设置。

**那个 1.511 是在纠正 blockout 的缩小。** 逐块量下来，blockout 里每一块都只有原教堂的
**0.662 倍**（五块取样，离散度 0.005）：栏杆只有 0.55 m 高，站在 1.8 m 的玩家旁边像个模型。
乘回去之后建筑恢复到作者建的尺度。要退回 blockout 原尺寸，只改 profile 里这一个数。

---

## 2. 关卡构成

和工程里其他关卡同形：一个环境场景 + 一个玩法场景，由 `Data/Levels/ChapterHouseInterior.asset` 串起来。

```text
ChapterHouseInterior_Environment
├── _Lighting     # Global Volume（MainProfile）+ Sun + 四盏厅内补光
├── _Geometry
│   └── ChapterHouseRoot/ChapterHouse   # 22 块，全部 static，逐块 MeshCollider
├── _Props        # PlayerHeightReference_1p8m（默认关闭的比例参照）
└── _NavMesh      # 空，占位

ChapterHouseInterior_Gameplay
├── _Cameras/FirstPersonCamera   # CinemachineCamera，硬锁玩家头部 + PanicViewShake（只用它的快速回头）
├── _Spawns/PlayerSpawn
├── _Anchors/Checkpoint_CorridorEntrance · Checkpoint_FlowerSpriteEncounter
├── _Narrative                                # FirstMeeting（CueSequence）+ FlowerSprite（FollowCompanion）
├── _Triggers · _Interactables                # 空，等内容
└── Player
```

Dev Play：`RootsDance > Dev Play > Window` 里的 **02-04A Corridor entrance**（南端进入通道，面向 +Z）
与 **02-04B Flower sprite encounter**（桥与小花初次相遇处，回望）。两者都属于剧情节点 02-04，A/B 只区分试玩落点。

尺寸（按 1.511 导入后）：整体约 **13.2 m 宽 × 18.8 m 深 × 13.1 m 高**；玩家真正走的厅内地板约
**6.8 × 13.7 m**；金属桥长约 6.9 m、宽 0.9 m。地板面与桥面的绝对高度由生成器归位时算出，不写死。

---

## 3. 四个决定

### 3.1 缩放在导入侧，场景里只归位

尺度纠正是导入 profile 的事（上面那 1.511），场景里的 Transform 一律是 1。生成器只做两件事：
X/Z 居中、模型最低面落到 Y 0（blend 是绕作者原点建的，不是工程原点）。
厅内地板因此落在整体最低面之上几米——**它下面还压着布料地形**，这不是错位，是这套摆法本来的层次。
出生点比地板面高 1.05 m，玩家胶囊底离地板 0.15 m，落地即停，不是悬空。

### 3.2 材质按块还原

blockout 把 21 个面的材质压成了三个 Blender 材质，但 UV 原封未动，所以烘焙贴图能直接贴回去。
`ChapterHouseInteriorLevelBuilder.k_Parts` 是唯一的还原依据：blockout 导出后每块叫
`ClothLandscape_CorridorShell.NNN`，编号顺序就是原名的字母序，表按这个顺序把每块认回原来的面。

导出件数或名字一变，`ApplyMaterials` 直接抛错、不猜——猜错的后果是墙上贴着地板的烘焙，
读起来像贴图做坏了，而不像表过期了。

材质仍是 21 张 HDRP Lit（`Materials/Environment/ChapterHouse/`），贴 base map（+ 三套窗户法线），
Smoothness 压到 0.08：贴图是作者烘焙好的，上面再加一层高光会读成第二个、错误的光源。
金属桥不带烘焙，是唯一一个靠参数描述的材质（深灰、metallic 0.9、smoothness 0.35）。

**全部双面**：墙、窗、栏杆都是单面片，不开双面整座建筑从室内看会消失，而室内是这一关唯一会被看到的一侧。

### 3.3 碰撞逐块贴着网格做

每块一个非凸 `MeshCollider`。上一版在 Y 0 铺一整块地面盒——那只在「整关就是一层 Y 0 地板」时成立；
现在厅内地板远高于模型最低面（布料地形在它下面），地面盒会把玩家漏到建筑底下去。

非凸 MeshCollider 两面都挡，正好对上这套单面片建筑。
只有**地板、金属桥、布料地形**三块进 `Ground` 层——墙照样挡人，只是不算落脚点。

### 3.4 落点从几何算，不写死

出生点和两个 checkpoint 都从建好的地板与桥的包围盒推出来。blockout 明确还是一份会被继续挪的布局，
写死的坐标下一次挪完就会落进墙里。

---

## 4. 从实验室进来

**2026-08-30 已接。** 实验室圆门打开后看到纯黑遮挡，玩家触碰门后的触发区，通过
`RootsDance.Environment.LevelPortal` 向 `LoadLevelRequested` 请求加载 `ChapterHouseInterior`。
默认 Player 与 PlayerSpawn 和 `02-04A / Checkpoint_CorridorEntrance` 同位置、同朝向，
因此加载后从第一个 checkpoint 开始；这是普通关卡切换，保留剧情状态，不执行救援 checkpoint 重置。

`BriggsInterior_Gameplay/_Triggers/BriggsChapterHousePortal` 使用独立 prefab：根节点在 `(0, 0, 7.5)`，
触发盒前沿为 `Z 7.45`，位于关闭门叶之后；黑色表面使用 alpha 为 1、关闭雾效的 HDRP/Unlit 材质。
可通过 `RootsDance/Environment/Apply Briggs Chapter House Portal` 单独重建，原出口门 builder 也会保留它。
不拼接两个建筑，不将 Chapter House 加入 Briggs 的同时加载列表。

挂的时候有一条不能忘：**portal 必须在 `TriggerVolume` 层**。玩家的 trigger 检测挂在 `PlayerProbe`
层的探针上，而物理矩阵里 `PlayerProbe` 只和 `TriggerVolume` 相撞。留在 Default 层的 trigger，
玩家会直接穿过去、什么都不触发。

---

## 5. 从这里去温室

四扇 chapel 门（`ChapterHouseDoor_A`–`D`）都是 `SwingDoor`：玩家探针进入门根节点上的
触发盒就摆开，离开就摆回。**门根节点必须在 `TriggerVolume` 层**（原因同第 4 节的 portal），
门叶留在 Default 层——它的碰撞体要挡玩家胶囊，不是和探针说话。

只有 **`ChapterHouseDoor_D`** 通向下一章：门后站着
`ChapterHouseInterior_Gameplay/_Triggers/ChapterHouseGreenhousePortal`，同一套黑面 +
`LevelPortal` 的做法，请求加载 `GreenhouseInterior`（即 03-01 温室入口，落在温室自己的
PlayerSpawn）。其余三扇门只开，不通。

portal 的位置从门 D 自己的触发盒包围盒推出来，不写死：触发盒前沿离门平面超过一个探针半径，
走到门前只开门、不换关；根节点退到门叶 100° 摆弧之外，黑面不会被门叶扫到。
可用 `RootsDance/Environment/Apply Chapter House Greenhouse Portal` 单独重建；
`RootsDance > Build Chapter House Interior` 重建整关时也会把它写回来，
与叙事一样不会被清空的 `_Triggers` 静默吃掉。

---

## 6. 尚未做的

- **金属桥的位置还是构图参考**：源文件 README 写明桥是「approximate composition reference」，
  实测桥面只比厅内地板高约 0.5 m（1.511 之后），是贴着地板放的，不是跨在布料地形上方。
  要它成为真正的通行路线，需要美术在 blend 里把它抬起来重摆，再重导。
- **三张窗户 opacity 遮罩没接**：`windowcircle/large/small_opacity.png` 已入库但没接进材质——
  窗户目前是不透明的。要做透光需要把遮罩合成进 base map 的 alpha 并转成 Transparent 表面。
- **两个 checkpoint 的落点是几何推出来的灰盒值**，进去走一遍再调。
- 光照是一盏太阳 + 四盏补光的临时方案，没有烘焙；`_NavMesh` 是空的。
- 逐块 MeshCollider 覆盖全部 22 块（约 23 万面）。够灰盒验证，正式关卡应按可达范围裁剪。
