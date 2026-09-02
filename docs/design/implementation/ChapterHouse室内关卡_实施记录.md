# Chapter House 室内关卡实施记录

> 素材来源与授权: [第三方记录 — Chapter house (chapel)](../../third-party.md) 与 [Metal bridge](../../third-party.md)
> 模型源: `SourceArt/Corridor/RootsDance_Corridor_Blockout.blend` +
> `SourceArt/Blender/ChapterHouseRoundEntrance/ChapterHouseRoundEntrance.blend`
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

保留一个环境场景 + 一个玩法场景供 Chapter House 单独检查，由
`Data/Levels/ChapterHouseInterior.asset` 串起来。正式游玩时生成器还会复制出两个
`*_Connected*` part scene，与 Briggs Interior 的三个场景同时加载，形成没有换关的连续空间。

```text
ChapterHouseInterior_Environment
├── _Lighting     # Global Volume（MainProfile）+ Sun + 四盏厅内补光
├── _Geometry
│   ├── ChapterHouseRoot/ChapterHouse   # 22 块，全部 static，逐块 MeshCollider
│   └── ChapterHouseRoundEntrance       # 一层扁圆拱、短廊与两端接缝地板
├── _Props        # PlayerHeightReference_1p8m（默认关闭的比例参照）
└── _NavMesh      # 空，占位

ChapterHouseInterior_Gameplay
├── _Cameras/FirstPersonCamera   # CinemachineCamera，硬锁玩家头部 + PanicViewShake（只用它的快速回头）
├── _Spawns/PlayerSpawn
├── _Anchors/Checkpoint_CorridorEntrance · Checkpoint_FlowerSpriteEncounter
├── _Narrative                                # FirstMeeting（CueSequence）+ FlowerSprite（FollowCompanion）
├── _Triggers                                 # ChapterHouseGreenhousePortal
├── _Interactables                            # 空，等内容
└── Player
```

Dev Play：`RootsDance > Dev Play > Window` 里的 **02-04A Corridor entrance**（南端进入通道，面向 +Z）
与 **02-04B Flower sprite encounter**（桥与小花初次相遇处，回望）。两者现在都加载
`BriggsInterior.asset` 的五场景组合，因此测试时也能走完整的实验室圆门路线；A/B 只区分试玩落点。

尺寸（导入纠正与布局尺度都应用后）：整体约 **26.5 m 宽 × 37.6 m 深 × 26.4 m 高**；玩家真正走的厅内地板约
**13.6 × 27.4 m**；金属桥长约 13.8 m、宽 1.8 m。地板面与桥面的绝对高度由生成器归位时算出，不写死。

---

## 3. 四个决定

### 3.1 导入尺度与关卡布局尺度分开

模型单位纠正仍由导入 profile 负责（上面那 1.511）；关卡构图另在 `ChapterHouseRoot` 使用 **2 倍**布局尺度，
并把根节点移到 `Y -3.5`。生成器把这两个值固定下来，避免手工场景 Transform 在重建时丢失。
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

原下载包把两个完全不同的面分开保存：`.004 / ImSPOECIAL` 是围在坑边、只有 10 个面的渐变发光卡片，
使用 `gradbake.png`；`.011 / the_warbler` 才是 11,264 个面的折叠布料。原 OBJ 的 MTL 漏写了后者的
贴图关联，但同一下载包里的 `plane.png` 正是 Sketchfab 预览所见的蓝色衣料烘焙——衣片、缝线、白色
高光与深褶阴影全部在这张图中。Unity 因此把 `plane.png` 作为布料的 Base Map 与 Emissive Color Map，
Smoothness 设为 0.3、发光按关卡 12.5 EV 的固定曝光校准为 30,000 nits。边缘卡片使用 `gradalpha.png`
控制透明度、`gradbake.png` 控制 1,500 nits 的渐变发光，并以透明加法方式合成，因此不会再遮成黑带。
场景不再用四盏点光把一圈蓝边误当成布料光泽。程序化菌丝暂时保留在场景中但禁用，两块防漏底板也
移除，让当前 look-dev 直接比较原作者的布料本体。

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

