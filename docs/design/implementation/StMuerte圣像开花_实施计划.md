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
| `Tools/pipeline/build_bloom_flowers.py` | L3 花田: 程序化生成花（茎/花瓣/花心/叶），散布到 `Robe`，把「合拢/半开/全开」三个姿态烘成顶点数据 |
| `Tools/blender/profiles/static_prop_vcol_smooth.json` | 与 `static_prop_vcol` 同，`mesh_smooth_type` 改 `EDGE`: 花瓣要平滑法线，`FACE` 会把顶点数翻三倍 |
| `SourceArt/Blender/StatueBloom/BloomFlowers.blend` | 花田源文件 |
| `SourceArt/Export/GAIA1/BloomFlowers.export.json` | 导出溯源 sidecar |
| `Tools/pipeline/bake_statue_growth.py` | 把测地生长距离烘进 `StMuerte_Robe_Growth` 贴图的 R 通道 |
| `SourceArt/Blender/StatueBloom/BloomPatch.blend` | patch 源文件，与 `AlgaePatch` 并列 |
| `SourceArt/Export/GAIA1/BloomPatch.export.json` | 导出溯源 sidecar |

重跑花田（Editor 可以开着，这一步只写 `SourceArt/` 与 `Assets/.../BloomFlowers.fbx`）:

```bash
/Applications/Blender.app/Contents/MacOS/Blender -b --python Tools/pipeline/build_bloom_flowers.py -- \
  --statue Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/StMuerte.fbx \
  --out SourceArt/Blender/StatueBloom/BloomFlowers.blend \
  --count 8400 --spread 0.155 \
  --seed-objects LeftHand_hand_anim,RightHand_hand_anim --strip

/Applications/Blender.app/Contents/MacOS/Blender -b SourceArt/Blender/StatueBloom/BloomFlowers.blend \
  --python Tools/blender/export_fbx.py -- --project-root "$PWD" \
  --output Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/BloomFlowers.fbx \
  --objects BloomFlowers \
  --profile Tools/blender/profiles/static_prop_vcol_smooth.json \
  --manifest SourceArt/Export/GAIA1/BloomFlowers.export.json
```

之后在 Editor 里跑 `RootsDance > Build Statue Bloom` 重建材质、prefab 与场景放置。

### 4.2 Unity

| 文件 | 职责 |
|---|---|
| `Assets/RootsDance/Shaders/Environment/StatueBloom.shadergraph` | L2 花簇的 Lit + Alpha Clip + 顶点色生长揭示 |
| `Assets/RootsDance/Scripts/Runtime/Environment/GrowthDriver.cs` | 推进 `_Growth`，写 `renderer.material`（与 `EmissivePulse` 同一批处策略） |
| `Assets/RootsDance/Shaders/Environment/StatueFlowers.shader` + `.hlsl` | L3 花田: 顶点着色器按 `_Growth` 在三个姿态间走二次 Bezier，真几何绽放 |
| `Assets/RootsDance/Scripts/Runtime/Environment/GrowthCue.cs` | 听 FlagRaised，在结局那一拍启动 `GrowthDriver`；场景晚加载时直接补到长满 |
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
- [x] 8. L3 花田: `build_bloom_flowers.py` 散布 `6,681` 朵，`321,696` verts / `196,648` tris，一个 mesh 一个 draw call；姿态由顶点着色器插值，`BloomFlowersMeshTests` 守住通道契约
- [x] 9. `SunBroadcaster` 已挂在 `_Lighting/Sun`：`12000 lux` → 全局量 `(1.20, 1.15, 1.06)`，贴近 shader 兜底光，`[ExecuteAlways]` 让 Editor 里也生效
- [ ] 7. L1 生长贴图与基底材质
- [ ] 10. 与 `MUS_EndingBloom` 对齐时长，接入 `CueSequence`

## 5.0 什么情况下开花

**`flow.circulation_outer`** —— 玩家在循环控制台（02-12，`DLG-008_CirculationConsole`）选了 Outer Boundary。三个选项里另外两个（Core Cultivation / Standard Ring）是错的，会唤醒温室里的 Boss 进入追逐；这一个是生态的实际状态，也是唯一不触发追逐的答案。

这不是新造的条件：`MusicWiring.cs` 早就把同一个 flag 绑到了 `MUS_EndingBloom`，`GrowthDriver` 的 `45 s` 就是那条音轨的长度。圣像开完花的那一刻音乐也结束。

`GrowthCue` 挂在 `StatueBloom` prefab 根上，照 `FlagMusicCues` 的写法听 bootstrap 的 FlagRaised 通道——控制台按自己的理由抬 flag，"这意味着圣像开花"是一行接线，玩法层不知道圣像的存在。

两个边界情况：

- **`GrowthDriver.m_playOnEnable` 现在是 `false`。** 圣像所在的是 additive 场景，早在第二章就加载了；之前是 `true`，意味着那 45 秒的演出在玩家背后自己演完了。
- **flag 已经抬起时才加载场景**（检查点跳过控制台、结局途中切关），`GrowthCue` 在第一个能问到 `WorldAccess.State` 的帧直接 `SetGrowth(1)`，不重放一遍玩家已经看过的演出。

