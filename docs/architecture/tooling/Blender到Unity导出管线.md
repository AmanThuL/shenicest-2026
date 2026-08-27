# Blender → Unity 导出管线（模型 / 绑定 / 动画资产）

> 适用角色：技术美术、场景美术、gameplay 程序
> owning 契约：[美术资产交付规范](../contracts/美术资产交付规范.md)（D14 / D15 / D16）
> 首个使用者：00-05 摘头盔（`Arms` + `Helmet`）
> 状态 2026-08-26 · Blender 段、Unity 段均已实测通过；未闭环项见 §10

---

## 1. 规则

1. **模型一律用 `Tools/blender/export_fbx.py` 导出 FBX 进 `Assets/`。**
2. **不要把 `.blend` 放进 `Assets/`**，也不要依赖 Unity 的 `.blend` 原生导入（理由见 §2）。
3. **导出器不认识任何资产名**：物体、骨架、action 由命令行给，动画与 FBX 策略由 profile 给。要改某个资产的导出行为，改它的参数或 profile，**不要改导出器**。
4. **Unity 侧的导入设置不在 Blender 里解决**：`Tools/unity/model_import_profiles.json` 是唯一来源，由 `BlenderModelPostprocessor` 自动套用。任何人都不需要手点 Inspector。
5. **绝不导出 `.blend` 里的全部 action**：用 `--action` / `--actions` 逐条指名。
6. **带骨骼的资产不勾 Apply Transform**（`bake_space_transform`）；轴向转换交给 Unity 的 Bake Axis Conversion。

## 2. 分界线

| 归谁 | 内容 |
|---|---|
| **Blender 段** | 文件里有哪些物体、叶子骨、曲线抽稀、smoothing、导出哪个 action |
| **Unity 段** | 轴向 bake、scale、rig 类型、clip 命名、材质重定向、碰撞体 |

这条线不能挪：上排四项 **`ModelImporter` 没有对应设置**，只能在导出时决定。

`.blend` 原生导入之所以不用，是因为 Unity 调用 `Unity-BlenderToFBX.py` 时只钉死 9 个参数，其余走 Blender 默认值。同一个 `arms_rig_helmat.blend` 两条路径的实测差异：

| 检查项 | 原生 `.blend` | 本管线 |
|---|---|---|
| 导入物体数 | 53（含 40 个 `WGT-*` 绑定控制器、9 个 `Cube*`、相机） | 3 |
| `_end` 叶子骨 | 16 | 0 |
| `ArmsRig` 关键帧 | 20,460 | 64,680 |

另有两条硬约束：`.blend` 进 `Assets/` 违反 [guidelines/02](../../guidelines/02-project-structure.md) 规则 1 与 6；且 Unity 要求**每台机器都装 Blender**。

---

## 3. 目录与文件

```text
Tools/blender/export_fbx.py              通用导出器
Tools/blender/profiles/fps_arms.json     蒙皮 + 动画：逐帧烘、不抽稀
Tools/blender/profiles/static_prop.json  静态道具：不烘动画
Tools/unity/model_import_profiles.json   Unity 侧 profile + 每资产条目
Assets/RootsDance/Scripts/Editor/Pipeline/
    BlenderModelPostprocessor.cs         通用 AssetPostprocessor
    ModelImportProfiles.cs               读上面那个 JSON
    ModelSource.cs                       读导出器写的 provenance manifest
```

| 内容 | 路径 |
|---|---|
| 手臂模型 + clip | `Assets/RootsDance/Meshes/Characters/Arms.fbx` |
| 匍匐前进 clip | `Assets/RootsDance/Meshes/Characters/Arms_Crawl.fbx` |
| 头盔模型 | `Assets/RootsDance/Meshes/Props/Helmet.fbx` |
| 材质 | `Assets/RootsDance/Materials/` |
| provenance manifest | `SourceArt/Export/<Asset>.export.json` |
| `.blend` 源文件 | `SourceArt/Blender/<Asset>/`（目标位置；手臂资产尚未移入，见 §10） |

---

## 4. 怎么跑

从**项目根**执行（`<源 .blend>` 见 §3；手臂资产目前仍在仓库外，见 §10 第 6 条）：

```bash
/Applications/Blender.app/Contents/MacOS/Blender --background \
  <源 .blend> \
  --python Tools/blender/export_fbx.py -- \
  --project-root . \
  --output Assets/RootsDance/Meshes/Characters/Arms.fbx \
  --objects ArmsMesh,ArmsRig,Helmet_Placeholder \
  --armature ArmsRig \
  --action helmet_off \
  --profile Tools/blender/profiles/fps_arms.json \
  --manifest SourceArt/Export/Arms.export.json
```

Unity 侧无需任何手工步骤。

**路径语义**：

