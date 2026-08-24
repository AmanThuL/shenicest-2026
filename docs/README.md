# Project Documentation

This directory contains the game's runtime architecture, design notes, visual-effect notes,
Unity engineering guidelines, and offline Unity reference material.

## Documentation Entry Points

- [运行时架构说明书](architecture/运行时架构说明书.md)：runtime 的 as-built 总览。
- [架构文档索引](architecture/README.md)：架构原则、契约、系统说明、技术决策、研究记录与历史资料。
- [策划与需求索引](design/README.md)：玩法、叙事、关卡和交互需求的归档入口。
- [视觉效果索引](effects/README.md)：光点引导、区域生态变化、头盔 HUD 与其他表现方案的归档入口。
- [Unity 工程规则](guidelines/README.md)：AI 与程序员共用的 Unity 6000.3 工程规则入口。
- [Unity 官方资料快照](reference/README.md)：guidelines 所引用的离线资料库。

AI 工具还应从仓库根目录对应入口开始：

- `../AGENTS.md`
- `../CLAUDE.md`

## Directory Roles

| 目录 | 内容 |
|---|---|
| `architecture/` | 当前架构总览、锁定契约、系统说明、技术决策、研究记录和历史架构资料 |
| `design/` | 策划案、节点流程、叙事文本、关卡需求和玩法规则 |
| `effects/` | 已定或待定的视觉表现、音频表现、UI/HUD 表现方案 |
| `guidelines/` | Unity 6000.3 / C# / URP / UI Toolkit / 版本控制 / 测试工具链规则 |
| `reference/` | Unity 官方文档与资料的离线 Markdown 快照 |

目录名使用英文 `snake_case`。中文文档保留可读的中文主题名；明确日期统一使用
`YYYY-MM-DD_主题` 前缀。移动或改名后必须同步更新 Markdown 链接、代码注释和仓库内 README。