### 圣像的两拍

到场和开花是两件事，各有自己的旗标和音乐：

| 旗标 | 谁抬 | 结果 |
|---|---|---|
| `flow.entered_sacred_space` | `Main_Gameplay` 里的 `SacredSpaceVolume`（`22 × 12 × 22 m`，罩住圣像脚下） | `MUS_SacredGaia`（神圣盖亚） |
| `flow.circulation_outer` | `DLG-008_CirculationConsole` 选对 Outer Boundary | 圣像开花 + 水流启动 + `MUS_EndingBloom`（生态复苏） |

触发体放在 `Main_Gameplay` 而不是圣像的环境场景: 触发体归 gameplay 场景，`TriggerLayerTests` 也只扫 `*_Gameplay.unity`——层设错的触发体什么都不抬，而且不会有人知道。

### 水流也等这一拍

`StatueWater`（两条臂间水流 + 五道指缝落水 + 三处溅射 + 地面水雾）现在**建出来就是关的**，由圣像根下的 `EndingCue`（一个 `CueSequence`）在 `flow.circulation_outer` 抬起时打开，同时从水落地的位置放一次 `SFX_WaterTrickle`。

一进场就有水在流的圣像，等于在说循环系统从来没坏过——那是整章的前提。用 `CueSequence` 而不是再写一个监听组件: 开关一个物体、放一次音效，本来就是 `CueStepKind` 五档里的两档；生长需要自己的组件只是因为 cue step 表达不了连续值。

重跑顺序有依赖: `RootsDance > Build Statue Environment Scene` 会重建整个 `Statue` 根，把 `StatueBloom` 一起删掉，所以它之后必须再跑一次 `RootsDance > Build Statue Bloom`。

坏结局的血: `RootsDance > Build Statue Blood (Doomed Endings)` 把 `StatueWater` 整棵克隆成同级的 `StatueBlood`（材质换成 `VFX_StatueBlood*` 三件，其余不变），并在 `EndingCue` 旁挂 `DoomedCue_Core` / `DoomedCue_Ring` 两个 `CueSequence`，分别听 `flow.circulation_core` / `flow.circulation_ring`。它同时写 `Main_Environment_Statue` 和 `GreenhouseInterior_Environment` 两份。规则: 好结局的 `StatueWater`/`EndingCue` 不在这里改；`Build Statue Environment Scene` 或 `Build Stone Pool Overflow` 重跑之后都要再跑一次它，因为血是水的克隆，水一重建血就是旧的。血材质每次重建都从水材质整份拷贝再只改颜色，调水的贴图/折射时不用另外维护血。**当前是关的**：`StatueBloodBuilder.k_DoomedCuesArmed = false`，`DoomedCue` 节点 inactive，坏结局不出血；要开就把常量改 true 重跑 builder（或直接在场景里激活 `DoomedCue`）。

## 5.1 绽放动画怎么烘进顶点里

Blender 的几何节点 / 粒子生长没有到 Unity 运行时的通路，顶点缓存（Alembic）的体积与开销不在本项目预算内，而且烘死之后就不能被剧情驱动。所以动画烘的是**姿态**，不是帧:

同一套拓扑生成三次 —— 合拢的花苞、半开、全开。全开姿态就是导出的 mesh，另外两个存成**相对全开的位移**，塞进空闲 UV 通道。顶点着色器走一条二次 Bezier:

```
P(t) = (1-t)² · bud + 2t(1-t) · mid + t² · open
     = open + (1-t)² · dBud + 2t(1-t) · dMid
```

三个姿态而不是两个: 花瓣是绕根部**转**出去的。两姿态线性插值时花瓣在中途会缩短，看起来像被吸进去再推出来。`mid` 是这条弧的控制点，它就是「开花」与「插值」的全部区别。

`t` 来自顶点色 B —— 与花簇同一条全局生长序，所以一朵花不会早于它脚下的花簇开。

| 通道 | 内容 |
|---|---|
| `COLOR.r` | 部位: `0` 茎与叶，`0.5` 花心，`1` 花瓣 |
| `COLOR.g` | 每朵花的相位，用于色调离散与摇摆 |
| `COLOR.b` | 生长序，`0` 最先开的那朵，`1` 最后一朵 |
| `COLOR.a` | 花瓣局部坐标，根到尖，只用来做根部阴影 |
| `UV0` | 这朵花自己的轴向（单位向量，八面体编码，Unity 空间）。材质参数 `_Sink`（米）把整朵花沿这个轴反向推进石头，茎埋进去；调埋深改材质不重烘。HDRP 手写 shader 的顶点输入到 UV3 为止，这是最后一对全精度通道 |
| `UV1` / `UV2` / `UV3` | `dBud.xy` / `dBud.z dMid.x` / `dMid.yz` |

### 位移必须写成 Unity 空间

UV 就是一组数，导出链路上没有任何东西会变换它；而顶点位置要过 FBX 的轴向转换和导入器的 `0.6045` 单位缩放。所以位移在 Blender 侧就要先映射好，映射关系是 `unity = (x, y, -z) × 0.6045`。

