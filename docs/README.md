# Project Documentation

This directory contains the game's runtime architecture, design notes, visual-effect notes,
Unity engineering guidelines, and offline Unity reference material.

## Documentation Entry Points

- [运行时架构说明书](architecture/运行时架构说明书.md)：runtime 的 as-built 总览。
- [架构文档索引](architecture/README.md)：架构原则、契约、系统说明、技术决策、研究记录与历史资料。
- [策划与需求索引](design/README.md)：玩法、叙事、关卡和交互需求的归档入口。
- [调研索引](research/README.md)：美术、UI、动效等方向的外部调研与参考资料梳理，尚未落定为正式方案。
- [视觉效果索引](effects/README.md)：光点引导、区域生态变化、头盔 HUD 与其他表现方案的归档入口。
- [Unity 工程规则](guidelines/README.md)：AI 与程序员共用的 Unity 6000.3 工程规则入口，十二份文档，每份带 ≤ 15 行 TL;DR、带依据的规则、代码示例、反模式、review checklist 和资料来源链接。
- [Unity 官方资料快照](reference/README.md)：guidelines 所引用的离线资料库（6000.3 manual、Script Reference、Unity 6 e-books、unity.com how-to、Unity Learn、Unity GitHub 文件）。
- [Odin Inspector 参考](reference/third-party/odin-inspector/README.md)：从插件自带 XML 文档生成的版本精确参考（全部 attribute、部分 editor API、serializer 类型），来源是 `Assets/Plugins/Sirenix/`。
- [`reference/_tools/`](reference/_tools/README.md)：构建/刷新离线资料库的脚本与 manifest，含 Odin 参考生成器。
- [`third-party.md`](third-party.md)：第三方包例外记录——包不能放进 `Assets/ThirdParty/` 时它实际放哪、以及任何不可避免的本地改动。

AI 工具还应从仓库根目录对应入口开始：

- `../AGENTS.md`
- `../CLAUDE.md`

AGENTS.md 携带全部编号的非负性规则（non-negotiables），并向下链接到每份 guideline；每份 guideline 再向下链接到它依据的参考文件：

```
AGENTS.md  ──►  docs/guidelines/README.md  ──►  docs/guidelines/NN-*.md  ──►  docs/reference/<topic>/*.md  ──►  source_url (unity.com / docs.unity3d.com)
                                                                        └─►  docs/reference/third-party/odin-inspector/*.md  ──►  Assets/Plugins/Sirenix/Assemblies/*.xml (vendor XML docs)
```

## Directory Roles

| 目录 | 内容 |
|---|---|
| `architecture/` | 当前架构总览、锁定契约、系统说明、技术决策、研究记录和历史架构资料 |
| `design/` | 策划案、节点流程、叙事文本、关卡需求和玩法规则 |
| `research/` | 尚未落定的外部调研、参考资料梳理和风格方向定义 |
| `effects/` | 已定或待定的视觉表现、音频表现、UI/HUD 表现方案 |
| `guidelines/` | Unity 6000.3 / C# / HDRP / uGUI / 版本控制 / 测试工具链规则 |
| `reference/` | Unity 官方文档与资料的离线 Markdown 快照，含 `reference/third-party/odin-inspector/` |

目录名使用英文 `snake_case`。中文文档保留可读的中文主题名；明确日期统一使用
`YYYY-MM-DD_主题` 前缀。移动或改名后必须同步更新 Markdown 链接、代码注释和仓库内 README。

## Maintaining the docs

- A guideline changes only together with the code/asset convention it describes; update the owning guideline, then `AGENTS.md` if one of the non-negotiables moved.
- Keep every rule traceable: a normative rule links to a reference file or is marked **[project decision]**.
- To add Unity documentation to the reference library, edit `reference/_tools/manifest.json` and run the commands in [`reference/_tools/README.md`](reference/_tools/README.md); then regenerate `reference/README.md`.
- After an Odin Inspector upgrade, run `python3 docs/reference/_tools/build_odin_reference.py` and update the version lines in guidelines 09 and 12 and in `third-party.md`.
