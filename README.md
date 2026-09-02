# 盖娅的舞会 · Where the Roots Dance

**在一个仍然生长的世界里，重新学习如何看见、理解与记录。**

SheNicest 2026 千人黑客松 · G001 · 96 小时 Game Jam · 第一人称 3D 叙事生态解谜

![《盖娅的舞会》主菜单：展开的信封、植物纹样与研究所建筑](docs/submission/images/title-screen.png)

[完整项目介绍](docs/submission/README.md) · [提交版本说明](docs/submission/release-notes.md) · [开发文档](docs/README.md)

## 一场从调查开始的探索

你是一名受安全区派遣的植物研究者，进入一座长期废弃的生态研究遗迹。
任务看似明确：调查环境、采集证据、记录发现，然后带回一份报告。

但植物已经越过人工划定的边界，地下根系与菌丝仍在连接，研究者的私人记录也与正式档案留下了不同的故事。
当新的证据不断出现，你需要重新理解眼前的植物、设施，以及自己正在完成的调查。

> 当旧的规则无法解释一个仍在生长的世界时，我们选择修正世界，还是修正规则？

![雾中的 Briggs 植物研究所入口，植被环绕建筑与旧标牌](docs/submission/images/briggs-entrance.png)

*研究所入口。植物、建筑、光照与人工痕迹，共同构成可以被阅读的环境。*

## 阅读植物，也阅读留下的历史

作品围绕一条探索循环展开：**观察 → 提出判断 → 寻找证据 → 验证 → 重新理解。**

- **探索遗迹。** 通过空间、植物分布、声音和光线寻找方向，留意环境中不协调的细节。
- **调查与验证。** 结合识别、采样、研究设施和环境反馈，理解生态现象与谜题之间的联系。
- **拼合历史。** 阅读研究记录、私人手记与信件，让不同年代的痕迹彼此印证。
- **思考如何记录。** 官方调查与个人观察提供不同的视角；得到答案之后，仍要决定如何面对它。

我们希望带来的成长，是逐渐看见原先没有看见的关系。植物不仅是场景装饰，也是线索、历史与探索的语言。
谜题围绕生命如何响应环境展开，故事则追问：准确的数据，是否就意味着完整的理解？

## 一个仍在生长的研究所

![Briggs 研究所建筑展示：温室玻璃、中央塔楼与攀附其间的植物](docs/submission/images/briggs-architecture.png)

*提交材料中的建筑展示图。人工设施与植物生长共同塑造遗迹的空间层次。*

创作灵感来自女性植物学研究史、地下菌丝网络，以及关注照料、关系与共生的女性科幻想象。
我们把这些观察放进灾后的研究所：那些没有被完整写进正式记录的知识，可能仍在影响今天的生态。

主建筑与核心探索空间由团队制作，非核心环境和装饰结合现成素材完成；场景不仅承载故事，也参与传递线索。
项目介绍中的完整创作背景、玩法设想和开发过程，见[参赛文案 Markdown 归档](docs/submission/README.md)。

## 96 小时里的协作

| 分工 | 主要工作 |
| --- | --- |
| 策划与叙事 | 核心体验、关卡流程、生态谜题、研究记录与文案、进度统筹 |
| 美术 | 建筑与场景、模型和材质、光照氛围、植物与特效、UI 视觉 |
| 程序 | 第一人称探索、交互与调查、谜题和剧情系统、UI 接入、工程与打包 |

团队以核心体验为先，经历范围收束、并行制作、流程整合和试玩打磨，将分散的空间、系统与文本连接成这次 Game Jam Demo。

## 提交版本与后续

**`v0.1.0-shenicest2026`** 固定记录本次 SheNicest 2026 Game Jam 提交版本。
后续打磨继续在 `develop` 推进，通过新的版本标签发布，不覆盖本次提交快照。

这是短周期制作的 Demo，完整项目介绍也包含设计目标与后续设想，并不表示所有机制都已完整实现。
后续希望继续改善探索引导、交互反馈、生态谜题、记录与选择的关系，以及性能和平台适配。

当前验证范围和已知测试问题见[版本说明](docs/submission/release-notes.md)。此标签归档源码，仓库不包含打包后的游戏安装文件。

## 在 Unity 中打开

项目使用 **Unity 6000.3.22f1（Unity 6.3 LTS）**。先安装 Git LFS，再获取提交版本：

```bash
git lfs install
git clone --branch v0.1.0-shenicest2026 https://github.com/AmanThuL/shenicest-2026.git
cd shenicest-2026
git lfs pull
```

在 Unity Hub 中添加仓库根目录，使用指定版本打开。运行入口为
[`Assets/RootsDance/Scenes/Bootstrap.unity`](Assets/RootsDance/Scenes/Bootstrap.unity)。
如需构建桌面程序，请按[构建与打包指南](Tools/build/README.md)操作。

| 技术 | 当前仓库配置 |
| --- | --- |
| 引擎与语言 | Unity 6.3 LTS · C# 9.0 |
| 渲染 | HDRP 17.3 |
| 输入与镜头 | Unity Input System · Cinemachine 3.1 |
| 游戏 UI | uGUI · TextMeshPro |
| 协作 | Git / GitHub / Git LFS · Additive Scenes · UnityYAMLMerge |
| 目标平台 | Windows / macOS 桌面；不支持 Web / 移动端 |

开发前请阅读 [AGENTS.md](AGENTS.md) 与[工程指南](docs/guidelines/README.md)。
第三方素材与插件保留各自的许可要求；复用或分发前请核对资产归属及[第三方包记录](docs/third-party.md)。
