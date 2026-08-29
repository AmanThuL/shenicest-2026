# 02章 Briggs Interior 实验室室内设计与实现

> 状态：第二轮废弃实验室家具与桌面器材重布置已实现并通过 Unity 验证，2026-08-29
>
> 目标场景：`BriggsInterior_Environment` 与 `BriggsInterior_Gameplay`
>
> 空间依据：`策划组/实验室俯视图_标准化.svg`、02章实验室策划案、当前 Unity 灰盒和美术组视觉规范

## 1. 结论与实施边界

本关采用“废弃生态科研站被植物和菌丝缓慢接管”的室内方向。空间骨架沿用当前 Briggs Interior 的
18 × 14 m 主实验室、3.2 × 16.8 m 南侧廊道和 5 m 层高。玩家从南向北进入，先在断电廊道获得生物光源，
再进入主实验室完成东侧根须实验、中央实验和西侧档案调查。北墙正中心已经具备圆形出口结构和自动滑门，正式模型与剧情解锁流程仍可后续替换和接线。

本方案的关键决定如下：

- 中央主实验台是空间、光线和行动的共同锚点。
- 主实验室采用顺时针探索环线，避免俯视图原动线漏过 S7 东侧根须区。
- 廊道保持真正的黑暗困境，S2 荧光藻是获得手电前唯一明确的生物光焦点。
- 最终出口位于北墙正中心。当前墙体已经包含 4.5 m 圆形门洞，Gameplay 场景已接入双扇自动滑门与 Trigger；后续可用正式门模型替换现有程序化门叶，但不得改变门洞中心和玩家通路。
- 所有通过 Prefab World Builder 放置的 props 必须进入场景根级
  `Prefab World Builder/<Palette>/PIN/<Prefab Instance>`，不得散落在 `_Props` 或场景根级。
- 固定建筑碰撞继续使用独立的 `PlanCollisionShell`，不依赖 Garage 或 Lab FBX 的复杂 MeshCollider。
- 当前不把候选素材库直接视为 Unity 可用资产。只有已经导入并做成项目 prefab 的资源才可由 PWB 放置。

本文分开记录三种信息：

- 已验证事实：当前场景、现有 prefab、策划明确要求。
- 实施建议：可直接照表布景、加 Collider、布灯和制作特效。
- 待确认项：策划案互相冲突或缺少定义的内容，不能由场景美术自行补成事实。

### 1.1 Unity 实现快照

`feat/briggs-interior-environment` worktree 已完成可重复执行的首轮环境实现，并在第二轮按美术反馈替换家具：

- `Prefab World Builder` 下建立 `LabFurniture`、`CampEvidence`、`LabArchives`、`LabEcology` 和 `LabDebris` 五组 Palette。
- 首轮共放置 160 个 Prefab 实例，包括家具、密集实验与档案器材、边缘及地砖裂缝杂草、低矮青苔斑和苔藓岩块。
- 第二轮重建后共 121 个 PWB prefab 实例。数量下降来自合并中央六柜台、移除阻塞北环路的服务台和清理重复器材，不是减少地面生态或桌面叙事密度。
- 第二轮保留全部 `BI_Overgrowth_*`、`BI_Moss_*` 与既有地面生态坐标，只重做家具和台面层。
- 顶部结构、墙体、悬挂植物和气氛最终以用户确认的 `006b2dc` 为视觉基线：`Ceiling`、两根梁、Mesh 内的 ceiling holes、
  `GarageSourceArt/IvyHanging` 与 `_Props/CeilingHoleVines` 全部保留 `006b2dc` 的 Prefab、父子层级与 Transform。
  破顶是 `GarageShell.fbx/Ceiling` 网格中真实建模的开口，不是植被或光柱造成的视觉错觉。PWB 下 121 个室内 props
  则严格保持 `55a362d` 的状态；两套基线互不覆盖。
- `Ceiling`、`Ceiling_Beam` 和 `Ceiling_Beam_Broken` 恢复使用 `006b2dc` 场景中的原始
  `Assets/RootsDance/Materials/Environment/Garage/GarageCeiling.mat`，不再叠加后续专用 Triplanar 材质。
- 同轮 bounds 审计发现东侧根须组、东墙常春藤和 `PSX_Adrenaline_Syringe` 的 Renderer 外廓越过主室边界。
  根须与常春藤向室内收拢并缩小，针筒从约 5 m 的误尺度恢复到约 0.8 m 的大型实验器材尺度；它们仍留在原叙事分区，
  但不再穿墙或在室外形成难以辨认的轮廓。
- 原先六段双排黑柜改为约 `2.2 × 5.4 × 0.92 m` 的一体废弃实验岛。岛台由 CC0 同系列 sink、open shelves、outlet counter 组合，统一使用旧青灰烤漆、锈褐边缘和污渍台面材质。
- 东侧 S7 工作台原位替换而不移动根须与植物；西侧档案区增加原创公告板；东北角增加由黄铜象限仪 Mesh 改造的旧式光学标定仪。
- 小件与软植物通过项目内 `_NoCollision` Prefab Variant 关闭 Collider，不在场景实例上制造 Collider override。
- 桌面器材使用旋转后 Renderer bounds 自动贴合台面。直立、倾倒和横放物件都以最低点落在支撑面上，避免悬空。
- 从本地 CC0 Lab Assets 增补显微镜、烧杯、过滤瓶、分液漏斗、酒精灯、铁架台、环架、坩埚、针筒、蒸发皿、药匙和折叠实验服。
- 北墙中央 `abs(X) < 2.75` 且 `Z > 4.4` 的圆门预留区不放任何本轮 props。
- 已保留 `006b2dc` 状态下的 `BriggsInteriorWalls`、圆形出口、`BriggsAutomaticExitDoor`、入口封闭门、破顶与悬挂藤蔓。
  顶光不依赖删除植物，而由恢复后的 18000 lux 青绿色 Sun、较宽 RoofShaft 与较浓局部体积雾维持洞口和多束 God Ray 的可读性。
- 玩家、PlayerSpawn、四个 Dev Play checkpoint 和两块 Ground layer 已按本文坐标接线。
- `006b2dc` 的 `_LabAtmosphere/Global Volume` 直接使用 `BriggsInteriorProfile`，包含暗绿色 Gradient Sky、Bloom、白平衡与
  本地 `PsxPostProcess`。该 Volume 是这一历史画面的一部分，不得改成继承 `MainProfile` 的局部 Box Volume。
