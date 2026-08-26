# Blender → Unity 导出管线（绑定 / 动画资产）

> 适用角色：技术美术、场景美术、gameplay 程序
> owning 契约：[美术资产交付规范](../contracts/美术资产交付规范.md)（D14 / D15 / D16）
> 首个使用者：00-05 摘头盔（`Arms` + `Helmet`）
> 最后修订 2026-08-26 · **§4 的导出设置已做 Blender → FBX → Blender 往返实测（4.5.3 LTS）；Unity 侧导入尚未验证**

---

## 0. 这份文档补什么

[美术资产交付规范](../contracts/美术资产交付规范.md) 的 D14/D15/D16 是按**静态道具**写的。带 armature 的蒙皮 + 动画资产多出三类问题，契约没覆盖：

1. D14 的三个选项里，**选项 1 在有骨骼动画时是坏的**（下节给证据）；
2. Blender 的**约束（constraint）不进 FBX**，必须先 bake；
3. 手持道具的挂接方式是个架构选择，不是导出选项。

本文只补这三块 + 一份可执行的设置清单。命名、目录、贴图预算仍归 [guidelines/02](../../guidelines/02-project-structure.md) 与 [05](../../guidelines/05-performance.md)，不重复。

---

## 1. D14 补充：三选一不覆盖蒙皮动画 ⚠️

### 1.1 选项 1 对本类资产无效

D14 选项 1 是「FBX 导出勾 **Apply Transform**」。该勾选项在 Blender API 里是 `bake_space_transform`。从本机运行中的 Blender 4.5 直接读出的官方说明原文：

> "Bake space transform into object data, avoids getting unwanted rotations to objects when target space is not aligned with Blender's space (WARNING! experimental option, use at own risk, **known to be broken with armatures/animations**)"

Blender 自己标注它对 armature/动画是坏的。**凡是带骨骼的资产，选项 1 直接出局**——它只对静态道具成立。

### 1.2 建议增加选项 4：Unity 侧 Bake Axis Conversion

Unity 的 Model 导入设置里有一个专门处理该问题、且明确涵盖动画数据的开关。[Model 导入设置](../../reference/performance/manual-fbximporter-model.md) 原文：

> **Bake Axis Conversion** — "Bakes the results of axis conversion directly into your application's asset data (for example, vertex **or animation data**) when you import a model that uses a different axis system than Unity. Disable this property to compensate the Transform component of the root GameObject at runtime to simulate axis conversion."

后半句正是 D14 要避免的症状：**关掉它，Unity 就靠在根 GameObject 上补一个旋转来凑**——这跟契约里「不要在 Unity 侧用父物体套一层旋转去凑」是同一个坑，只不过 Unity 是自动替你套的。打开它，转换烘进资产数据本身。

**提案（待技术美术拍板，D14 状态不变）**：

| | 设置 |
|---|---|
| Blender 导出 | 全部保持导出器默认轴向（Forward `-Z` / Up `Y`），**Apply Transform 不勾** |
| Unity 导入 | **Bake Axis Conversion 打开**，Scale Factor `1`，Convert Units 打开 |

选它的理由：唯一一个官方文档明说处理 animation data 的路径；不依赖 Blender 那个自标 broken 的实验选项；静态道具和蒙皮动画可以用同一套流程，全队不用记两套。

> **D14 仍未闭环。** 本节只是把证据和第四个选项摆上桌，决定权按 [架构索引](../README.md) 的角色划分仍在技术美术。定了之后把结论写回契约 D14 本节。

### 1.3 本资产的单位现状（已实测）

`arms_rig_helmat.blend`：`METRIC` / `scale_length = 1.0` / `METERS`，眼高 1.743 m，`ArmsMesh` 与 `ArmsRig` 的 scale 均为 `1,1,1`、rotation 均为 `0`。

即 **1 Blender unit = 1 米**，D14 验收标准里「尺寸」那一半天然满足，需要验证的只剩轴向。

---

## 2. 约束与 bake（已实测，结论与直觉相反）

