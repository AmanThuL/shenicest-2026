# 架构文档索引（docs/architecture）

《Where the Roots Dance》（Unity 6000.3.22f1 / URP 17.3 / C# 9）的架构文档入口。

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
├── systems/                                # 当前系统和切片的实现级说明
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
| [UI 与前端契约](contracts/UI与前端契约.md) | 前端工程师、gameplay 程序、UI 美术 | UXML 元素名、频道清单和代码边界。 |

## 当前系统

| 文档 | 用途 |
|---|---|
| [切片 00 实施计划](systems/切片00_实施计划.md) | 切片 00 的技术范围、开工顺序、已完成文件清单和明确不做的事。 |
| [切片 00 场景搭建与接线](systems/切片00_场景搭建与接线.md) | Editor 里需要创建和接线的资产、Layer、prefab、场景与自测步骤。 |

## 技术决策与研究

| 文档 | 用途 |
|---|---|
| [测试策略](decisions/测试策略.md) | 真相层单元测试边界、现有 EditMode 测试清单和何时新增测试。 |

## 历史资料

`archive/` 只用于追溯历史决策，不作为当前实现依据。入口与替代来源见
[archive/README.md](archive/README.md)。

## 推荐阅读顺序

1. 了解当前实现：运行时架构说明书。
2. 了解团队边界：程序组工作流与架构原则。
3. 修改跨岗位接口：对应 `contracts/` 文档。
4. 修改具体系统：对应 `systems/` 文档。
5. 查询取舍原因：`decisions/`。

## 维护约定

- 架构根目录只放总览和团队级入口文档。
- 当前事实、历史计划和未落定研究必须分开存放。
- 决定用 `D<n>` 编号，编号一旦发出去就不复用；修订在原条目下注明日期。
- 文件夹使用英文 `snake_case`；中文文件名表达文档主题。
- 移动或改名后检查全仓 Markdown、C#、README、`AGENTS.md` 和 `CLAUDE.md` 的路径引用。