- 本轮实际导入 `Astronomical quintant`、`Chemistry Old Lab Tubes`、`Lab Glassware`、`PSX Adrenaline Syringe`，并保留其 CC BY 4.0 来源记录。`Jelly_Mushroom` 仍不进入本轮，因为地面生态已获美术认可且不应改变。
- 截图中的 `Abandoned Lab Equipment`、`Mad Scientist Lab`、`Conspiracy Papers X-Lab` 和 `PSX Vintage Wall Clocks` 本地没有可用源包；本轮只借构图，用项目原创低模 CRT、公告板和破表替代。`Chemical Lab Fallout 4` 与 Black Mesa 衍生素材不进入发布工程。

完整重建入口为 Unity 菜单 `RootsDance/Environment/Build Complete Briggs Interior`，命令行入口为
`RootsDance.Editor.Environment.BriggsInteriorEnvironmentBuildPipeline.BuildFromCommandLine`。生成器只重建各 Palette `PIN` 下以
`BI_` 开头的直属实例，保留后续用 PWB 手工添加的其他内容。

## 2. 当前 Unity 基线

### 2.1 场景与坐标

当前场景文件：

- `Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Environment.unity`
- `Assets/RootsDance/Scenes/Levels/BriggsInterior/BriggsInterior_Gameplay.unity`

布景统一采用以下坐标约定：

- 主实验室中心为 `(0, 0, 0)`。
- `+Z` 为北，北墙正中心为现有圆形次级出口；其前方继续作为门体与交互净空区。
- `+X` 为东，东侧是操作台 B 和变异根须区。
- 主实验室可用范围约为 `X -9 至 9`、`Z -7 至 7`，地面 `Y 0`，顶棚约 `Y 5`。
- 南侧廊道中心线为 `X 3`，从 `Z -23.8` 延伸至主室入口 `Z -7`。
- 玩家胶囊根节点落地高度使用 `Y 1`。

当前可见壳体来自：

- `Assets/RootsDance/Meshes/Environment/Garage/GarageShell.fbx`
- `Assets/RootsDance/Meshes/Environment/Garage/BriggsInteriorWalls.fbx`
- `Assets/RootsDance/Materials/Environment/Garage/`

`GarageShell` 只保留地面、天花板和梁。实验室四面墙由 `BriggsInteriorWalls` 提供，东西墙、南墙和
带 4.5 m 圆形出口的北墙均为独立、带实体厚度的网格。两者都只负责视觉，不负责行走碰撞。当前独立碰撞壳在
`_Geometry/PlanCollisionShell` 下，包含主室地面、廊道地面和六段外墙 BoxCollider。这一做法应保留。

以下结构网格已经导入，但当前 Briggs 场景未使用：

- `Assets/RootsDance/Meshes/Environment/LabBlockout.fbx`
- `Assets/RootsDance/Meshes/Environment/LabCorridor.fbx`
- `Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_PlantResearchLab.fbx`
- `Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_Greenhouse.fbx`
- `Assets/RootsDance/Meshes/Environment/GAIA1/Buildings/Briggs_SampleStorage.fbx`

`LabBlockout.fbx` 和 `LabCorridor.fbx` 的 importer 会自动生成 Collider，不应直接以生成的复杂碰撞替换
`PlanCollisionShell`。若只取可见网格，关闭或移除实例上的多余 Collider，再用简化碰撞壳验证门洞。

### 2.2 当前灯光与气氛

已验证的当前灯光：

| 对象 | 类型与位置 | 当前用途 | 后续处理 |
|---|---|---|---|
| `Sun` | Directional，18000 lux | 青绿色外部日光和破顶来源 | 恢复 `006b2dc` 的 `(0.88, 0.97, 0.85)` 色彩、体积参与度 0.12 和 8° 角直径 |
| `CorridorFill` | Point，`(3, 3.2, -15)`，Range 10 | 廊道暗部托底 | 保持很弱，不得让玩家在拿到手电前看清全廊道 |
| `LabFill_North` | Point，`(-3, 3.8, 3.5)`，10000 lm，Range 12 | 主室北半暗部托底 | 恢复 `006b2dc` 的无阴影青绿色填充 |
| `LabFill_South` | Point，`(4, 3.5, -3.5)`，8000 lm，Range 12 | 主室南半暗部托底 | 恢复 `006b2dc` 的无阴影灰绿色填充 |
| `RoofShaft_Main` | Spot，`(0.1, 4.18, 2.5)`，1100 lm，28° | 主破洞光柱 | 体积参与度 3.2，绿色无阴影艺术光柱 |
| `RoofShaft_West` | Spot，`(-5.35, 4.18, 3.75)`，700 lm，24° | 西侧破洞光柱 | 体积参与度 2.2，绿色无阴影艺术光柱 |

现有气氛资源：

- `Assets/RootsDance/Settings/VolumeProfiles/BriggsInteriorProfile.asset`
- `Assets/RootsDance/Textures/Environment/Garage/LabFogNoise.asset`
- `Assets/RootsDance/Materials/Environment/BriggsInterior/LabLightBlocker.mat`
- `Assets/RootsDance/Scripts/Editor/Environment/BriggsInteriorAtmosphereBuilder.cs`

场景已经恢复 `006b2dc` 的固定曝光 EV 4.5、暗绿色 Gradient Sky 全局 Volume、冷绿色雾、局部体积雾、漏光遮挡、APV 和 `StaticLightingSky`。
局部雾恢复 13.5 m Mean Free Path，由 28° 和 24° 的破顶 Spot 配合太阳光形成稳定的多束 God Ray / 丁达尔光柱。布景完成后再做一次 APV
和 Reflection Probe 检查。不要在 props 尚未稳定时反复烘焙。

## 3. 艺术方向

视觉关键词：

`高清 PSX / 低模半写实 + 九十年代生态科研复古未来主义 + 1970s 旧设施骨架`

落地规则：

- 建筑和背景设备采用简化几何、半写实比例、128 至 512 px 贴图语言。
- 植物、调查物和实验器皿可以比背景高一个精度层级，但必须统一色彩和 roughness。
- 1970s 是建筑和原始仪器年代。九十年代语言只用于后装终端、CRT、状态灯和玩家 HUD。
- 场景的主要色块是湿冷灰绿、锈褐、旧纸黄。生物光只使用冷青和少量焰苔橙红。
- 交互识别优先依靠轮廓、构图、局部对比和细白描边，不靠全场霓虹。
- 写实参考图只借用中央桌构图、斜向体积光、湿面和雾层，不追求全场高清 PBR。
- 植物集中为 3 至 5 个生态入侵岛，不能平均撒满地面。

参考图色彩被落实为黑绿色阴影、去饱和青灰绿中间调、暖白破顶光，以及少量锈褐和旧纸暖色。局部后处理采用
`Contrast +20`、`Saturation -20`、`Temperature -6`、`Tint -12`、冷绿 Color Filter 和强度 0.08 的克制 Bloom。PSX 参数为
`Pixel Scale 4`、`Color Levels 32`、`Dither 0.6`、`Interlace 0.1`，保留低模半写实轮廓，不把画面处理成高饱和霓虹。