- 带 `--project-root`：相对路径按项目根解析，manifest 记项目根相对路径（因此不含机器路径）。**始终这样用。**
- 不带：相对路径按 `.blend` 所在目录解析，`--output Assets/...` 会写到 `.blend` 旁边。
- 绝对路径任何时候原样接受。

**整个集合一次导出**：`--collection Architectures` 代替 `--objects`，导出该集合（含子集合）下所有带面的 MESH 物体；无面的线框重复体跳过，艺术家在大纲里取消勾选（从视图层排除）的子集合视为“不属于模型”而跳过并记入 manifest 的 `m_excludedObjects`，用眼睛图标隐藏的物体仍报错。首个使用者：实验室白模 `LabBlockout.fbx`（`GAIA1_v2.blend`，2026-08-27）。

**一次导多个 action**：`--actions knife_idle,jab.L` 产出 `Arms_knife_idle.fbx` / `Arms_jab.L.fbx`，各带一份 manifest，帧范围各取自对应 Action。

**action 名直接进文件名**：`jab.L` 会产出带点的 `Arms_jab.L.fbx`，不符合 guidelines/02 命名规则。交付前先在 Blender 里把 action 改成 PascalCase。

---

## 5. 导出 profile

两个 profile 的 `fbx` 段相同，差异只在 `animation` 段。

| 键 | 值 | 依据 |
|---|---|---|
| `bake_space_transform` | `false` | Blender 官方说明：*"known to be broken with armatures/animations"* |
| `add_leaf_bones` | `false` | 否则每条骨链尾端多一根 `_end` 骨 |
| `mesh_smooth_type` | `"FACE"` | PSX 低多边形硬边 |
| `axis_forward` / `axis_up` | `-Z` / `Y` | 导出器默认值，配合 Unity 侧 Bake Axis Conversion |
| `bake_anim_step` | `1.0` | 逐帧烘，适配约束 / IK / Child Of |
| `bake_anim_simplify_factor` | `0.0`（fps_arms） | 抽稀会让手和道具穿插 |
| `bake_anim` | `false`（static_prop） | 静态道具无动画 |

导出器另有两个 **profile 不可覆盖**的运行期参数：`use_selection=True`、`object_types={'ARMATURE','MESH'}`。**需要导出 Empty 的资产目前不适用本管线**（§10）。

---

## 6. 约束（Child Of / IK）不需要预先 bake

FBX 导出器勾了 Baked Animation 后，会把约束求解后的姿态逐帧采样成关键帧。`forearm.L/R` 的 IK、12 根手指的 Copy Rotation、头盔挂点的 Child Of 都会自动烘进导出结果。

实测：`helmet_socket` 自身无关键帧、运动全由 Child Of 驱动，导出后得到 1,200 个关键帧，世界路径与原始最大偏差 2mm。

**仍需手动 Bake Action 的情况**：要在 Blender 里肉眼检查将导出的曲线；约束链复杂到需要可复查的中间产物；要把 clip 交给不装该 rig 的人。手动烘之前**先另存副本**——烘完的 action 无法回退成约束版。

---

## 7. 手持道具挂接：Socket 骨骼

**已定案**：给骨架加一根不参与变形的 socket 骨，用约束驱动它跟随目标骨，导出时烘成关键帧；Unity 里道具 prefab 挂到该骨骼下。

换父级因此变成纯骨骼动画，FBX 原生支持，运行时零代码，道具仍是独立可替换的 prefab（满足 D16 的分工）。

现状：`ArmsRig` 已有 `helmet_socket`，挂在 `root` 下、`use_deform = False`，由 Child Of（target `hand.R`，influence 在 f26/f27 之间 CONSTANT 切换）驱动。

**用 socket 的资产必须关掉 Optimize Game Objects**，或把 socket 骨加进 profile 的 `m_extraExposedTransformPaths`，否则该 Transform 运行时不存在。

---

## 8. Unity 侧

设置全部在 `Tools/unity/model_import_profiles.json`，由 `BlenderModelPostprocessor` 在 `OnPreprocessModel` / `OnPreprocessAnimation` 套用。**只有登记过的资产会被改**，其它 FBX 按 Unity 默认导入。

`fps_arms` profile：

- **Model** — `bakeAxisConversion` 开、Scale `1`、`useFileScale` 开；BlendShapes / Visibility / Cameras / Lights 全关；`addCollider` 关（D16）；`isReadable` 关；`weldVertices` 关（保留 PSX 硬边切分）
- **Rig** — `Generic`。**不要用 Humanoid**：只有双臂、没有完整人形骨骼，重定向会改写逐帧手 K 的第一人称动作。`optimizeGameObjects` 关
- **Animation** — `importAnimation` 开、压缩 `Off`、clip 命名 `Arms_HelmetOff`
- **Materials** — `External` + `BasedOnMaterialName` + `Everywhere`，材质重定向到 `Assets/RootsDance/Materials/`，避免 Unity 在 mesh 旁边另建 `Materials/`