**2026-09-02 改为物理直连，并在同日按一层墙高重做。** 原来偏在一侧的
`ChapterHouseDoor_A` 由局部补墙和三片竖向墙板封平；墙体正中心改为净宽 **3.75 m**、净高
**2.78 m** 的扁圆拱。拱顶和局部墙套都停在二层栏杆底面以下，实验室原有圆门保持不动。
拱门向实验室延伸 **6.2 m** 的短廊，地板只铺两端现有地面的缺口，不再伸进大厅；没有黑面或
`LevelPortal`，玩家开门后直接走过去。Chapter House 一侧另有一对与蓝墙同材质的扁圆双开门：
`AutomaticSlidingDoor` 在玩家进入短廊时侧滑让路，玩家走进大厅、离开短触发区后自动闭合，遮住回望时
反差很大的实验室墙面。它当前保持双向自动开启，不做永久锁定，以免 checkpoint 与回溯路线被截断。

圆门模块是独立 Blender 源和 FBX：
`SourceArt/Blender/ChapterHouseRoundEntrance/ChapterHouseRoundEntrance.blend` →
`Assets/RootsDance/Meshes/Environment/ChapterHouse/ChapterHouseRoundEntrance.fbx`。
程序化源在 `Tools/blender/build_chapterhouse_round_entrance.py`，导出 manifest 在
`SourceArt/Export/ChapterHouseRoundEntrance.export.json`。Unity builder 根据旧 Door A 的墙面和地面
包围盒求正中心，但只替换一层灰泥墙 `.009`；地板 `.007`、柱子 `.005`、二层栏杆 `.012` 和
楼廊 `.013` 都继续引用原始 `ChapterHouseCorridor.fbx`。局部墙套负责收住源网格的大三角切边，
不会再用一张 13.6 × 5.9 m 的替换墙覆盖上层。

入口墙、拱圈、短廊和地板使用三张不带 baked atlas 的专用 HDRP Lit 材质，因此手工生成、无 UV 的
拱圈与廊道不会再把旧贴图的 UV 原点采成黑色。Briggs 原 `GarageShell/Floor` 是一张
1800 × 1400 m 的视觉平面，连接版会关闭它并用 18 × 14 m 的实验室地板替代；新旧地板在接缝处
上下错开 2 mm，避免共面闪烁。

组合关卡由 `BriggsInterior.asset` 同时加载 Briggs 的三个场景与
`ChapterHouseInterior_ConnectedEnvironment/Gameplay` 两个 part scene。连接版移除了 Chapter House
自己的 Sun，沿用 Briggs 的唯一 Directional Light；原 `MainProfile` 会派生为
`ChapterHouseConnectedProfile`，由只包住建筑的 `ChapterHouse Local Volume` 使用，在短廊中以 4 m
blend distance 渐变进入。派生 profile 还会把 Briggs 的低间接光、偏色与暗角恢复为 MainProfile 的
中性值。四盏 `ChapterHouseFill_*` 局部补光也随建筑一起平移保留，因此进入室内后恢复独立场景的
环境光和补光效果，又不会改变实验室其余空间。
Player、摄像机和 Spawn 只保留 Briggs 的一套；原本的 Deathbox mesh 被删除。程序化
`MyceliumUndercroft` 仍随连接版复制，但当前保持 inactive，方便以后恢复而不干扰布料 look-dev。
原地板中段本来就是中央桥加左右布料坑，不是圆拱切坏的两块地板；早期加的两块深蓝防漏底板已经移除，
玩家现在直接看到作者的 `the_warbler` 布料表面。
02-04 两个 checkpoint 记录连接版锚点，并指向这个五场景组合。

---

## 5. 从这里去温室

剩余三扇 chapel 门（`ChapterHouseDoor_B`–`D`）都是 `SwingDoor`：玩家探针进入门根节点上的
触发盒就摆开，离开就摆回。**门根节点必须在 `TriggerVolume` 层**（原因同第 4 节的 portal），
门叶留在 Default 层——它的碰撞体要挡玩家胶囊，不是和探针说话。

只有 **`ChapterHouseDoor_D`** 通向下一章：门后站着
`ChapterHouseInterior_Gameplay/_Triggers/ChapterHouseGreenhousePortal`，同一套黑面 +
`LevelPortal` 的做法，请求加载 `GreenhouseInterior`（即 03-01 温室入口，落在温室自己的
PlayerSpawn）。其余两扇门只开，不通；原 Door A 已由第 4 节的圆形直连入口取代。

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
- **两个 checkpoint 的落点是连接版几何推出来的灰盒值**，进去走一遍再调。
- 光照是一盏太阳 + 四盏补光的临时方案，没有烘焙；`_NavMesh` 是空的。
- 逐块 MeshCollider 覆盖全部 22 块（约 23 万面）。够灰盒验证，正式关卡应按可达范围裁剪。