视觉层级从高到低：

1. 北侧破顶和中央实验台形成的主光轴。
2. 东侧半透明变异根须和操作台 B。
3. 西侧档案桌、旧纸张与隐藏夹层。
4. 边缘碎玻璃、空瓶、砖块和小型植物。

## 4. PWB 层级与场景所有权

Main Environment 的真实 PWB 结构是：

```text
Prefab World Builder
└── <Palette Name>
    └── PIN
        └── <Prefab Instance>
```

Briggs Interior 必须沿用同一结构。建议 palette：

```text
Prefab World Builder
├── LabInfrastructure
│   └── PIN
├── LabFurniture
│   └── PIN
├── CampEvidence
│   └── PIN
├── LabArchives
│   └── PIN
├── LabEcology
│   └── PIN
└── LabDebris
    └── PIN
```

所有可见 props 都进入上述 PWB 层级：

- `LabInfrastructure`：管线、阀门、旧灯具、配电箱、泵。
- `LabFurniture`：柜体、工作台、培养箱、书架、落地机器。
- `CampEvidence`：现有 21 个实验小件，当前 palette 已登记。
- `LabArchives`：clipboard、binder、纸堆、文件夹、植物草图、隐藏夹层盖板。
- `LabEcology`：Ivy、蕨、草簇、根系、苔藓岩块。
- `LabDebris`：碎砖、玻璃堆、桶、倒塌填充。

以下对象不属于 PWB props：

- 固定建筑壳和 `PlanCollisionShell` 留在 `_Geometry`。
- 灯、Reflection Probe、Decal Projector、APV 和 Volume 留在 `_Lighting` 或专用气氛根。
- 可见 prop 的交互 Trigger、任务状态组件和门逻辑留在 Gameplay 场景的 `_Interactables`、`_Triggers`。
- 粒子和流程 VFX 可以留在 `_Props` 的专用 VFX 子根，但其承载用可见模型仍由 PWB 放置。

这样可以用 PWB 随时调整可见摆件，同时不破坏 Gameplay 场景里的稳定交互引用。

## 5. 分区设计、素材与摆放

### 5.1 S0 至 S5 南侧廊道

范围：`X 1.4 至 4.6`，`Z -23.8 至 -7`。

空间目标：长、窄、湿、断电。玩家在拿到生物手电前只能读到近处墙体轮廓、S2 冷青微光和远端菌丝门。

布置：

- S0 检修门放在南端，保持约 0.8 至 1.0 m 可通行缺口。
- 两侧墙上用 Pipes、Wires、阀门和配电箱做不连续的纵向节奏，右侧 S3 附近留出折叠台。
- S2 放在左墙约 `Z -18.5`，采用荧光藻薄片、裂缝贴花和少量漂浮孢子。
- S3 放在右墙约 `Z -13.5`，操作台前至少保留 1.4 m 净宽。
- 廊道手记建议放在菌丝门前约 1.5 m 的右墙夹缝。策划原文的 15 m 与总长冲突，确认前不要按 15 m 落位。
- S4/S5 菌丝门在 `Z -7.2`，左、上、右三个根节点与门体使用独立交互对象。
- 积水只使用 HDRP Lit 湿润材质、Decal 或薄面，不做下凹碰撞。

适合素材：

- 现有 `GarageShell`、`GarageIvy`。
- SourceArt `Pipes.blend`、`Buckets.blend`、`Rubble.blend`，须先导出和做 prefab。
- 候选 Retro Plumbing & Wiring 的 Pipes、Wires、Circuit Breaker、Valve、Switch、Pump。
- `Assets/RootsDance/Prefabs/VFX/ContaminationMotes.prefab` 作为极少量门外浮尘基础。

### 5.2 西北破损培养与恒温设备区

建议范围：`X -8.2 至 -3.8`，`Z 2.7 至 6.2`。

布置：

- 一个破碎玻璃培养罐靠西墙，一个老式恒温柜靠北墙，形成两个大体块。
- 地面集中一小堆玻璃和砖块，不跨入中央环路。
- 破顶根系从 `Y 5` 垂落，最低可见枝条尽量保持 `Y 2.3` 以上。
- 在破顶光下放 1 至 2 株蕨、少量 Ivy 和 moss，形成主要生态入侵岛。

推荐导入候选：

- CC0 `cabinet_cabinet.fbx` 或 `cabinet_cabinet_two_shelves.fbx`。
- CC0 `machine_desiccator.fbx`。
- 少量 Poly Haven `chemistry_set_1k.fbx` 只作为近景英雄物件。

### 5.3 西侧档案与研究员书桌区

建议范围：`X -8.2 至 -3.3`，`Z -5.8 至 0.5`。

布置：

- 高书架贴西墙，不能突出到主环路。
- 书桌长边南北向或略朝中央旋转 10 至 15 度，让玩家从中央桌西侧能看见纸张反光。
- 桌面放 binder、clipboard、放大镜、实验服和散落针筒，密度高于其他区域，但保留少量可读空隙和明确的档案焦点。
- 隐藏夹层放在桌体东侧或南侧，必须由手电照射后才显示调查轮廓。
- 纸张与小件默认无行走阻挡。若现有 prefab 自带 BoxCollider，作为纯布景副本时可在实例上禁用。

直接可用：

- `Assets/RootsDance/Prefabs/Environment/Props/clipboard.prefab`
- `Assets/RootsDance/Prefabs/Environment/Props/binder_notebook.prefab`
- `Assets/RootsDance/Prefabs/Environment/Props/misc_magnifying_glass.prefab`

### 5.4 中央主实验区

建议范围：`X -3.2 至 3.4`，`Z -2.6 至 4.0`。

中央桌是整个房间的主视觉锚点。第二轮用一个 PWB 项目 prefab 组合 2 至 3 个同系列旧 counter，最终外廓约
`2.2 m × 5.4 m × 0.92 m`，场景中心 `(0.10, 0, 0.10)`。柜门缺口、开放搁架、sink 和 outlet 打破现代模块化整洁感，
但桌面连续、不可通行的中缝不再外露。

环路要求：

- 四周最小净宽 1.2 m。
- 推荐净宽 1.5 m。
- 东南角保持更宽，确保 S6 进入后自然转向 S7。
- 桌下不得伸出隐形 Collider。

中央桌分成两个清楚工作面：

- 东侧 S8A：土壤分析仪、秤、培养皿、试管架。
- 西侧 S8B：过滤漏斗、离心试管、干涸试剂瓶和滤液容器。