`static_blockout` profile（实验室白模）：同 `static_prop`，但 `m_globalScale = 0.4`（V2 建筑比例决策见 [全章节地形与场景空间设计方案](../../design/全章节地形与场景空间设计方案.md) §0 第 8 条）、`m_addCollider` 开（白模是可走的灰盒几何）、`m_materialImportMode = None`（白色默认材质）。

两个 Editor 菜单：

- `RootsDance/Pipeline/Reimport Pipeline Models` —— 配置在 `Assets/` 外，Unity 不会自动感知编辑，改完点这个
- `RootsDance/Pipeline/Check Model Sources` —— 比对 manifest 里记的 `.blend` 修改时间，报出落后于源文件的模型

**新增资产要登记**：在 `m_assets` 里加一条（`m_path` / `m_profile` / `m_manifest` / `m_clipName` / `m_loopTime` / `m_materials`），否则该 FBX 走 Unity 默认导入。

`m_loopTime` 控制 clip 的 Loop Time：缺省或 `false` 适用于一次性动作（`Arms_HelmetOff`），首尾帧一致的循环动作（`Arms_Crawl`）填 `true`。

### 8.1 `camera` 骨：取景是**每个动画**一份

`camera` 骨表示「这个动画里眼睛在哪」，**每个 action 各有一份**：可以整段偏移，可以叠 bob，也可以完全不 K、全程停在绑定姿势。

Unity 的相机**不跟随**这根骨（Cinemachine 第一人称相机跟的是 `Head`）。clip 里烘进去的任何眼睛位移，都会表现为「手臂离眼睛差了那么远」——看起来手变长或变短。所以补偿是 **clip 的属性，不是 rig 的属性**：一个全局偏移只可能对其中一个 clip 是对的，其余全错。

拆成两半，因为两半要反着处理：

| 成分 | 去向 | 理由 |
|---|---|---|
| **恒定部分** | 补偿到**手臂**（`ArmsViewOffset`） | 拿去推视点会在状态切换那一帧把玩家的眼睛弹一下 |
| **时变部分** | 驱动**视点**（`CameraBoneViewBob`） | 这就是作者 K 的 bob，本来就该让玩家感觉到 |

`ArmsViewOffset` 上三层相加，三层各有其主：

- `m_basePosition` 锚点 —— 把**绑定姿势**的 camera 骨放到 head 支点上，建 rig 时写一次
- `m_clips[].m_correction` / `m_referenceBonePosition` / `m_animatesCameraBone` —— 机器算的，`RootsDance > Refresh Arms Framing` 遍历 controller 里每个 state、采样 clip 第 0 帧后写入
- `m_positionOffset`（所有 clip）/ `m_clips[].m_tweak`（单个 clip）—— **人调的口味，工具永不覆写**

调某个动画的取景 = 改那个 clip 的 `m_tweak`；改所有动画 = 改 `m_positionOffset`。`m_previewState` 决定不进 Play 模式时 Scene 视图按哪个 clip 取景。**新增动画不需要手输数字**：在 Blender 里给那个 action 的 `camera` 骨 K 帧，导出，重跑 `Refresh Arms Framing`。

改这块之前必须知道的两条约束：

1. **FBX 烘焙会给每根骨写满关键帧**，所以「有没有 camera 骨曲线」证明不了什么——完全不动 camera 骨的 clip，导出后同样带一整套数值相同的键。只有**数值真的变化**的曲线才算作者 K 的 bob（`m_animatesCameraBone` 按此判定）。
2. **`Animator.Rebind()` 在 Edit 模式下不会把骨骼恢复成绑定姿势**，量出来的是上一次采样残留的姿势。绑定姿势要从**源模型资产**上读（`PrefabUtility.GetCorrespondingObjectFromSource`），资产里的骨永远在绑定姿势。

**这张表按 Animator state 名索引。** 改用 Timeline 的 Animation Track 驱动 clip 时表里查不到（Timeline 没有 Animator state），会静默退回零补偿——换驱动方式之前先给表换索引键。

---

## 9. 验收

### 9.1 导出后（Blender → FBX → Blender）

| 检查项 | 结果 |
|---|---|
| 根物体 position / rotation / scale | `0` / `0` / `1` ✅ |
| 骨骼数 / `_end` 叶子骨 | 53 / **0** ✅ |
| `helmet_socket` 及其采样关键帧 | 存在，1,200 帧 ✅ |
| `ArmsMesh` 顶点 / 面 / UV / 材质 | 596 / 768 / `UVMap` / `Arms` ✅ |

### 9.2 Unity 导入后（2026-08-26 在 6000.3.22f1 实测）

