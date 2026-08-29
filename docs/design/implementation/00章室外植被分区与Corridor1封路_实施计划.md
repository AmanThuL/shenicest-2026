# 00章室外植被分区与 Corridor 1 封路实施计划

> 设计依据: [00章室外环境设计](../00章室外环境设计_起始点至检修通道前.md)
> 执行基线: `origin/develop@b487619`，Unity `6000.3.22f1`
> 工作分支: `review/ch00-aerial-overview`
> 范围: A-E 可见区高密度植被、C 连续异色草毯、统一草高、A-E 后处理、E 区 Corridor 1 唯一路线、checkpoint 重绑与验证
> 性能策略: 本轮不以帧率、draw call、实例数或贴图内存作为减配理由。先满足体验和设计，再单独优化。

本文是本 session 的唯一执行清单。长期设计不记录临时 task 状态；旧实现记录不复用本轮勾选结果。

## 1. 当前问题与执行目标

### 1.1 已确认问题

- C 的前段 scatter 约 `420` 株，但仍使用 `0.75 m` 最小间距和路线清空；中后段填充使用 `3.25 m` 网格，所以俯视和第一人称都能看到大量裸地。
- 当前 `FillRegion` 直接随机 prefab scale，没有按 Renderer 世界高度统一。不同模型的原始单位和包围盒导致草高失控。
- A/B 由 opening builder、C-E 由 mid-late builder 分开生成，分区密度、路线 clearance 和材质策略不统一。
- 当前后处理只有 S0-S6 四个 opening Box Volume 加全局 `MainProfile`，不能完整表达 A-E。
- `Main_Environment` anchors、Terrain config、DevPlay defaults 与 DevPlay assets 已出现坐标漂移。
- 旧后段路线仍围绕 Greenhouse `Door12`，与“E 只允许到 Corridor 1”冲突。
- E 当前主要是稀疏地被和建筑裸底，没有足够的可见自然阻挡。

### 1.2 完成定义

- A-E 的所有 checkpoint 可见区都有符合分区语义的高密度覆盖。
- C 的可见 `GrassBand` 没有草簇间裸地洞，且至少四个色组在同一视野可读。
- 常规 C 草为 `0.25–0.55 m`，强调簇 `0.55–0.85 m`，英雄植株不超过 `1.0 m`。
- E 只有 Corridor 1 接近面可达，其他建筑脚部无法由 player capsule 到达。
- 从 00-08、D/E 交界和 Corridor 1 接近线持续看见玻璃圆顶上部。
- A 最浓雾，B/C/D 依次减弱，E 仍有明显体积雾。
- checkpoint 所有坐标真源一致，场景与 DevPlay 传送不再偏离。
- 所有可见 props 都在 `Prefab World Builder/<Palette>/PIN/`。

## 2. 资产选择

### 2.1 P0: 本轮采用