直接可用小件：

- `bottle_test_tube_rack.prefab`
- `bottle_glassware_test_tube_medium.prefab`
- `bottle_glassware_centrifuge_tube.prefab`
- `dish_petridish.prefab`
- `dish_watch_glass.prefab`
- `bottle_dropper.prefab`
- `misc_scale.prefab`
- `heating_equipment_forceps.prefab`
- `heating_equipment_thermometer.prefab`

第二轮已导入并制作项目 prefab：

- CC0 全套 counter 变体、两个 cabinet、centrifuge、desiccator、hot plate、electronic scale 和 calculator。
- CC BY `Chemistry_Old_Lab_Tubes.fbx`、`Lab_Glassware.fbx` 和 `PSX_Adrenaline_Syringe.fbx`。

桌面按语义而不是平均铺满：东侧 S8A 是秤、显微镜、培养皿和旧试管架；西侧 S8B 是离心机、过滤器皿、玻璃器皿和热板。
器材允许小角度错位、互相遮挡和局部空缺，但必须通过 Renderer bounds 贴合 `Y 0.94` 的工作面，禁止悬空。所有桌面版本无行走 Collider。

### 5.5 东北废弃设备区

建议范围：`X 4.6 至 8.3`，`Z 2.0 至 5.8`。

用途是提供旧设施历史和压住东北角的视觉重量，不承担主交互。

布置：

- 一台报废落地机器贴东墙，旁边放碎砖、空柜和一小簇 Ivy。
- 只用一个中型体块和一个低矮残骸堆，不要堆满。
- 不侵入北墙正中心的圆形门预留区。
- 完整象限仪只取 Mesh 和轮廓语义，以氧化黄铜和旧灰绿材质重做为光学标定仪，目标 footprint 不超过 `1.2 × 0.8 m`，中心约 `(5.65, 0, 4.15)`，不保留博物馆金色陈列感。

推荐候选：

- CC0 `machine_calculator_large.fbx`、`machine_electronic_scale.fbx`。
- SourceArt `Rubble.blend`。
- `Assets/RootsDance/Prefabs/Environment/Rocks/rock_moss_set_01.prefab` 少量使用。

### 5.6 东侧操作台 B 与变异根须区

建议范围：`X 4.1 至 8.2`，`Z -4.7 至 0.8`。

布置：

- 操作台 B 贴东墙，工作面朝西。
- 两组培养皿支架左右并置，一组普通根须偏灰褐，一组变异根须带克制的黄绿色内部流动。
- 大体量根须从东墙和地面裂缝进入，构成 S6 入室后的第一视觉引导。
- S7 Checkpoint 周围保留半径 1.2 m 的无 prop 落地区。
- 根须可穿越的细枝不加 Collider。承担视觉封路的主根另用 1 至 2 个 CapsuleCollider。
- `PSX Adrenaline Syringe` 作为废弃取样注射器放在工作台前半，使用脏灰绿 Tint；保留普通/变异培养皿、clamp、gloves、safety glasses 和 microscope，把重复漏斗、坩埚、铁架台迁到中央岛。

直接可用：

- `dish_petridish.prefab`
- `bottle_glassware_vial_medium.prefab`
- `bottle_glassware_reagent_bottle_small.prefab`
- `bottle_plastic_bottle_medium.prefab`
- `clamp_tube_clamp.prefab`
- `ppe_rubber_gloves.prefab`
- `ppe_safety_glasses.prefab`
- `Assets/RootsDance/Prefabs/Environment/Rocks/pine_roots.prefab`
- `root_cluster_01.prefab`、`root_cluster_02.prefab`、`single_root.prefab`

### 5.7 北侧圆形次级出口，保留现有实现

`64792d1` 已完成北墙 4.5 m 圆形门洞，并在 Gameplay 场景加入 `BriggsAutomaticExitDoor`。当前门由两扇程序化门叶、Trigger 和 `AutomaticSlidingDoor` 组成，可作为正式模型到位前的可走通实现。

- 不让周边 PWB props、管线、根系和落地设备侵入门洞与触发区。
- 保留现有 Trigger 和行走净空，正式门模型仅替换视觉与必要动画引用。
- 菌丝膜、剧情感应点、专属灯光、Reflection Probe、VFX 和 Shader 仍属于后续交互表现，不在本轮布景中扩展。
- 正式模型到位后应复核门框厚度、门叶收纳空间、触发距离和 Collider，不改变圆门中心位置。

## 6. 素材分级清单

### 6.1 Unity 已导入，可直接通过 PWB 使用

实验小件统一位于：

`Assets/RootsDance/Prefabs/Environment/Props/`

共 21 个 prefab，包括：

- 文件类：`clipboard`、`binder_notebook`。
- 容器类：试管架、两种试管、vial、两种 reagent bottle、centrifuge tube、dropper、plastic bottle。
- 台面类：petridish、watch glass、wash bottle、scale、magnifying glass。
- 工具与 PPE：thermometer、forceps、tube clamp、rubber gloves、safety glasses。

这些 prefab 已有非 Trigger BoxCollider，并使用：

- `Assets/RootsDance/Materials/Environment/Lab_Palette.mat`
- `Assets/RootsDance/Materials/Environment/Lab_Glass.mat`

它们已登记到 PWB `CampEvidence` palette。桌面小件不需要玩家阻挡时，使用项目内 `_NoCollision` Prefab Variant，不在场景实例上
禁用 Collider，也不要再添加第二套碰撞。

室内植物可直接使用：

- `Assets/RootsDance/Prefabs/Environment/Vegetation/M3D_fern-1.prefab`
- `M3D_fern-2.prefab`
- `M3D_ivy_1.prefab` 至 `M3D_ivy_4.prefab`
- `M3D_grass_patch_1.prefab` 至 `M3D_grass_patch_8.prefab`

这些软植被没有 Collider。根系和苔藓岩块位于
`Assets/RootsDance/Prefabs/Environment/Rocks/`，多数使用 MeshCollider，只保留少量英雄物件的 MeshCollider，主路线旁优先换简化碰撞。

现成流程 VFX：

- `Assets/RootsDance/Prefabs/VFX/AnomalousSpores.prefab`
- `Assets/RootsDance/Prefabs/VFX/ContaminationMotes.prefab`

两者可以作为孢子和空气微粒的基础，不应直接承担完整菌丝动画。

### 6.2 SourceArt 已有，必须先走导出管线

- `SourceArt/Blender/Garage/Assets/Pipes.blend`
- `SourceArt/Blender/Garage/Assets/Rubble.blend`
- `SourceArt/Blender/Garage/Assets/Buckets.blend`
- `SourceArt/Blender/Garage/Assets/Ivy_Hanging.blend`
- `SourceArt/Blender/Scanner/Scanner.blend`