这不是猜的: 拿仓库里已有的一对资产量出来的 —— `BloomPatch.blend` 里 `BloomPatches` 的顶点坐标，对 builder 从导入后 mesh 上种花所写进 prefab 的位置。`build_bloom_flowers.py --self-test` 断言这个映射是线性的、等比的、且翻转手性。

### 生长序的分布是偏的

`growth_order` 取「从底座爬升」与「从双掌扩散」两条锋面的较小值，归一化后中位数只有 `0.114`（花簇是 `0.114`，花田是 `0.114`，两者一致）。也就是说 `_Growth` 走到 `0.11` 时圣像已经开了一半。花簇与花田偏得一样多，所以两者同步；但整体节奏偏前，需要靠 `GrowthDriver.m_shape` 曲线拉回来，不要改 bake。

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

### 6.9 三千朵花的开销

花田是一个 mesh、一个 renderer、一个 draw call，unlit 两个 pass，不投影不接收阴影。代价在顶点: `321,696` verts / `196,648` tris，约圣像本体（`85,963` tris）的两倍多。顶点着色器每帧对每个顶点做一次 Bezier 与一次摇摆，没有分支。若要减，`--count` 与 `--spread` 是唯一旋钮（朝向的随机量在 `--upright-jitter` / `--aim-jitter`，默认已开，避免同一褶皱上长出一排同向的花），重跑 `build_bloom_flowers.py` 并重跑 builder。

### 6.10 变形后的法线没有跟着转

顶点着色器移动位置，不移动法线 —— 花苞与半开姿态的法线仍是全开姿态的。花瓣是单面片且着色时把法线朝向摄像机翻转（`isFrontFace`），加上 wrap 漫反射，这个误差在花苞阶段（体积很小、持续很短）看不出来。要做对需要把 Jacobian 也烘进去，代价是又两个 UV 通道。

### 6.7 花簇几何的两个轴向陷阱

`BloomPatches.fbx`、`BloomFlowers.fbx` 与 NiwlPlants 的花，模型导入器都把轴/单位转换留在**模型根的 transform 上**，没有烘进顶点：

| | 根 rotation | 根 scale |
|---|---|---|
| `BloomPatches.fbx` | `(90, 0, 0)` | `1` |
| `M3D_poppy-1.fbx` 等 | `(270, 0, 0)` | `100`（FBX 声明单位为厘米） |

还有第三个陷阱，同一类但更隐蔽: **新导入的 FBX 拿的是 Unity 的默认导入设置，不是同批资产的设置**。花簇是 `bakeAxisConversion: 1`（轴向转换烘进顶点，模型根近似单位阵），新导入的花田默认 `0`（留在根上），两者挂成父子后中间就差一个绕 X 的 180°；mesh 原点离圣像 `93 m`，这个翻转把花田甩到 `139 m` 外。`globalScale` 同理: GAIA1 系列一律 `0.6045`，默认导入是 `1`，花会大 `1.65` 倍。builder 现在从花簇的 importer 上把这两项连同动画/可见性/焊接一起抄过来，`BloomFlowersMeshTests.Field_StandsWhereTheCoverDoes` 量两个 renderer 的 bounds 中心距来守。

`StMuerte.fbx` 的根没有旋转，照它的样子把裸 mesh 挂到新建 GameObject 上，两次都出了同一类事故: 花簇被甩到圣像 `93 m` 外并躺平；花只有 `1 cm` 高且侧躺。**取模型自己的根变换，不要取它的 mesh** —— builder 现在实例化两个模型；花田挂到花簇根下时用 `SetParent(root, worldPositionStays: true)`，让 Editor 自己算出「留在导入器放的位置」对应的局部变换，否则同一个轴向转换会被套两次。

### 6.8 builder 保存场景会写掉别人的在改内容

`EditorSceneManager.SaveScene` 写的是整个场景。对一个**已经打开**的场景调用它，会把当时任何人未保存的改动一并写盘 —— 曾把另一个 agent 改到一半的温室模块禁用状态提交进 `Main_Environment`。两个 builder 现在都在场景已打开且 `isDirty` 时直接拒绝执行。

### 6.5 圣像没有 UV2

`generateSecondaryUV: 0`，没有 lightmap UV。当前场景走实时光照（`TimeOfDayController`），不受影响。若后续改为烘焙 GI，圣像与所有 patch 都需要重新处理。

## 7. 验收标准

- 圣像从裸石到长满的完整过程可由单个 `0→1` 标量驱动，中途任意值都是一个自洽的画面。
- 生长有明确方向: 从底座与双掌起，向上、向外推进，不是整体淡入。
- 玩家站在圣像脚下平视与仰视，`5 m` 以内能看到立体的花，`5 m` 以上没有可辨认的贴片穿帮。
- patch 不穿模、不悬空，边缘与石面咬合。
- `MUS_EndingBloom` 的时长与生长曲线对齐，音乐结束时生长到 `1.0`；两者由同一个 flag `flow.circulation_outer` 启动。
- EditMode 套件全绿，`RootsDance.*` 无新增警告。
