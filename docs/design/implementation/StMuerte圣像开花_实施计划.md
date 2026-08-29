# StMuerte 圣像开花实施计划

> 集成基线: `develop@7e8b6f4a`，Unity `6000.3.22f1`，HDRP `17.3`
> 工作分支: `feat/statue-bloom`
> 范围: `Main_Environment_Statue` 中 StMuerte 圣像表面的植被覆盖与生长演出
> 相关资产: `Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/StMuerte.fbx`、`Assets/RootsDance/Data/Audio/MUS_EndingBloom.asset`

本文是本轮的执行清单。长期设计不记录临时 task 状态。

## 1. 圣像现状实测

数据由 headless Blender 读取 `SourceArt/Blender/GAIA1/GAIA1_v8.blend` 得到，与已导出的 FBX 对应。

| 项 | 值 |
|---|---|
| 部件 | `Robe`、`Skull`、`SpineAndChest`、`CollarBone`、`Left/RightHand_hand_anim`、`Left/RightHand_bone_anim` |
| 几何 | `48,320` verts / `85,963` tris，其中 `Robe` 占 `37,541` verts（78%） |
| Unity 尺寸 | `6.39 × 6.09 × 18.83 m`，导入 scale `0.6045` |
| 表面积 | `343.2 m²`，其中 `Robe` `301.1 m²`（88%） |
| UV | 每部件一套 `UVMap`，全部落在 0–1 内，**无重叠**（`Robe` UV 三角面积和 `0.682`，`Skull` `0.513`） |
| 缺失通道 | 无 vertex color、无 UV2、无 shape key，`importBlendShapes: 0` |
| 材质 | 内嵌在 FBX（`materialLocation: 1`），项目内没有独立 `.mat` |
| 手部骨骼 | `Left/RightHand_*` 带 Armature modifier，但按 `static_prop.json` 导出（`bake_anim: false`），Unity 侧是纯静态网格 |

两条结论直接决定方案：

- **UV 干净且不重叠**，所以可以在 Blender 里把任意逐点数据（生长顺序、遮罩、AO）烘成贴图，Unity 侧只用一个标量就能读，不需要改造圣像本体的顶点数据。
- **`Robe` 独占 88% 表面积**，覆盖工作的绝大部分集中在一个部件上，其余部件按点缀处理即可。

## 2. 动画归属决策: Blender 出资产，Unity 出演出

结论: **生长的时间演出由 Unity 驱动，Blender 只负责可导出的静态资产与烘焙数据。**

### 2.1 Blender 侧动画为什么不可行

- FBX 只能携带骨骼动画与 blendshape 动画，**携带不了拓扑变化**。几何节点或粒子系统的"长出来"在导出时只剩下某一帧的结果。
- 唯一能带出拓扑变化的通路是 Alembic 顶点缓存。`com.unity.formats.alembic` 未安装；即使安装，`48,320` 顶点 × 250 帧的缓存体积与运行时解码开销在本项目的交付窗口内不可接受。
- 更关键的是可控性: 开花是结局演出（`MUS_EndingBloom` 已存在），需要随剧情进度推进、可暂停、可回退、可由 checkpoint 恢复到中间状态。烘死的动画片段做不到其中任何一条。

### 2.2 各自承担的部分

| 环节 | 归属 | 产出 |
|---|---|---|
| 花簇 patch 几何、贴合圣像曲面 | Blender | 静态 FBX |
| 顶点色生长序（种子点向外的归一化距离） | Blender | 写在 patch 顶点色 B 通道 |
| 单朵花的绽放姿态 | Blender | shape key 或 2–3 根骨骼的短 clip |
| 生长进度、揭示顺序、与剧情/音频的对齐 | Unity | shader 标量 `_Growth` + 驱动组件 |
| 逐朵花的绽放触发与错峰 | Unity | 按生长序推进的组件 |

## 3. 分层方案

三层可独立交付，按此顺序做，任何一层单独完成都能进游戏。

### 3.1 L1 基底蔓延（必做）

圣像石面本身泛出苔痕与湿色，作为其余两层的底。

- Blender 侧烘一张 `StMuerte_Robe_Growth` 贴图: R 通道存该 texel 的生长时刻（0–1，从底座向上、从手掌向外的测地距离归一化），G 通道存一张打散用的噪声。
- Unity 侧一个 Shader Graph 材质，把 `_Growth` 与 R 通道比较做溶解，softness 控制推进锋面宽度。
- 依赖: 圣像材质需要从 FBX 内嵌切成 External，见 §6.2。

### 3.2 L2 贴面花簇 patch（主体）