Pipes、Rubble、Buckets 和 Scanner 当前不是 RootsDance prefab，不能直接列入 PWB palette。处理顺序：

1. 按 `docs/architecture/tooling/Blender到Unity导出管线.md` 导出 FBX。
2. 抽取并统一 HDRP 材质。
3. 在 `Assets/RootsDance/Prefabs/Environment/` 下创建项目 prefab。
4. 添加简化 Box 或 Capsule Collider。
5. 加入对应 PWB palette 后再进场景。

### 6.3 候选素材库，优先筛选后导入

第一优先是 OpenGameArt Lab Assets CC0：

`/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/02_风格补充/OpenGameArt/LabAssets_CC0/`

优先导入：

- `FBX/Furniture/Cabinets/cabinet_cabinet.fbx`
- `FBX/Furniture/Cabinets/cabinet_cabinet_two_shelves.fbx`
- `FBX/Furniture/Counters/counter_counter.fbx`
- `FBX/Furniture/Counters/counter_counter_2_shelves.fbx`
- `FBX/Furniture/Counters/counter_counter_3_shelves.fbx`
- `FBX/Machines/machine_microscope.fbx`
- `FBX/Machines/machine_centrifuge.fbx`
- `FBX/Machines/machine_desiccator.fbx`
- `FBX/Machines/machine_hot_plate.fbx`
- `FBX/Machines/machine_electronic_scale.fbx`

这批与现有实验小件同源、CC0、同一调色板体系，是风险最低的扩充来源。家具使用 1 至 3 个 BoxCollider，机器使用单个
BoxCollider 或少量 compound boxes，不要直接加 MeshCollider。

第二优先是 CC0 Retro Plumbing & Wiring：

`/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/01_美术组点名/Itch/chilly-durango__3d-retro-plumbing-wiring/`

适合导入 Pipes、Wires、Circuit Breaker、Generator、Pump、Pipe Valve、Switch 和 Transformer。其 16 色、64 至 128 px
贴图与当前方向相符。

第三优先是 Poly Haven 近景英雄物件：

- `chemistry_set/chemistry_set_1k.fbx`
- `moss_01/moss_01_1k.fbx`
- `nettle_plant/nettle_plant_1k.fbx`
- `periwinkle_plant/periwinkle_plant_1k.fbx`
- `shrub_sorrel_01/shrub_sorrel_01_1k.fbx`
- `weed_plant_02/weed_plant_02_1k.fbx`

只少量放在破顶光下或调查近景。导入后需要降贴图、去饱和和统一 roughness，避免写实度跳变。

Sketchfab 下载包多数是 CC BY。使用前必须核对作者、源页面、许可版本并进入最终署名清单。
`Chemical Lab Fallout 4` 和 `Black Mesa Lab Props` 有明确第三方作品来源风险，不进入发布构建。

第二轮截图素材核对结果：

| 截图目标 | 本地状态 | 本轮处理 |
|---|---|---|
| 化学旧桌、废弃 Lab Equipment | 参考包不可发布或未下载 | 用 CC0 counters、centrifuge、scale、CRT 原创组合复现破损密度 |
| Mad Scientist Lab | metadata-only | 借玻璃器皿高低错落构图，不导入模型 |
| Conspiracy Papers X-Lab | metadata-only | 用项目原创公告板、现有 clipboard/binder/纸片变体替代 |
| Old Lab Tubes | 已下载，CC BY 4.0 | 导入并放在中央 S8A |
| PSX Adrenaline Syringe | 已下载，CC BY 4.0 | 导入并放在 S7 |
| Astronomical quintant | 已下载，CC BY 4.0 | 改材质并作为东北旧光学标定仪 |
| Lab Glassware | 已下载，CC BY 4.0 | 只取 2 至 3 件的组团观感，放在 S8B |
| PSX Vintage Wall Clocks | 本地无 source zip | 自制破损低模时钟，不从截图抠图 |

四个 CC BY 模型的转换后 FBX 与原始 metadata 位于
`Assets/ThirdParty/Environment/BriggsArtistPicks/`。Unity 场景只引用 `Assets/RootsDance/Prefabs/Environment/` 下的项目 prefab，
不直接散放第三方 FBX。

### 6.4 第四轮增量模型核对

核对来源：

`/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术组/素材下载/2026-08-28_素材库核对_第四轮/README.md`

本轮没有替代现有 P0 家具、实验器皿或流程交互物的必需模型。两个已下载模型可以使用纯 Mesh，另建项目内
HDRP Shader、Material 和 Prefab，不需要保留原始材质外观。

| 模型 | 结论 | 用法 | 不建议做法 |
|---|---|---|---|
| `Jelly_Mushroom` | 条件性采用，P2 生态英雄物件 | 拆出一个或两个蘑菇组，放入西北破损培养罐或破顶光下的生态入侵岛 | 原样整组摆在主路线、替代 S2 荧光藻、做成高亮蓝色任务指引 |
| `Astronomical quintant` | 本轮采用 | 以纯 Mesh 和新材质重做旧式光学标定设备，放在东北旧设备区 | 把博物馆金色材质原样保留，或侵入圆门净空 |
| `Fairy tale mushroom` | 不使用 | 仅有 metadata | 作者关闭下载，官方 metadata 未给出许可且带 `noai` 标签 |
| `Glowing Mushrooms` | 不使用 | 仅有 metadata | 作者关闭下载，不能从截图或预览反向取得模型或贴图 |
| `Lichen (Usnea antarctica)` | 不使用 | 用户已明确排除 | 不从废纸篓恢复，也不重新加入候选清单 |

`Jelly_Mushroom` 的 OBJ 约 335,477 三角面，包含三个蘑菇组，每组拆成五个材质段。源 OBJ 没有随附 MTL，只有独立贴图，
因此直接按材质名自动导入并不可靠。推荐把它当作 Mesh 源：

1. 在 Blender 中按三个组拆分，只保留轮廓最符合培养样本的一组，必要时保留第二组做远景。
2. 按 Unity 中 1 m 参考方块重新定标，不直接相信 OBJ 的源单位。
3. 为了匹配低模半写实轮廓做一次 Decimate 或手工删减。减面主要服务风格统一，不是硬性性能预算。
4. 菌柄、菌盖、垂须和孢子珠可继续共用原 UV，但改用项目内发光生物材质。
5. 只在培养罐、花槽或阻挡底座上加 BoxCollider。蘑菇网格本身无 Collider；若可调查，另建
   `Interactable` Trigger。
6. 放入 `Prefab World Builder/LabBiology/PIN`，不得散落到场景根级。