| 契约 | 检查项 | 结果 |
|---|---|---|
| **D14** | 根 Transform | position `0` / rotation `0` / scale `1` ✅ |
| **D14** | 1 unit = 1 米 | `camera` 骨世界高度 **1.7432** ✅ |
| **D15** | 正面朝 `+Z` | ❌ **不达标**，见 §10 第 1 条 |
| **D16** | 无自动生成碰撞体 | `Collider` 数 **0** ✅ |
| — | 骨骼层级无 `_end` 叶子骨 | 57 个 Transform，`_end` **0** ✅ |
| — | clip 时长 | `Arms_HelmetOff` 帧范围 `1–120`，**3.9667 s @ 30 fps** ✅ |
| — | socket 跟随 | f26 起 `helmet_socket`↔`hand.R` 距离恒定 `0.2722` ✅ |
| — | 头盔刚性挂接 | 头盔相对 socket 的局部位置全程漂移 **0.00002** ✅ |
| — | 材质已 extract | FBX 内嵌材质 **0**，两个材质均指向 `Materials/` ✅ |
| — | 导入设置生效 | `bakeAxis=True` / `Generic` / `optimizeGO=False` / `addCollider=False` / `weld=False` / `readable=False` / `animCompression=Off` ✅ |

clip 时长按 `(120−1)/30 = 3.9667 s` 计，不是 4.0 s——首尾帧都算，区间是 119 个。往返回 Blender 时出现的 `2–121` 偏移**不会传到 Unity**，Unity 侧就是 `1–120`。

### 9.3 仍需人眼确认

- 动画播放时手指没有穿进头盔、头盔没有脱手（几何穿插无法用上表的方式判定）。

---

## 10. 未闭环

1. **D15 朝向不达标。** 实测 `camera` 骨在原点、双手在 `z = −0.246`，网格 Z 范围 `−0.458..0.119`，右手在 `−X`——**资产正面朝 `−Z`，不是 D15 要求的 `+Z`**。
   D15 是按静态道具写的（pivot 在接地点、正面 `+Z`），第一人称手臂既没有接地点也没有通常意义的"正面"。
   **待技术美术定**：是把源 `.blend` 整体转 180° 重导，还是在契约里给第一人称/蒙皮资产单列一条。结论写回 [D15](../contracts/美术资产交付规范.md)。
2. **D14 未闭环**——导出侧设置已定（§5），Unity 侧 `Bake Axis Conversion` 方案待技术美术在契约里确认。
3. **导出器不支持 Empty**（§5）。需要导出 Empty 的资产出现时再扩展 `object_types`。
4. **`Helmet.fbx` 未登记进 `model_import_profiles.json`**——它的 `HelmetShell` / `Visor` 材质资产还不存在，登记后 Unity 会在 mesh 旁边自动抽材质，违反 guidelines/02。等贴图管线产出材质后补条目。
5. **`Tools/pipeline/stages/export_mesh.py` 与本导出器功能重叠**，应合并为一个导出实现。
6. **源 `.blend` 尚未移入 `SourceArt/Blender/`**（§3 已按目标路径写）。移动后 manifest 的 `m_blend` 会从 `../psx-...` 变成项目内相对路径。
7. **导出器不检查对象的视图隐藏状态。** `select_only()` 只挡住不在 view layer 的对象；被 `hide_get()`（眼睛图标 / <kbd>H</kbd>）隐藏的对象 `select_set()` 会静默失败，FBX 导出器跳过它，而 manifest 的 `m_exportedObjects` 仍按命令行参数记录，于是 manifest 声称导出的对象其实不在 FBX 里。`Helmet_Placeholder` 当前处于隐藏状态。修复方向：`select_only()` 一并检查 `hide_get()` 并报错。
8. **第三方素材授权未记录**——手臂资产是 itch.io 的 CC0（drillimpact / PSX First Person Arms），应在 [third-party.md](../../third-party.md) 留一条。

---

## 参考

- Unity 的 Blender→FBX 转换脚本 —— Editor 自带 `Unity.app/Contents/Resources/AssetImporting/Unity-BlenderToFBX.py`（6000.3.22f1）
- Blender FBX 导出器 `bake_space_transform` 说明 —— Blender 4.5.3 LTS `bpy.ops.export_scene.fbx` RNA
- [模型文件导入（Unity 6000.3）](../../reference/project-structure/manual-importingmodelfiles.md)
- [模型文件格式](../../reference/project-structure/manual-3d-formats.md)
- [Model 导入设置](../../reference/performance/manual-fbximporter-model.md)
- [契约：美术资产交付](../contracts/美术资产交付规范.md) — D14 / D15 / D16
- [guidelines/02 — 项目与资产组织](../../guidelines/02-project-structure.md)