与已上线的 `BOT-AL-017 荧光藻` 完全同构，复用其全部管线。

`Assets/RootsDance/Shaders/Environment/BioluminescentAlgae.shader:59` 已有 `_Growth(0,1)` 与 `_GrowthSoftness`，按顶点色 B 通道的种子距离做扩散揭示。这就是"长满"的核心机制，已验证上线。`Tools/pipeline/build_algae_patch.py` 生成配套的 patch mesh，顶点色约定为 `(R rim falloff, G per-patch phase, B growth order)`。

本轮的改动只有两处:

1. **patch 要贴曲面**。现生成器在 XY 平面切轮廓、Z 只叠了 `±0.011 m` 的噪声起伏，是给平墙用的。需要在 `bm.to_mesh` 之前增加一步 shrinkwrap 到目标表面，并按命中点的法线重建顶点法线。
2. **shader 要被 HDRP 照亮**。藻类是自发光薄膜，走的是 Unlit ForwardOnly；花不自发光，必须走 Lit。这一层用 Shader Graph 实现（`Lit` + `Alpha Clip` + 顶点色输入），不复制手写 pass，理由见 §6.3。

### 3.3 L3 焦点真几何花（点缀）

`20–60` 朵真几何的花，只放在近看得到的位置: 双掌、肩、颅顶、底座周围 `5 m` 以内。玩家站在 `18.83 m` 高的圣像脚下，`5 m` 以上只有轮廓可读，全部交给 L2。

- 花的 mesh 取自 `Assets/ThirdParty/Environment/NiwlPlants/Models/Flowers/`（`M3D_poppy-1`、`M3D_poppy2`、`M3D_sunflower`，CC0）与 `Ivy/`（7 个）。
- 绽放用 scale + shape key，由一个按生长序推进的组件逐朵触发，错峰参数来自 patch 顶点色 G 通道的同一套 phase。

## 4. 新增文件清单

### 4.1 Blender / 管线

| 文件 | 职责 |
|---|---|
| `Tools/pipeline/build_bloom_patch.py` | 由 `build_algae_patch.py` 派生: 平面切轮廓 → shrinkwrap 到圣像表面 → 写顶点色 → 导出 |
| `Tools/pipeline/bake_statue_growth.py` | 把测地生长距离烘进 `StMuerte_Robe_Growth` 贴图的 R 通道 |
| `SourceArt/Blender/StatueBloom/BloomPatch.blend` | patch 源文件，与 `AlgaePatch` 并列 |
| `SourceArt/Export/GAIA1/BloomPatch.export.json` | 导出溯源 sidecar |

### 4.2 Unity

| 文件 | 职责 |
|---|---|
| `Assets/RootsDance/Shaders/Environment/StatueBloom.shadergraph` | L2 花簇的 Lit + Alpha Clip + 顶点色生长揭示 |
| `Assets/RootsDance/Scripts/Runtime/Environment/GrowthDriver.cs` | 推进 `_Growth`，写 `renderer.material`（与 `EmissivePulse` 同一批处策略） |
| `Assets/RootsDance/Scripts/Runtime/Environment/BloomBurst.cs` | L3 逐朵花按生长序触发绽放 |
| `Assets/RootsDance/Scripts/Editor/Tools/StatueBloomBuilder.cs` | 材质 / prefab / 场景放置，范式取自 `CorridorAlgaeBuilder` |
| `Assets/RootsDance/Tests/EditMode/Environment/GrowthDriverTests.cs` | 进度映射与边界值 |

### 4.3 修改的既有文件

- `Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/StMuerte.fbx.meta`: `materialLocation` 切 External，仅 L1 需要。
- `Assets/RootsDance/Scenes/Levels/Main/Main_Environment_Statue.unity`: 由 builder 写入，不手改 YAML。

## 5. 执行顺序

- [x] 1. `build_bloom_patch.py`: 贴合改用 BVH 投射 + barycentric 插值法线；球面靶子实测 clearance 恒为 `3.99 mm`（即 `lift`），法线与径向 `dot = 1.00000`
- [x] 2. `Robe` 靶子: `119` 个 clump 全部通过内建审计，无穿模、无桥接；撕裂逻辑把最大边拉伸从 `39.7×` 降到阈值 `2.5×`
- [x] 3. 导出 `BloomPatches.fbx`: `colors_type LINEAR`；round-trip 顶点色 `rms = 0.000000`，Unity 侧 B 通道四分位数与源一致（`0.125 / 0.039 / 0.255`）
- [x] 4. `StatueBloom.shader` + `StatueBloom.hlsl`: 手写 unlit，非 Shader Graph，理由见 §6.3；编译零错误零警告，2 个 pass
- [x] 5. `GrowthDriver.cs` + `GrowthDriverTests.cs`: 9 项 EditMode 测试全绿
- [x] 6. `StatueBloomBuilder.cs`: 材质、prefab、场景放置；**尚未运行**，运行会打开并保存 `Main_Environment_Statue`
- [ ] 7. L1 生长贴图与基底材质
- [ ] 8. L3 焦点花与 `BloomBurst.cs`
- [ ] 9. `SunBroadcaster`: 把场景 Sun 写进 `_RootsSun*`，当前由 shader 内的固定主光兜底
- [ ] 10. 与 `MUS_EndingBloom` 对齐时长，接入 `CueSequence`