推荐材质表现：菌盖为低饱和灰绿或灰青，菌褶和少量孢子珠使用冷青 emission，垂须接近潮湿灰白。Emission 只照亮近邻轮廓，
不把整个西北区染成蓝色。可选择性使用原 Base Color 作为颜色或发光遮罩，并将贴图降到 512 或 1024；也可以完全不用原贴图，
改用对象空间高度渐变、噪声和 Fresnel 生成遮罩。脉动频率应慢于任务根节点，避免被误认成可解谜对象。

`Astronomical quintant` 的 OBJ 约 263,280 三角面，拆成 76 个对象和 `kwintant_mat`、`glass`、`mirror` 三类材质，适合按零件取用。
完整器件只有约 0.5 m 高，放在桌面尺度合理，但天文学语义与植物实验室较弱。只有在需要一个明显的前数字时代测量装置时才采用：

1. 保留支架、主刻度弧、一个镜筒和少量旋钮，删除重复小机械件与过细结构。
2. 使用 HDRP Lit 重做暗化黄铜、氧化金属、旧灰绿烤漆和脏玻璃，不需要为它单独写 Shader。
3. 原 8K Base Color 不直接进入项目。若其磨损信息有价值，降到 1024 后作为低权重颜色或污渍遮罩，再用 Material Tint 统一色相。
4. 作为非交互桌面物件时禁用 Collider；作为调查物时使用一个简化 BoxCollider 或独立 Raycast Trigger。
5. 放入 `Prefab World Builder/LabHeroProps/PIN`，每间实验室最多一个实例。

两个已下载模型均为 CC BY 4.0。若最终进入项目，必须在第三方来源记录和发布署名中保留模型名、作者、Sketchfab 页面和许可版本。
重新制作 Shader、Material、贴图或 Mesh 不会取消署名义务。

### 6.5 Mesh 优先与项目材质策略

候选模型可以只取几何体，不要求沿用原贴图或原材质。统一规则如下：

- 第三方源 Mesh 与原贴图保存在 `Assets/ThirdParty/Environment/` 的独立来源目录；项目自有 Material、Shader 和 Prefab 分别放入
  `Assets/RootsDance/Materials/Environment/`、`Assets/RootsDance/Shaders/Environment/` 和
  `Assets/RootsDance/Prefabs/Environment/`。
- 不修改第三方源资产本体。通过项目 Prefab 设置缩放、Collider、材质替换和交互组件。
- 普通金属、玻璃、塑料、木材和混凝土优先使用 HDRP Lit，通过 Base Color Tint、Smoothness、Metallic、Normal 与 Decal 统一风格。
  只有发光生物、菌丝流动、汁液、透明外壳和局部溶解需要 Shader Graph。
- 原贴图有可用 UV 细节时，可以保留为低分辨率遮罩；颜色不合适时用 Tint、去饱和、曲线和通道重映射修正。原贴图没有帮助时，
  直接使用纯色、调色板、triplanar 污渍或程序噪声。
- 同一 Shader 的颜色、发光强度、脉动相位和湿润度使用共享 Material 或 Material Variant 调整。项目渲染规范禁止
  `MaterialPropertyBlock`，以保持 SRP Batcher 兼容。
- 所有由这些 Mesh 制作的可摆放 Prop，完成项目 Prefab 后再加入 PWB Palette，并遵守
  `Prefab World Builder/<Palette>/PIN/<Prefab Instance>`。

## 7. Collider 与 Layer 规范

### 7.1 Layer

- 地面：`Ground`，Layer 8。`PlayerConfig` 的 grounded 检测只识别该层。
- 墙、固定家具、门体和阻挡根系：`Default`。
- 调查和可交互 Trigger：`Interactable`，Layer 9。
- 流程体积：`TriggerVolume`，Layer 10。
- 玩家探针保持 `PlayerProbe`，Layer 11。

### 7.2 物件规则

| 物件 | Collider | 规则 |
|---|---|---|
| 地面和外墙 | 独立 BoxCollider | 使用 `PlanCollisionShell`，不跟可见网格耦合 |
| 中央桌、书架、柜体 | 1 至 3 个 BoxCollider | 只包络玩家会撞到的体积，桌下不伸出 |
| 落地机器、培养箱 | 单个或少量 BoxCollider | 不用复杂 MeshCollider |
| 小瓶、纸张、工具、碎玻璃 | 默认无行走碰撞 | 交互需要时使用独立 Raycast Trigger |
| Ivy、蕨、草 | 无 Collider | 软植被可穿过 |
| 主根、低垂树根 | Capsule 或 BoxCollider | 只给真正封路的主干加 |
| 荧光藻、根节点、感应点 | Trigger Collider | 视觉网格与交互范围分离 |
| S4/S5 菌丝门 | 独立 Blocker Collider | 动画缺口大于玩家胶囊后再关闭 |
| 湿面、裂缝、菌丝脉络 | 无 Collider | 用材质、贴花或薄面表现 |

### 7.3 走线验收

- 主实验台四周最窄处不少于 1.2 m，推荐 1.5 m。
- S2、S3、S7、S8、S9 每个交互站位前保留半径 0.8 m 的空区。
- 四个 Dev Play Checkpoint 周围保留半径 1.2 m 的无 prop 落地区。
- 门开启动画播放中，玩家不能被移动门板或菌丝 Collider 推入墙体。
- 每轮布景后用玩家胶囊完整走一遍，不能只用 Scene View 俯视判断。

## 8. 灯光设计

### 8.1 总体结构

灯光分四层：

1. 现有冷绿无阴影 Point Light 只托暗部。
2. `006b2dc` 的去饱和青绿色破顶光构成中央主光轴。
3. 生物发光和终端状态灯提供局部冷青、黄绿、橙红色点。
4. 手电是廊道和暗角的玩家主导光源。

曝光保持固定或受控，不使用会因看向荧光物而剧烈跳变的自动曝光。Bloom 只让高亮边缘有轻微扩散，不做赛博霓虹。
当前实现严格恢复 `006b2dc` 的 Fixed Exposure EV 4.5。主破顶 Spot 为 1100 lm，西侧次光为 700 lm；两束灯使用该提交
原有的较宽角、无阴影艺术定向配置，加强 Briggs 本地 PSX、Bloom 和绿色体积雾下的多束轮廓。

### 8.2 破顶与顶部光

推荐两束受控 Spot Light：

- 主破口的平面中心约为 `X -0.28, Z -0.38`，主光束从该中心上方入射，斜擦中央桌北半和台面玻璃。
- 西侧破口的平面中心约为 `X -5.75, Z 2.05`，次光束从该中心上方照到破损培养区和残留低矮植物。

