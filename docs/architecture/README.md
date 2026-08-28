# 架构文档索引（docs/architecture）

《Where the Roots Dance》（Unity 6000.3.22f1 / HDRP 17.3 / C# 9）的架构文档入口。

当前运行时事实优先阅读 [运行时架构说明书](运行时架构说明书.md)；
工程规则以 [`docs/guidelines/`](../guidelines/README.md) 为准；策划、叙事和关卡需求见
[`docs/design/`](../design/README.md)。

## 目录职责

```text
docs/architecture/
├── README.md
├── 运行时架构说明书.md   # 当前 runtime as-built 总览
├── 程序组工作流与架构原则.md                 # 团队协作、单向数据流、测试边界
├── contracts/                              # 被代码与跨岗位协作引用的锁定规范
├── decisions/                              # 已落定的技术决策及取舍依据
├── systems/                                # 当前系统和切片的实现级说明（暂空）
├── tooling/                                # 调试、预览和接线工具说明
└── archive/                                # 已被当前实现取代的历史资料
```

## 当前架构与原则

| 文档 | 用途 |
|---|---|
| [运行时架构说明书](运行时架构说明书.md) | runtime 的三层架构、命令队列、WorldState、事件通道和 Unity 场景协作边界。 |
| [程序组工作流与架构原则](程序组工作流与架构原则.md) | 程序组的协作规则、单向数据流、契约先行、测试边界和提交纪律。 |

## 锁定契约

项目里做"程序"的有两个岗位——gameplay 程序和前端工程师（UI owner）——加上技术美术共三个技术向角色；下表的"适用角色"按这三个角色写，不用"程序"这个笼统词。

| 文档 | 适用角色 | 用途 |
|---|---|---|
| [场景与资产所有权](contracts/场景与资产所有权.md) | 全员 | 场景、prefab、ProjectSettings 和跨岗位文件所有权。 |
| [表现层驱动契约](contracts/表现层驱动契约.md) | gameplay 程序、技术美术 | 四个 View 接口、高亮方案与音频边界。 |
| [美术资产交付规范](contracts/美术资产交付规范.md) | 场景美术、技术美术、gameplay 程序 | FBX 轴向、pivot、碰撞体和 prefab variant。 |
| [UI 与前端契约](contracts/UI与前端契约.md) | 前端工程师、gameplay 程序、UI 美术 | 界面 prefab 的控件契约、频道清单和代码边界。 |
| [手臂动画状态机](contracts/手臂动画状态机.md) | 技术美术、gameplay 程序 | ArmsRig 全部动画 clip 的骨骼覆盖、起止状态假设、衔接顺序和手腕校验规约。 |

## 当前系统

| 文档 | 适用角色 | 用途 |
|---|---|---|
| [手臂动画统一驱动 · 实施计划](systems/手臂动画统一驱动_实施计划.md) | gameplay 程序、技术美术 | 把散装的 clip 驱动收敛成「一个 ArmsDirector + 一张 ArmsActionSO 表」：三层遮罩状态机、neutral/hold 姿势、手持物挂接与抓放时点、地面↔站立高度基准，以及 scanner 百倍缩放与 `stand_up` root 抬升两个已定位缺陷的修法。 |

两份切片 00 文档已移入 [`archive/`](archive/README.md)，不再作为实现依据。

## 技术决策与研究

| 文档 | 用途 |
|---|---|
| [测试策略](decisions/测试策略.md) | 真相层单元测试边界、现有 EditMode 测试清单和何时新增测试。 |

## 工具

| 文档 | 用途 |
|---|---|
| [工具说明索引](tooling/README.md) | 调试、预览和接线工具的入口。 |
| [Unity CLI 与 Pipeline：从 shell 驱动 Editor](tooling/unity-cli-agent-workflow.md) | 人和 AI agent 用官方 Unity CLI 跑测试/构建、对打开的 Editor 进 Play mode、读 Console、截图、eval C#、打断点的已验证流程（英文）；含 `com.unity.pipeline` 的取舍（待团队决定）和 agent 安全规则。 |
| [Blender → Unity 导出管线](tooling/Blender到Unity导出管线.md) | 模型/绑定/动画管线：通用导出器 + JSON profile + 每资产参数、不走 `.blend` 原生导入的理由、约束不需预先 bake、手持道具的 socket 挂接，以及 D14/D15/D16 的 Unity 侧实测结果（**D15 不达标，待技术美术定**）。 |
| [贴图管线](tooling/贴图管线.md) | Blender → Substance Painter → Unity 的贴图管线：目录与命名约定、九段流程与机器校验、预设、Painter 远程脚本协议与 API 探针、Unity 导入设置自动化、版本控制策略（**材质创作与贴花尚未实现**）。 |
| [Dev Play：从检查点开始玩](tooling/dev-play-checkpoints.md) | Editor 专用：一键打开 Main 场景、进 Play、把玩家传送到站点并通过命令队列补齐世界状态（flag / 报告条目）；Play 中可跳到其他检查点；检查点是 `Data/DevPlay/` 下的 `DevCheckpointSO`（英文）。 |
| [构建与打包](tooling/build-and-packaging.md) | `Tools/build/build.py`：preflight 检查 + 无头 Unity 构建 + 打包成按提交号命名的 zip；命名约定、zip 结构、profile 与玩家设置对照表（含出处）、Gatekeeper 隔离说明（英文；**Windows 路径未经实测**）。 |

## 历史资料

`archive/` 只用于追溯历史决策，不作为当前实现依据。入口与替代来源见
[archive/README.md](archive/README.md)。

## 推荐阅读顺序

1. 了解当前实现：运行时架构说明书。
2. 了解团队边界：程序组工作流与架构原则。
3. 修改跨岗位接口：对应 `contracts/` 文档。
4. 修改具体系统：对应 `systems/` 文档。
5. 查询取舍原因：`decisions/`。
6. 从 shell 驱动 Editor、给 AI agent 配工具：`tooling/`。

## 维护约定

- 架构根目录只放总览和团队级入口文档。
- 当前事实、历史计划和未落定研究必须分开存放。
- 决定用 `D<n>` 编号，编号一旦发出去就不复用；修订在原条目下注明日期。
- 文件夹使用英文 `snake_case`；中文文件名表达文档主题。
- 移动或改名后检查全仓 Markdown、C#、README、`AGENTS.md` 和 `CLAUDE.md` 的路径引用。
