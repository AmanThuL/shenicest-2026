# 契约：UI 与前端

> 前端工程师（UI owner）↔ gameplay 程序 ↔ UI 美术 三方的接线方式。
> 上层规则：[运行时架构 D3.1 / D3.2](../运行时架构说明书.md)（一个 UI 文件属于哪一层，由它发命令还是读事件决定）。
> 状态：三个 presenter 已落地 · 最后修订 2026-08-26
> UI 框架为 uGUI（[`guidelines/09`](../../guidelines/09-packages-systems.md#ugui-runtime-ui)）。**本文描述的是目标状态：仓库里现有的 presenter 与 `MainMenu` 仍是 UI Toolkit 实现，代码迁移是一个独立任务。**

---

## D19 —— 谁出什么

UI 走 uGUI（[`guidelines/09`](../../guidelines/09-packages-systems.md) 第 7 条）：**一个界面 = `Prefabs/UI/` 下的一个 prefab**，Bootstrap 里一个 Screen Space – Overlay 的 `Canvas` 根加一个 `EventSystem`，所有文字用 `TextMeshProUGUI`。三方各自交付什么文件，完整列在 [场景与资产所有权](场景与资产所有权.md#全项目所有权表)——那份文档是文件归属的唯一权威来源，这里不重复。

**一个文件只能有一个 owner。** UI 美术交稿（`UI/Sprites/`、`UI/Fonts/`、视觉稿与配色规范），不直接改 `Prefabs/UI/` 下的 prefab。若团队实际习惯是 UI 美术自己搭 prefab，就把这条反过来写——但必须二选一。

界面 prefab 是 YAML，**不可手工 merge**（[`guidelines/06`](../../guidelines/06-version-control.md)）。所以一个界面一个 prefab、一个 owner；两个人要同时改同一个界面，先在群里说，拆成两个 prefab 或排队改。

世界空间里的文字标签用 **TextMesh Pro 3D Text**。
头盔 HUD 是 screen-space overlay 的 canvas（污染浓度 / 信号强度）+ 相机上一个面罩 mesh 或全屏贴图，**不做 world-space UI**。

---

## 编译器强制的边界

`Scripts/Runtime/UI/` **只允许**：

```csharp
using RootsDance.Core;      // 只读数据类型：ReportEntry / ReportUpdate / IWorldStateReader
using RootsDance.Events;    // 频道资产
using TMPro;
using UnityEngine;
using UnityEngine.UI;
```

出现 `using RootsDance.Player` / `Interaction` / `Investigation` / `World` / `App` 就是越界，review 直接打回。

这条能成立，是因为需要的数据都由事件载荷带过来了——例如「土壤样本：01」里的计数由 `GameBootstrap` 算好装进 `ReportUpdate.CategoryCount`，presenter 不需要去读世界状态。

**发命令的 UI 怎么办**：见 [运行时架构 D3.2](../运行时架构说明书.md#d32--会发命令的-ui-只-raise-频道不-enqueue-命令)——UI 只 raise 频道，由 gameplay 侧的监听器翻译成命令。切片 00 没有这种 UI。

---

## 界面元素契约

presenter 通过 `[SerializeField]` 引用拿到每个控件，所以接口是 **presenter 的字段 + prefab 里必须存在的那几个控件**，不再是元素名字符串。改样式、改层级、改排版随意；**删控件或换组件类型等于改接口**。

| prefab 内控件（GameObject 名） | 组件 | 用途 | 消费者 |
|---|---|---|---|
| `SubtitleText` | TextMeshProUGUI | 无线电 / 内心独白 / 设备提示 / 调查结果 | `SubtitlePresenter` |
| `PromptLabel` | TextMeshProUGUI | 准星下方的「采样 / 识别」提示 | `InteractionPromptPresenter` |
| `ReportToast` | 容器 GameObject（整体显隐） | 报告更新提示的容器 | `ReportToastPresenter` |
| `ReportToastTitle` | TextMeshProUGUI | 「官方探索报告已更新」 | `ReportToastPresenter` |
| `ReportToastLine` | TextMeshProUGUI | 「土壤样本：01」 | `ReportToastPresenter` |

控件被删掉或换了类型，Inspector 里对应字段会变成 `None`，Play 时抛 `NullReferenceException`——这是有意的：接口断了要在编辑器里就看得见，而不是运行时静默失效。

---

## 频道契约

`Data/Events/` 下的资产是两侧之间的数据管道。**新增频道要双方同意**（一方发一方收，缺一头就是死代码）。

| 资产 | 类型 | 谁发 | 谁收 |
|---|---|---|---|
| `FlagRaised` | String | GameBootstrap | RadioSequencePlayer、HelmetController、美术的 View 组件 |
| `ReportUpdated` | Report Update | GameBootstrap | ReportToastPresenter |
| `InteractionPrompt` | String | InteractionRaycaster | InteractionPromptPresenter |
| `RadioLine` | String | RadioSequencePlayer | SubtitlePresenter |
| `Monologue` | String | InvestigationService | SubtitlePresenter |
| `Notice` | String | InvestigationService、HelmetController | SubtitlePresenter |
| `InvestigationResult` | String | InvestigationService | SubtitlePresenter（正式版应换成独立结果面板） |
| `LoadLevelRequested` | Level | 菜单 / GameBootstrap | GameBootstrap |

---

## 前端怎么在没有关卡的情况下开工

每个频道资产（`Data/Events/` 下的 `.asset`）的 Inspector 里都有一个 **Raise** 按钮（`Scripts/Editor/Events/`，每种频道类型一个 `CustomEditor`）。选中资产、按 Play、点 Raise，就能驱动 HUD，也能伪造一条报告更新——不用打开任何独立窗口，不用先知道项目里有哪些频道。这是官方 [ScriptableObject 事件频道教程](https://unity.com/how-to/scriptableobjects-event-channels-game-code) 本身给的调试方式：Raise 按钮长在资产自己身上，不是另开一个窗口列出全项目的频道。

推荐做法：在 `Assets/_Sandbox/<用户名>/` 建一个自己的沙盒场景，放 `HUD.prefab`，全部 UI 都能在里面做完，完全不依赖 gameplay 进度和关卡搭建。

**具体例子**：`RootsDance > Build UI Sandbox (Test)` 菜单（`Scripts/Editor/Tools/SandboxUiTestBuilder.cs`）一键把这套沙盒搭出来，落在 `Assets/_Sandbox/UISandboxDemo/`（团队共用的演示位置，跟个人的 `_Sandbox/<用户名>/` 分开）：

1. 菜单执行后会补全缺失的频道资产（`InteractionPrompt`、`RadioLine`、`Monologue`、`Notice`、`InvestigationResult`），生成界面所需的资产，把三个 presenter（`InteractionPromptPresenter` / `ReportToastPresenter` / `SubtitlePresenter`）挂到 `Test_HUD.prefab` 上并接好对应频道，再建一个只放这个 prefab 实例的 `Test_UISandbox.unity`。
2. 打开 `Test_UISandbox.unity`，按 Play。
3. 在 Project 窗口选中 `Data/Events/InteractionPrompt.asset`，Inspector 里填一段文字，点 **Raise**——HUD 上的对应文本立刻出现，全程没有加载任何关卡、没有玩家、没有 gameplay 代码在跑。
4. `Test_` 前缀的文件都是一次性产物，不要往 `Assets/RootsDance/UI/` 或 `Prefabs/UI/` 里搬；那两个目录是 UI owner 的正式交付物，归属见[场景与资产所有权](场景与资产所有权.md)。

注：**`LoadLevelRequested` 没有 Raise 按钮，这是故意的**：要测关卡加载，直接玩关卡，不需要伪造这个事件。

---

## 读取侧的规矩

常驻 UI 不 pull，只订阅频道。会被反复打开的面板（报告、手记）在 `OnEnable` 里用 `IWorldStateReader` 读一次当前状态铺满列表，之后订阅频道增量更新——**触发点是"面板打开时"而不是"场景初始化时"**。详见 [运行时架构 D6.2](../运行时架构说明书.md)。