| 资产 | 来源与精确路径 | 本轮用途 | 处理 |
|---|---|---|---|
| Retro PSX grass | `/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/01_美术组点名/Itch/elegantcrow__retro-psx-nature-pack/extracted/Retro Nature Pack/retro_nature_pack/models/FBX/grass/` | C 连续底层和边缘咬合 | 导入 `grass01..09`、`grass_bush`、`grass_patch`、`grass_patch_corner`；CC0；项目 TVE 材质 |
| Retro normal bushes/trees | 同包 `bushes/` 与 `trees/` | B 混生、D 普通生态、E 树屏障 | 导入普通版本，不只用现有 winter 子集 |
| Niwl extended plants | `/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/01_美术组点名/Itch/niwl-games__plants/extracted/Standard/Standard/3D/FBX/` | C 物种与色彩、D/E 林下、E 树屏障 | 补 `M3D_meadown`、poppy、sunflower、alder、birch、pine、ivy 6/7/8；CC0；pure mesh + 项目材质 |
| PSX terrain rocks | `/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/02_风格补充/Itch/caliberuk__psx-large-terrain-rock-pack-2/extracted/PSX_Large_Terrain_Rock_Pack_2/PSX_Large_Terrain_Rock_Pack_2/RP2/FBX_Exports/` | B-D 边界、E 实体自然封路 | 采用 2 m、4 m、8 m 三档；自定义许可允许项目使用和修改，禁止重分发原资产 |
| Trees PSX | `/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/01_美术组点名/Itch/elbolilloduro__trees-psx/extracted/Trees/Trees.fbx` | E 高树框景和树墙 | 拆出子 mesh prefab；CC0；树冠避开圆顶视锥 |
| Garage Ivy Hanging | `SourceArt/Blender/Garage/Assets/Ivy_Hanging.blend` | E 外墙、圆顶边缘、Corridor 1 垂挂层 | 复用已有 `Assets/RootsDance/Meshes/Environment/Garage/IvyHanging.fbx`；制作 prefab 和 tint variants；无碰撞 |
| Garage Rubble/Pipes | `SourceArt/Blender/Garage/Assets/Rubble.blend`、`Pipes.blend` | E 植物后方封路与人工方向证据 | 导出、统一材质、简化碰撞；不成为视觉主角 |

### 2.2 P1: 近景补层

- Poly Haven `grass_bermuda_01`、`grass_medium_01`、`fern_02`、`nettle_plant`、`periwinkle_plant`、`shrub_sorrel_01`、`weed_plant_02`、`moss_01`。
- 只用于玩家脚边、环界、根石接缝和 Corridor 1 近景。贴图降到项目规范，统一 tint 和 Shader，不做全区同权重散布。
- 现有 `pine_roots`、`root_cluster_01/02`、`single_root`、dead trunk、dry branches 和 moss rock prefabs 继续作为少量英雄阻挡。

### 2.3 P2: 可选英雄资产

- 第四轮 `Jelly_Mushroom`:
  `/Users/rudyz/Documents/projects/She Nicest 2026 Beijing/美术候选素材库/01_美术组点名/Sketchfab/Individual/Jelly_Mushroom_86d6b638/Jelly_Mushroom_86d6b638_source.zip`
- CC BY 4.0，原始约 `335,477` 面。只有在完成拆分、减面和署名记录后，才在 C 区路线外放 `3–7` 组。
- 不作为密铺资产，不阻塞本轮完成。

### 2.4 本轮不用

- `SourceArt/Blender/蘑菇簇` 在来源和许可补齐前不导入，即使只用 pure mesh 也不例外。
- `Cave`、`Stones With Vines`、作者关闭下载的 `Decay Trees/Spike Rocks/Plant growth under abandoned Bridge` 不采用。
- 付费未授权的 `Plants 3D`、`Grasses 3D` 不纳入。
- Boss mesh、车辆、宗教雕塑和完整 Garage shell 不挪作普通环境资产。

## 3. 代码和内容所有权方案

### 3.1 新增或重构的核心文件

- `Assets/RootsDance/Scripts/Editor/Environment/Chapter00ZoneVegetationParams.cs`
- `Assets/RootsDance/Scripts/Editor/Environment/Chapter00ZoneVegetationLayout.cs`
- `Assets/RootsDance/Scripts/Editor/Environment/Chapter00ZoneVegetationBuilder.cs`
- `Assets/RootsDance/Scripts/Editor/Environment/Chapter00ZoneAtmosphereBuilder.cs`
- `Assets/RootsDance/Scripts/Editor/Environment/EnvironmentPrefabTable.cs`
- `Assets/RootsDance/Scripts/Editor/Environment/EnvironmentPalette.cs`
- `Assets/RootsDance/Scripts/Editor/Terrain/TerrainGreyboxParams.cs`
- `Assets/RootsDance/Scripts/Editor/Terrain/TerrainGreyboxConfigSO.cs`
- `Assets/RootsDance/Scripts/Editor/DevPlay/DevCheckpointDefaults.cs`
- 对应 EditMode/PlayMode 测试和 capture/audit 工具