主灯恢复为 `(0.1, 4.18, 2.5)`、旋转 `(70, 180, 0)`、28 度外角、12 度内角、体积参与度 3.2；西侧灯恢复为
`(-5.35, 4.18, 3.75)`、旋转 `(74, 165, 0)`、24 度外角、10 度内角、体积参与度 2.2。两者 Range 均为 9 m，
不投射实时阴影。这些数值属于 `006b2dc` 的历史构图基线，不再根据后续 props 重新估算。

布置顺序：

1. 先锁中央桌和破顶位置。
2. 再调整主光束方向，让最亮区域落在台面边缘而不是整块地板。
3. 放根系、吊线和 Ivy 形成前景遮挡。
4. 最后微调 Fill Light，不用 Fill 修复错误的主光构图。

### 8.3 分区光

- S2：低强度短范围冷青辅助 Point Light，只照出藻类和近墙轮廓。
- S3：实验完成粒子短时提亮。完成后主要由玩家手电照明，不常亮整个廊道。
- S7：黄绿色根须内部发光加极弱反射光，不能把整区染成荧光绿。
- S9：保持较暗，使用旧终端屏幕和纸张反光形成可读焦点。
- 玻璃和湿地面：用 Baked Reflection Probe、天空反射和 roughness mask。项目 HDRP 资产关闭 SSR，不为本关单独开启。
  只让局部积水反射，不把全场做成镜面。

当前建议检查廊道和主实验台两个 Reflection Probe 区域。正式出口模型替换程序化门叶后，再单独决定是否需要第三个 Probe。
若使用 APV，props 稳定后再烘焙。

## 9. 发光、VFX 与 Shader 工作项

### 9.1 策划明确要求的效果

| 节点 | 必须表现 | 推荐实现 |
|---|---|---|
| S0 | 门外少量橙红孢子浮尘 | 低密度 Particle System，复用 contamination 粒子材质做变体 |
| S2 | 青蓝自发光、漂浮孢子、触碰增亮、采样吸入 | Emissive Shader Graph + 小粒子 + 采样吸入粒子 |
| S3 | 实验完成柔光粒子、冷蓝手电、光内菌丝轻微移动 | 粒子 + Spot Light + 菌丝参数响应 |
| S4/S5 | 三根节点 2 至 3 秒脉动、焰苔橙红 VFX、局部收缩、门开启 | 共享材质变体 + 粒子 + Animator/BlendShape |
| S6 | 地下微弱菌丝脉络、间歇低频脉动、极轻微画面震动 | Emissive Decal/贴地网格 + 波前参数 + Cinemachine Impulse |
| S7 | 半透明灰白根须和淡黄绿内部汁液流动 | 双层材质或透明外壳 + 内层滚动 UV |

S10、S11、S12 的剧情出口表现当前暂停。现有自动门只保证空间和通行验证，正式模型进入 Unity 前不为这些节点追加临时菌丝膜、专属灯光或 Shader。

### 9.2 需要新写的 Shader

当前项目没有可直接承担菌丝和荧光藻的环境 Shader。建议新增：

- `Assets/RootsDance/Shaders/Environment/BioluminescentAlgae.shadergraph`
  - HDRP Lit 或 Unlit Graph。
  - Emission Mask、慢速噪声、2 至 3 秒脉动、交互增亮参数。
  - 薄片边缘用 Alpha Clip，不使用大面积透明排序。
- `Assets/RootsDance/Shaders/Environment/HyphaePulse.shadergraph`
  - 冷青脉络、独立脉动相位、已安抚强度、局部 dissolve。
  - 节点按状态切换共享 Material Variant，不使用 `MaterialPropertyBlock`。
- `Assets/RootsDance/Shaders/Environment/HyphaeGroundFlow.shadergraph`
  - 用于贴地网格或 Decal 的方向流动和波前点亮。
- `Assets/RootsDance/Shaders/Environment/RootSapFlow.shadergraph`
  - 外壳保持灰白半透明，内层用滚动 UV 和克制的黄绿 emission。

若采用第四轮 `Jelly_Mushroom`，优先让它复用 `BioluminescentAlgae.shadergraph` 的基础脉动与 emission 逻辑，或从该 Graph 派生一个
`BioluminescentSpecimen.shadergraph`。后者只在确实需要菌盖上下表面分色、对象空间高度遮罩和垂须边缘光时创建。建议暴露
`BaseTint`、`EmissionTint`、`EmissionStrength`、`PulseSpeed`、`PulseOffset`、`EdgePower` 和 `InteractionBoost`，不要把纹理依赖写死。

S4/S5 菌丝门的真实几何收缩不要只靠 Shader。门框菌丝使用 Animator、BlendShape 或分段网格移动，Shader 负责发光、
边缘溶解和状态过渡。这样 Collider 可以在可通行时刻与动画同步关闭。

湿地面不必新写完整 Shader。优先用 HDRP Lit 的 smoothness/roughness mask、Decal 和局部薄面完成。

### 9.3 P1 效果

策划明确列为有时间再做：

- 菌丝脉动频率随玩家靠近而增强。
- 手电光与菌丝材质实时联动。
- 样本投放的细化动画。
- 地下脉动触发极轻微屏幕抖动。

这四项不能阻塞 P0 流程。P0 先保证 S4/S5 根节点发光状态、三点判定、屏障 Collider 和门动画正确。

## 10. 玩家路线与视线引导

推荐必经路线：

当前实现路线：

`S0 南门 → S1 黑暗廊道 → S2 左墙荧光藻 → S3 右墙装配台 → 廊道手记 → S4/S5 菌丝门 → S6 主室入口 → S7 东侧根须台 → S8 中央实验台 → S9 西侧档案`

S9 之后的北墙圆形出口已经可以通行，但当前布景和验收不覆盖 S10、S11、S12 的剧情解锁逻辑。

主实验室采用顺时针环线：

1. S6 入室时，中央桌遮住西侧档案区，东侧变异根须处于高对比亮区，先把玩家拉向 S7。
2. S7 完成后沿中央桌东侧进入 S8，桌上两组器材形成第二视觉层级。
3. 完成 S8 后绕桌北侧或南侧到西边 S9，纸张、旧终端和手电可发现的夹层形成第三焦点。
4. 北墙正中心保留自动圆门的空间与触发净空，但不通过额外灯光把它提前做成当前导航目标。
5. S9-02 隐藏残页保持可选。

不要用地面箭头或现代发光导视。路线依靠大体块、光暗、色彩和遮挡建立。

## 11. 玩家出生与 Dev Play Checkpoint