## 6. 风险与已知约束

### 6.1 CueSequence 驱动不了连续参数

`RootsDance.Sequencing.CueStepKind` 只有 `Wait / RaiseFlag / SetActive / PlayAudio / PlayDialogue`。开花是一条连续曲线，不能由 cue step 直接表达。方案: `GrowthDriver` 作为组件挂在圣像上，由 `SetActive` 启动，自己按 `Awaitable` 推进时间。不为此扩展 `CueStepKind`。

### 6.2 圣像材质内嵌在 FBX

`materialLocation: 1` 意味着材质由 importer 生成，改不了。L1 需要先切成 External 提取出 `.mat`。该改动会动 `.fbx.meta`，属于可控范围，单独一个 commit。L2 与 L3 不受影响，因为它们是独立的 patch 与 prefab，不碰圣像本体。

### 6.3 花的 shader 走 unlit，不走 Lit

原计划是 Shader Graph 做 Lit。落地时两条路都不成立:

- HDRP 的 `Lit.shader` 是 `1534` 行、`20` 个 pass，手写一份自定义 Lit 不是可维护的东西。
- `.shadergraph` 是 GUID 互链的多段 JSON（`BossPulse.shadergraph` 为 `64 KB`），无法在 Editor 外可靠生成，也无法在 diff 里评审。

实际实现是手写 unlit + 一盏主光和一个环境项，结构照 `Environment/FluorescentReveal`。**代价: 花簇不接收阴影，也不投射阴影**（没有 ShadowCaster pass，prefab 上 `shadowCastingMode = Off`）。生长揭示的数学与藻类一致。若后续要 Lit，用 Shader Graph 在 Editor 里重做一遍，顶点色约定和 `_Growth` 语义不变。

### 6.6 两个 unlit pass 都不带顶点色

`UnlitSharePass.hlsl` 与 `UnlitDepthPass.hlsl` 都不定义 `ATTRIBUTES_NEED_COLOR` / `VARYINGS_NEED_COLOR`。不自己定义的话 `input.color` 恒为 0，`clip` 裁掉全部片元，画面上什么都没有且**没有任何 shader 报错**。`StatueBloom.shader` 显式声明了这两个宏。

`Environment/BioluminescentAlgae` 目前没有声明它们，且把 `GetSurfaceAndBuiltinData` 放在 SubShader 级 `HLSLINCLUDE` 里（`SurfaceData` 要到 pass 内 include `Unlit.hlsl` 之后才存在），Console 里的 `unrecognized identifier 'SurfaceData'` 就是后者。两处都不在本轮范围内。

### 6.4 Timeline 包未安装

`Packages/manifest.json` 只有 `com.unity.modules.director`，没有 `com.unity.timeline`。若需要一条时间轴统一编排开花、运镜与音乐，那是一次 `chore(packages):` 的团队决定，不在本轮范围内。本轮用 `GrowthDriver` + `CueSequence` 覆盖。

### 6.5 圣像没有 UV2

`generateSecondaryUV: 0`，没有 lightmap UV。当前场景走实时光照（`TimeOfDayController`），不受影响。若后续改为烘焙 GI，圣像与所有 patch 都需要重新处理。

## 7. 验收标准

- 圣像从裸石到长满的完整过程可由单个 `0→1` 标量驱动，中途任意值都是一个自洽的画面。
- 生长有明确方向: 从底座与双掌起，向上、向外推进，不是整体淡入。
- 玩家站在圣像脚下平视与仰视，`5 m` 以内能看到立体的花，`5 m` 以上没有可辨认的贴片穿帮。
- patch 不穿模、不悬空，边缘与石面咬合。
- `MUS_EndingBloom` 的时长与生长曲线对齐，音乐结束时生长到 `1.0`。
- EditMode 套件全绿，`RootsDance.*` 无新增警告。