### 3.2 生成所有权

新 builder 使用稳定前缀 `C00V_`，只拥有:

```text
Prefab World Builder
├── ZoneA_DeadGrowth/PIN
├── ZoneB_Transition/PIN
├── ZoneC_AnomalousCarpet/PIN
├── ZoneD_StableEcology/PIN
├── ZoneE_Corridor1Ecology/PIN
└── ZoneE_NaturalBlockers/PIN
```

旧 `OpeningPropsBuilder` 继续拥有围栏、营地证据和英雄 props；`Chapter00ExteriorBuilder` 继续拥有正门、标牌、藤本和入口交互。它们的通用 vegetation scatter 在迁移后停止生成，避免与 `C00V_` 双铺。

## 4. 执行任务

### P0: 文档与空间真源

- [x] `DOC-01` 建立唯一长期设计真源。
- [x] `DOC-02` 将旧设计和已完成记录移入 archive。
- [x] `AUDIT-01` 核对 player 高度: `CharacterController.height = 1.8 m`。
- [x] `AUDIT-02` 核对当前设施 bounds 和 Corridor 1 bounds。
- [x] `SPACE-01` 以 Corridor 1 为终点完成 00-08..00-16 全尺寸 capsule 路线审计。
- [x] `SPACE-02` 锁定各 checkpoint 最终 X/Y/Z、yaw、观察锥和 capsule clearance。
- [x] `SPACE-03` 同步 Terrain config、Terrain params、scene anchors、DevCheckpointDefaults 和所有 `00-*.asset`。
- [x] `SPACE-04` 删除旧 Greenhouse Door12 service landing 和不再使用的支路/flat spot。
- [x] `SPACE-05` 验证设施内部建筑相对 Transform 未改变；设施组没有被拆分或重排。

### P1: 资产导入与 prefab 化

- [x] `ASSET-01` 导入 Retro grass patch/corner、普通 bushes/trees，保留许可证记录。
- [x] `ASSET-02` 导入 Niwl meadow、花、树和补充 Ivy。
- [ ] `ASSET-03` 导入 PSX 2/4/8 m rocks，按尺度和碰撞类型拆 prefab。
- [ ] `ASSET-04` 拆 Trees PSX 合并 FBX 为独立树 prefab。
- [ ] `ASSET-05` 为现有 IvyHanging mesh 创建无碰撞 prefab 和共享 tint variants。
- [ ] `ASSET-06` 通过 Blender 导出 profile 导出 Garage Rubble/Pipes，创建项目材质和简化碰撞。
- [x] `ASSET-07` 在 `docs/third-party.md` 更新所有新增资产来源、许可和派生说明。
- [ ] `ASSET-08` 为每个 prefab 输出 renderer bounds、三角面数量、原始高度和最终目标类别审计。

### P2: 高度归一化与散布系统

- [x] `VEG-01` 定义 A-E zone data、asset pool、目标高度、色组、碰撞角色、route policy 和 seed。
- [x] `VEG-02` 使用 Renderer world bounds 计算目标高度 scale，替换盲目 prefab scale 随机。
- [x] `VEG-03` 区分 `WalkThroughGroundCover`、`MidLayer`、`PhysicalBlocker` 三类实例。
- [x] `VEG-04` 建立 checkpoint clearance、camera/dome view cone 和 route corridor masks。
- [x] `VEG-05` 建立 checkpoint 与路线视野并集的玩家可见包络。
- [x] `VEG-06` builder 幂等重建 `C00V_`；实例保存为六个 PWB palette prefab，主场景保持 3.6 MB。

### P3: C 异色草带