Blender 的 constraint（Child Of / IK / Copy Rotation…）**不是 FBX 的一部分**，这点无疑问。但**不需要**为此专门跑一遍 Bake Action——**FBX 导出器勾了 Baked Animation 之后，会自己把约束求解后的姿态逐帧采样成关键帧**。

**实测依据（2026-08-26，Blender 4.5.3 LTS）**：`helmet_socket` 这根骨头自身**没有任何位移/旋转关键帧**，运动完全由一个 Child Of 约束驱动。按 §4 设置导出后再导回：

| 检查项 | 结果 |
|---|---|
| FBX 里骨骼上的约束 | `[]` —— 如预期，没了 |
| FBX 里 `helmet_socket` 的 fcurve | **10 条，每条 120 个关键帧** |
| 世界路径 f1 / f27 | 与原始完全一致 |
| 世界路径 f72 / f120 | 偏差 2mm / 1mm（FBX 浮点精度） |

所以 `forearm.L/R` 的 IK、12 根手指的 Copy Rotation、头盔挂点的 Child Of，**都会被自动烘进导出结果**，不必手动预烘。

**什么时候仍然要手动 Bake Action：**

- 你想在导出前**在 Blender 里肉眼检查**将要导出的到底是什么（烘完时间轴上就是最终曲线，所见即所得）；
- 约束链复杂到你不确定求解顺序，需要一个可复查的中间产物；
- 要把 clip 交给不装该 rig 的人。

真要手动烘，**先复制一份 armature 或整个 .blend 另存副本**：

```
Object → Animation → Bake Action…
  ☑ Visual Keying          # 采样约束求解后的实际姿态
  ☑ Clear Constraints      # 烘完移除约束，避免二次求解
  Bake Data: Pose
  Frame Range: 1 – 120
```

烘完的 action 无法回退成约束版；带约束的那份是以后改动画的唯一入口。

---

## 3. 手持道具的挂接方式（头盔）

头盔在第 27 帧从「戴在头上」变成「被手拿着」。这个换父级在 Unity 侧有三种实现，**这是架构选择，先定再导**：

| | 做法 | 代价 |
|---|---|---|
| **A. Socket 骨骼**（建议） | 给 `ArmsRig` 加一根 `helmet_socket` 骨，把它的世界运动烘成关键帧（前 26 帧静止在头顶，之后跟 `hand.R`）。Unity 里头盔 prefab 直接挂到该骨骼下 | 要改骨架；但换父级变成纯骨骼动画，FBX 原生支持，运行时零代码 |
| **B. Animation Event 换父级** | clip 只驱动手臂，第 27 帧发 Animation Event，脚本把头盔 reparent 到 `hand.R` | 要写运行时代码；换父级时机可被 gameplay 改写 |
| **C. 头盔运动烘进同一个 FBX** | 头盔作为 object animation 一起导出 | 最省事，但头盔焊死在 clip 里，不能换、不能掉落 |

**已定案：A**（2026-08-26）。它同时满足 D16 的分工哲学（[「美术交纯外观 prefab，gameplay 程序做 variant」](../contracts/美术资产交付规范.md)）——头盔仍是独立可替换的 prefab，动画只负责给出一个挂点。C 违背这条。

**实现现状**：`ArmsRig` 已加入 `helmet_socket` 骨骼——挂在 `root` 下、`use_deform = False`、rest 位置在头盔 f1 的世界坐标，由一个与头盔同参数的 Child Of（target `hand.R`，influence 在 f26/f27 之间 CONSTANT 切换）驱动。

实测 socket 全程跟随头盔中心，最大偏差 **1.5mm**；头盔相对 socket 的局部变换在全 120 帧内**恒定**，证明它是一个合法的刚性挂点。当前占位球在 socket 下的局部旋转是 `(0, 180°, 0)`——这个 180° 是占位球自带的无意义旋转（建球时从相机复制来的），真头盔模型进来时在 Unity 里对齐一次即可。

