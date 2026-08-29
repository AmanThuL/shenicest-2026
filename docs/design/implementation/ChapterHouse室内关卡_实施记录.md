# Chapter House 室内关卡实施记录

> 素材来源与授权: [第三方记录 — Chapter house (chapel)](../../third-party.md)
> 生成器: `Assets/RootsDance/Scripts/Editor/Environment/ChapterHouseInteriorLevelBuilder.cs`
> 菜单: `RootsDance > Build Chapter House Interior`
> 范围: 把 chapter house 素材做成可进入、可行走、可 Dev Play 的室内关卡

**这一关目前没有剧情。** 素材先成为场景，剧本再决定它是什么——所以 checkpoint 不种任何旗标，
`_Triggers` / `_Interactables` / `_Narrative` 三个根是空的，等内容进来。

---

## 1. 关卡构成

和工程里其他关卡同形：一个环境场景 + 一个玩法场景，由 `Data/Levels/ChapterHouseInterior.asset` 串起来。

```text
ChapterHouseInterior_Environment
├── _Lighting     # Global Volume（MainProfile）+ Sun + 四盏室内补光
├── _Geometry
│   ├── ChapterHouseRoot/ChapterHouse   # 素材本体，全部标 static
│   └── WalkableFloor                   # Ground 层的整片地面碰撞盒
├── _Props        # PlayerHeightReference_1p8m（默认关闭的比例参照）
└── _NavMesh      # 空，占位

ChapterHouseInterior_Gameplay
├── _Cameras/FirstPersonCamera   # CinemachineCamera，硬锁玩家头部
├── _Spawns/PlayerSpawn
├── _Anchors/Checkpoint_ChapterHouseNave · Checkpoint_ChapterHouseGallery
├── _Triggers · _Interactables · _Narrative   # 空，等内容
└── Player
```

Dev Play：`RootsDance > Dev Play > Window` 里的 **CH-01 Chapter house nave**（南端进厅，面向 +Z）
与 **CH-02 Chapter house gallery**（中段，回望）。

---

## 2. 三个决定

### 2.1 不缩放，只归位

素材实测 **20.8 m 宽 × 29.6 m 深 × 20.8 m 高**——挨着 1.8 m 的玩家，这就是一座真实尺度的 chapter house。
缩放它只会让建筑对自己的尺寸说谎。生成器只做两件事：X/Z 居中、底面落到 Y 0
（OBJ 是绕作者的原点导出的，不是我们的）。

温室那条「按目标高度缩放并校验 1.2×」的逻辑没有照搬——那是为了让温室匹配既定的关卡体量，
而 chapter house 没有要匹配的东西。

### 2.2 材质全部双面

素材的墙、窗、栏杆都是单面片。不开双面，整座建筑**从室内看会消失**——
而室内是这一关唯一会被看到的一侧。

材质按 21 个 `newmtl` 逐个生成 HDRP Lit（`Materials/Environment/ChapterHouse/`），
贴 base map（+ 三套窗户的法线），Smoothness 压到 0.08：
贴图是作者烘焙好的，上面再加一层高光会读成第二个、错误的光源。

**材质槽的匹配同时认材质名和物体名**。OBJ 导入是否吐出 `newmtl` 名字取决于导入设置，
但物体名（`lower_floor_Plane`）永远带着同样的信息。两边都归一化（只留小写字母数字）后取最长前缀匹配，
所以 MTL 把石膏板拼成 `panles_plasterwood`、而物体名拼对成 `panels_plasterwood` 这种不一致能被吃掉。

### 2.3 自己铺一层地面碰撞

素材的地面是单面片、没有碰撞体。不铺 `WalkableFloor` 的话玩家直接穿到建筑底下——
一个站不上去的灰盒关卡是没法验证的。

---

## 3. 尚未做的

- **授权未落实**：素材没有 licence 文件，来源 URL、作者、授权条款都还空着，见第三方记录。
  **进正式构建前必须补上。**
- **三张窗户 opacity 遮罩没接**：`windowcircle/large/small_opacity.png` 已入库但没接进材质——
  窗户目前是不透明的。要做透光需要把遮罩合成进 base map 的 alpha 并转成 Transparent 表面。
- **圆洞的位置没有实机确认**：素材自带的圆形开口（`Window_fourclo` 用 `windowcircle` 那套贴图，
  对应 `wall-pianoside` / `wall_galleryside` 两面 Circle 墙）具体开在哪、是不是就是要用的那个洞，
  需要进关卡看一眼再定。
- **两个 checkpoint 的落点是灰盒值**，按素材包围盒推的，进去走一遍再调。
- 光照是一盏太阳 + 四盏补光的临时方案，没有烘焙；`_NavMesh` 是空的。