- [x] `C-01` 保持现有 C Terrain 分界与 GrassBand 底色。
- [x] `C-02` 第一层按 footprint 重叠 `38%` 铺满可见区。
- [x] `C-03` 路线中心铺 `0.25–0.55 m` 无碰撞低草，不再清空裸路。
- [x] `C-04` 第二层使用 `0.55–0.85 m` meadow、蕨、低灌、低花和 Ivy。
- [x] `C-05` 路线两侧与环界加入低量实体根石，常规植被不超过设计高度。
- [x] `C-06` 建立五组共享材质与 `4 m` 色簇，校准到约 `30/25/18/15/12`。
- [x] `C-07` 合成可见包络 coverage 测试通过，最终 C 为 `4,348 + 678 + 37 = 5,063` 个实例。
- [x] `C-08` 已生成第一人称 C/D 过渡与统一俯视评审截图。

### P4: A、B、D 覆盖

- [x] `ABD-01` A 使用 winter trees/bushes、干草、倒木和根石覆盖可见空地。
- [x] `ABD-02` B 混合 winter/normal 植被，沿主路线连续提高健康比例。
- [x] `ABD-03` D 使用普通低草、蕨、灌木和苔石，色彩低于 C。
- [x] `ABD-04` 正确路线由低层植被延续，错误方向由实体自然物收束。

### P5: E 与 Corridor 1

- [x] `E-01` 以 `LabCorridor1` bounds 与 checkpoint route 建立唯一可达接近走廊。
- [x] `E-02` 通道内铺 `0.15–0.35 m` 普通草和低蕨，不画裸路。
- [x] `E-03` 其他建筑脚部由高树和加密至 `1.25 m` pitch 的低根石层封闭。
- [x] `E-04` 前层使用灌木/蕨/Ivy，后层使用带碰撞树干、已有根石和苔岩。
- [x] `E-05` 无 invisible wall；0.5 m flood-fill 没有非策划路线漏区。
- [x] `E-06` 从设施最高 renderer bounds 建立圆顶目标和三条视锥。
- [x] `E-07` Tall trees 避让视锥，`1.0–1.8 m` 低根石遮底并保留上部视线。
- [x] `E-08` 00-09..00-16 道具、线索和入口状态已重接到 Corridor 1 路线。

### P6: A-E 后处理

- [x] `POST-01` A-E Mean Free Path 为 `9/13.5/19/25.5/33 m`。
- [x] `POST-02` A 为 global，B/C/D 为 nested sphere，E 为设施台地 box。
- [x] `POST-03` blend 为 `8/8/8/8/10 m`，priority 为 `6..10`。
- [x] `POST-04` 保持统一 exposure、PSX 和时间系统；区域 profile 只包含 Fog 与 Color Adjustments。
- [x] `POST-05` E 保持明显雾，固定截图中 Corridor 1 与圆顶轮廓可读。

### P7: 验证与交付

- [x] `TEST-01` 相关 EditMode 14/14 通过: zone、height、coverage、route、PWB、atmosphere。
- [x] `TEST-02` 0.5 m full capsule flood-fill: Corridor 1 可达，非路线漏区 `0`。
- [x] `TEST-03` scene/config/default/assets 坐标一致；Gaia 相对布局锁定验证通过。
- [ ] `TEST-04` PlayMode: 1.8 m player 从 00-01 走到 00-16，所有 checkpoint 与交互可完成。
- [ ] `TEST-05` 第一人称人工走测 A、B、C、D、E 的路线引导、草高、视野和碰撞。
- [x] `TEST-06` 生成统一俯视图和固定 C、圆顶、Corridor 1 评审截图。
- [ ] `TEST-07` Unity console 无新增 Error，EditMode/PlayMode 全量测试通过。
- [x] `DOC-03` 回填本文证据表，更新长期设计中因实测变化的参数。
- [ ] `GIT-01` 只提交本轮文件，不夹带 Unity 首次导入产生的无关材质改写。
- [ ] `GIT-02` 合并前同步最新 `origin/develop`，解决冲突并完成交付必需检查；按用户要求不重跑完整 Unity 验证。

## 5. 自动验证设计