**Optimize Game Objects** 要么关掉，要么把 `helmet_socket` 加进 *Extra Transforms to Expose*，否则该 Transform 在运行时不存在。

---

## 4. Blender FBX 导出设置

选中 `ArmsMesh` + `ArmsRig`（烘过约束的那份），`File → Export → FBX`。

**Include**

- Limit to: ☑ Selected Objects
- Object Types: **Armature + Mesh**（不勾 Empty / Camera / Light / Other）

**Transform**

- Scale `1.00`，Apply Scalings 保持默认，Forward `-Z`，Up `Y`（均为导出器默认值）
- ☑ Apply Unit
- ☐ **Apply Transform** ← 见 §1.1，绝不勾
- ☑ Use Space Transform

**Geometry**

- Smoothing：本资产是 PSX 低多边形硬边风格，用 `Face`；若模型带 custom split normals 改用 `Normals Only`（导出前确认一次）
- ☑ Apply Modifiers（Armature 修改器会被自动排除，不影响蒙皮）

**Armature**

- ☐ **Add Leaf Bones** ← 默认是开的。开着会给每条骨链尾端加 `_end` 骨，污染 Unity 层级
- ☐ Only Deform Bones ← 保持关闭，否则 `camera` 骨（无变形子级）会被剥掉；第一人称要靠它驱动相机
- Primary/Secondary Bone Axis、Armature FBXNode Type 保持默认（`Y` / `X` / `Null`）

**Animation**

- ☑ Baked Animation、☑ Key All Bones、☑ Force Start/End Keying
- ☐ NLA Strips
- ☐ **All Actions** ← 默认是开的。开着会把 .blend 里全部 **20 个** action 都导成 AnimStack（含 18 个原始动作和 `Helmet_PlaceholderAction` 这种中间产物）。单 clip 交付时关掉，只导当前 action
- Sampling Rate `1.0`
- Simplify **`0.0`** ← 默认 `1.0` 会抽稀曲线。约束烘出来的运动逐帧有效，抽稀会让手和道具穿插

---

## 5. Unity 导入设置

**Model 页**

- Scale Factor `1`、☑ Convert Units、☑ **Bake Axis Conversion**（§1.2）
- ☐ Import BlendShapes / Import Visibility / Import Cameras / Import Lights
- ☐ **Generate Colliders** ← D16 硬性要求
- Read/Write 关闭

**Rig 页**

- Animation Type **`Generic`**，不是 Humanoid。这是一套只有双臂的骨架，没有完整人形骨骼；Humanoid 重定向会把逐帧手 K 的第一人称动作改写掉
- Avatar Definition: Create From This Model，Root node `root`
- Optimize Game Objects：按 §3 所选方案处理

**Animation 页**

- ☑ Import Animation，clip 命名 `Arms_HelmetOff`（[guidelines/02](../../guidelines/02-project-structure.md) 的 `<Character>_<Action>`）
- Anim. Compression：先用 `Off` 验收动作，确认无误后再评估 Keyframe Reduction

**Materials 页**

- **Extract Materials** 到 `Assets/RootsDance/Materials/`（[guidelines/02](../../guidelines/02-project-structure.md) 强制项）

---

## 6. 文件去向

| 内容 | 路径 | 依据 |
|---|---|---|
| 手臂模型 + clip | `Assets/RootsDance/Meshes/Characters/Arms.fbx` | guidelines/02（clip 留在 FBX 内，不外提到 `Animations/Clips/`） |
| 头盔模型 | `Assets/RootsDance/Meshes/Props/Helmet.fbx` | guidelines/02 |
| 提取出的材质 | `Assets/RootsDance/Materials/` | guidelines/02 |
| **`.blend` 源文件** | **`SourceArt/`（仓库根，目前不存在，需新建）** | guidelines/02：`.blend` 永不进 `Assets/` |

两条现状待办：