策划案和俯视图没有定义运行时 Checkpoint。当前工程已有 4 个 Briggs Dev Play Checkpoint 资产，因此按现有工具语义将其
重新映射到当前 18 × 14 m 布局。它们用于编辑器快速测试，不等同于正式存档系统。

| 资产 | 场景锚点 | Position | Yaw | 对应位置 |
|---|---|---:|---:|---|
| `02-01_LaboratoryEntrance.asset` | `Checkpoint_LaboratoryEntrance` | `(3, 1, -22.5)` | `0` | S1 廊道入口 |
| `02-01_PlantResearchLab.asset` | `Checkpoint_PlantResearchLab` | `(3, 1, -5.5)` | `0` | S6 主实验室入口内侧 |
| `02-02_SampleStorage.asset` | `Checkpoint_SampleStorage` | `(-4.1, 1, -0.7)` | `90` | S9 西侧档案区外缘 |
| `02-03_Greenhouse.asset` | `Checkpoint_Greenhouse` | `(6.8, 1, -3.2)` | `180` | S7 东侧根须区外缘 |

接线要求：

- `_Anchors` 下必须存在四个同名 Transform。
- 每个资产的 fallback Position 和 Yaw 必须与对应锚点一致，锚点丢失时也不能回退到旧 GAIA 地图坐标。
- 场景 `Player`、`PlayerSpawn` 和入口锚点在普通 Play 时保持一致。
- Cinemachine `FirstPersonCamera.Follow` 与 `LookAt` 保持连接到 `Player/Head`。
- Checkpoint 周围 1.2 m 半径不得用 PWB 放置 props。
- 两块地面 Collider 必须使用 `Ground` layer，否则视觉上站在地面但 `FirstPersonController.IsGrounded` 会失败。

正式存档 Checkpoint 若后续实现，至少要恢复：

- 两扇门和菌丝屏障状态。
- 第一扇门三个根节点状态。
- 荧光藻和焰苔的采集、培养、成熟与消耗状态。
- 生物手电制作与开关状态。
- S7、S8 实验、S9 笔记和官方报告状态。
- 已触发 HUD 与奖励，避免重生后重复发放。

## 12. 实施顺序

### P0 灰盒与接线

1. 锁定主室、廊道和南门尺寸，北墙正中心只保留圆门净空。
2. 修正 Ground layer、PlayerSpawn、玩家位置和四个 Dev Play anchors。
3. 创建根级 `Prefab World Builder`。
4. 用候选 CC0 counters 和 cabinets 做 LabFurniture prefab。
5. 摆中央桌、S7 操作台、档案桌和两组落地设备。
6. 加简化 Collider，完整走通 1.2 m 净宽环路。
7. 放置 S2、S3、S4/S5、S7、S8、S9 的交互站位和 Trigger。

### P0 美术与流程可读性

1. 先布破顶和主光轴，再放大体量根系。
2. 使用现有实验小件丰富三张工作台，控制密度。
3. 放 3 至 5 个生态入侵岛，中央通路保持清楚。
4. 完成 S2、S4/S5 根节点和地面菌丝的基础 emission。
5. 完成 S4/S5 菌丝屏障的 Collider 与动画同步。

### P1 气氛与精修

1. 导入复古管线和电气资产。
2. 加积水、滴水、局部 Decal、旧纸和破损细节。
3. 加 APV、Reflection Probe 和体积光验证。
4. 做手电与菌丝联动、地下波前、屏幕轻微震动。
5. 以正常入口和四个 Dev Play Checkpoint 分别跑一遍。

## 13. 待策划与美术确认

以下问题有直接冲突，实施时应使用语义 ID，不能把现有编号或字母当作稳定程序契约：

1. 旧手电来源：正文写在 S3 操作台，SVG 写进入 S0 前室外拾取。只能保留一个权威来源。
2. 样本名称：正文始终是 `BOT-AL-017 荧光藻`，SVG 多处写“发光菌丝”。建议以正文荧光藻为准。
3. 焰苔流程：当前 S5 消耗成熟焰苔，但 02 章没有明确的采集、培育和数量来源。出口未来是否继续消耗，等圆门流程接线时再定。
4. 样本数量：手电和第一扇门需要多次使用荧光藻和焰苔，尚未定义是否消耗、是否无限复用。出口需求暂不计入。
5. 廊道手记距离：正文的 15 m 与 16.8 m 总长冲突，建议按 1.5 m 理解，等待确认。
6. S4-01 与 S4-02：同一文档前后两版把手记和菌丝门编号对调。
7. A/B/C/D：SVG 字母是调查点，正文又把实验台命名为 A/B/C/D。程序对象必须用语义名。
8. 预处理间：正文称安全门后进入独立预处理间，SVG 是直接进入主实验室。
9. 出口流程：北墙圆门和自动滑门 Trigger 已实现；感应点、菌丝膜、正式门动画和剧情交互规则仍待后续决定。
10. 年代：SVG 写 1970s，美术方向写九十年代复古未来主义。建议解释为 1970s 设施加九十年代后装设备。
11. 仙女环披露尺度：开头写不揭示真相，S9-02 又直接确认仙女环本质。需明确真正保密的是不是“安全区就是仙女环”。
12. 顶光：策划只确认破顶和垂根，没有确认破口平面位置和太阳方向。本文位置是可实施美术建议。

## 14. 验收清单

- [x] 普通 Play 从廊道入口开始，玩家和相机位置正确。
- [x] 四个 Dev Play Checkpoint 都落在当前 Briggs 地图内，不使用旧 GAIA 坐标。
- [x] 两块行走地面使用 `Ground` layer，玩家胶囊恢复为合法站立尺寸。
- [x] 所有本轮 PWB props 都位于 `Prefab World Builder/<Palette>/PIN`。
- [x] `_Props` 下没有散落的 PWB 家具和实验小件。
- [ ] 主实验台四周最窄净宽不少于 1.2 m。
- [ ] S2 在拿到手电前是廊道最明确的视觉焦点。
- [ ] S6 进入后玩家首先被东侧 S7 引导，不会直接漏过实验冲向北墙。
- [ ] S8 两组工作面与 S9 档案区从道具摆放上可区分。
- [ ] S9-02 只有手电照射后可发现，并保持可选。
- [ ] S4/S5 菌丝屏障在动画形成真实通路后才关闭 Blocker Collider。
- [ ] 破顶位置、可见破口和光束入口一致。
- [x] 植物集中成生态入侵岛，没有均匀铺满。
- [x] 小件与软植物使用无碰撞 Prefab Variant，没有场景 Collider override。
- [x] 入口视角完成一次带 PSX 的 Game View 构图检查；S7 与 S9 仍需在交互接线后复查。
- [ ] Console 没有 `RootsDance.*` error 或 warning，退出 Play 后场景不脏。