### 5.1 C coverage

- 在玩家可见 GrassBand 包络内建立 `0.5 m` 采样格。
- 每个有效采样点必须命中 C Terrain layer，并被至少一个 ground-cover footprint 覆盖。
- checkpoint 站位允许 ground-cover，但禁止 physical blocker。
- 报告 uncovered 点比例、最大连续裸地区域和各色组权重。目标是可见裸洞为零；Terrain 底色只作为 alpha 缝隙保险，不代替几何覆盖。

### 5.2 E reachability

- 以 player radius `0.5 m`、height `1.8 m` 做 XZ navigation flood-fill 或等价 capsule sweep。
- 起点从 D/E 接缝进入，只允许连通 Corridor 1 接近面和本章 checkpoint。
- Greenhouse、Plant Research Lab、Corridor 2 的建筑脚部采样点必须不可达。
- 不可达必须由可见 blocker collider 或地形解释，不能只由测试 mask 判定。

### 5.3 圆顶视锥

- 从 `00-08`、D/E 交界和 Corridor 1 中段各取约 `1.7 m` eye position。
- 目标由温室玻璃 renderer 的上部 bounds 自动得到。
- tall blocker 不得覆盖目标 silhouette 的关键采样线；低灌木可遮下部建筑。

## 6. 固定评审画面

1. `00-01` A 区苏醒: 浓雾、死亡植被、唯一出口。
2. `00-04` A/B 土脊: 第一次看见 C 冷色带。
3. `00-06` C 入口: 地表无裸洞，色彩簇与物种变化明确。
4. `00-07` C 调查: 草高不遮工具与调查物。
5. `00-08` E 早段设施揭示: 圆顶上部清楚，建筑底部被植被遮挡。
6. D/E 交界: 正确方向是 Corridor 1，其他建筑方向先读成树林和根石墙。
7. E Corridor 1 接近: 低草路线、两侧自然阻挡、圆顶持续可见。
8. 统一俯视图: A-E 分界、C 覆盖、E 唯一通道和自然封路关系可读。

## 7. 证据回填

| 项目 | 完成后记录 |
|---|---|
| 最终设施 root 与各建筑相对 Transform | root `(0.928,5.596,61.911)`，yaw `335.525°`；relative layout locked |
| `00-08..00-16` 最终坐标 | 见长期设计 §3.2；00-15/16 固定 `(37,7.8,106)` |
| C 可见包络、实例数和 coverage | ground `4,348`、mid `678`、physical `37`；38% footprint overlap，合成 coverage 通过 |
| A/B/D/E 各类实例数 | A `4,360/483/101`；B `5,701/503/209`；D `6,674/754/333`；E `15,930/2,611/3,675` |
| 草高 bounds 审计 | builder 对全部 `46,397` 个实例按 role/zone 范围验证通过 |
| Corridor 1 reachability 与其他建筑不可达证据 | full capsule C-E collision `none`；E flood target reached；unexpected cells `0` |
| A-E Volume 实际参数 | MFP `9/13.5/19/25.5/33m`；blend `8/8/8/8/10m`；priority `6..10` |
| EditMode/PlayMode 结果 | 最终相关 EditMode `14/14`；按用户要求缩减验证，未跑最终全量 PlayMode |
| 评审截图路径 | `Logs/Captures/Chapter00RingOverview/` 下 topdown、C、dome、Corridor1 五图 |
| 实现 commit 与 remote develop | 合并推送后回填 |

### 未采用资产说明

- PSX Large Terrain Rock Pack 许可允许项目使用，但禁止重分发原始或修改 mesh，因此没有导入仓库。
- Trees PSX、IvyHanging、Garage Rubble/Pipes 并非完成本轮体验所必需，未为凑资产数量而重复导入；E 使用 Retro/Niwl trees 与现有根石完成封路。
- Retro PSX Nature 下载页仍缺少明确许可证文本，`docs/third-party.md` 保留发布前复核提醒。