- `SourceArt/` 尚未建立。`arms_rig_helmat.blend` 当前在仓库外的 `psx-first-person-arms-free-game-assets/`。
- 该资产是 itch.io 的 **CC0** 第三方素材（drillimpact / PSX First Person Arms）。来源与授权应在 [third-party.md](../../third-party.md) 留一条记录。

---

## 7. 验收清单

### 7.1 已通过的往返实测（Blender → FBX → Blender，2026-08-26）

按 §4 设置导出 `ArmsMesh` + `ArmsRig` 后，用独立的无头 Blender 进程导回检查：

- ✅ `ArmsMesh` / `ArmsRig` 均为 position `0` / rotation `0` / scale `1`
- ✅ 53 根骨骼，**没有任何 `_end` 叶子骨**（`Add Leaf Bones` 关闭生效）
- ✅ `helmet_socket` 存在，约束驱动的运动已被采样成 120 帧关键帧
- ⚠️ 导回后 action 的帧范围显示为 **`2–121`** 而非 `1–120`（时长仍是 120 帧，采样值对得上）。这是 Blender FBX 往返的偏移，Unity 侧行为未知——**导入后务必核对 clip 的起止帧和时长**

这一步只证明 FBX 本身干净，**不能替代 Unity 侧验收**：轴向转换发生在 Unity 的导入器里，下面这份必须在 Editor 里过。

### 7.2 Unity 侧验收（未做）

导出后把 FBX 拖进场景，逐条核对：

- [ ] **D14** — 根物体 Transform 是 position `0` / rotation `0` / scale `1`。**不达标就是导出错了，不要在 Unity 侧套父物体凑**
- [ ] **D14** — 1 unit = 1 米：眼高 ≈ `1.74`，头盔直径 ≈ `0.28`
- [ ] **D15** — 朝向：手臂正面朝 **+Z**（Blender 的相机朝 `-Y`，经轴向转换应落到 Unity `+Z`；**此映射尚未实测，首次导入时必须验**）
- [ ] **D16** — 没有任何自动生成的 `MeshCollider`
- [ ] 骨骼层级里没有 `_end` 叶子骨
- [ ] clip 时长 120 帧 @ 30 fps = 4.0 秒，起止姿态与 Blender 一致（注意 §7.1 的 `2–121` 偏移）
- [ ] `helmet_socket` 在骨骼层级里可见，且第 27 帧起跟随 `hand.R`
- [ ] 手指没有穿进头盔、头盔没有脱手
- [ ] 材质已 extract，FBX 内无内嵌材质

---

## 8. 与 00-05 的关系

摘头盔是 [切片 00 实施计划](../systems/切片00_实施计划.md) 的 **00-05**，触发点是 `FlagRaised` 频道上的 `flow.helmet_removed`（见 [场景搭建与接线](../systems/切片00_场景搭建与接线.md)）。

按 **D21**，gameplay 侧先用「HUD 淡出 + 短暂黑屏 + 呼吸声切换」占位，正式演出走 **Timeline** 后补。因此本 clip 大概率由 Timeline 的 Animation Track 驱动，而不是进 Animator 状态机——Animator Controller 与 Blend Tree 那套（[guidelines/09](../../guidelines/09-packages-systems.md)）在这里不适用。

**这条 clip 不得阻塞主流程验收**：实施计划明确写着「不允许任何美术资产阻塞『从开场到调查完成可以完整运行』」。占位方案必须先独立可用。

---

## 参考

- Blender FBX 导出器 `bake_space_transform` 说明 — 本机 Blender 4.5 `bpy.ops.export_scene.fbx` RNA 实测读取，2026-08-26
- [Model 导入设置（Unity 6000.3）](../../reference/performance/manual-fbximporter-model.md) — Scale Factor / Convert Units / Bake Axis Conversion
- [Materials 页（Model 导入设置）](../../reference/project-structure/manual-fbximporter-materials.md)
- [契约：美术资产交付](../contracts/美术资产交付规范.md) — D14 / D15 / D16
- [guidelines/02 — 项目与资产组织](../../guidelines/02-project-structure.md)
