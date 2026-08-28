# 工具说明

这里放调试、预览、接线和可视化工具的说明。

切片 00 当前的事件频道调试方式：选中 `Data/Events/` 下的频道资产，Inspector 里就有 Raise 按钮
（`Scripts/Editor/Events/`），用途见 [UI 与前端契约](../contracts/UI与前端契约.md)。

从 shell 驱动 Editor（人和 AI agent）：官方 Unity CLI + `com.unity.pipeline` 的已验证流程——跑测试/构建、进 Play mode、
读 Console、截图、eval C#、打断点，以及包的取舍和 agent 安全规则，见
[unity-cli-agent-workflow.md](unity-cli-agent-workflow.md)（英文；2026-08-25 验证，包是否保留待团队决定）。

模型/绑定/动画资产从 Blender 到 Unity：管线结构（通用导出器 + JSON profile + 每资产参数）、
为什么不走 Unity 的 `.blend` 原生导入、约束是否需要预先 bake、手持道具的 socket 挂接，以及
D14/D15/D16 的 Unity 侧实测结果，见
[Blender到Unity导出管线.md](Blender到Unity导出管线.md)（2026-08-26；Blender 段与 Unity 段均已实测，
**D15 实测不达标，待技术美术定**）。

贴图从 Blender 经 Substance Painter 到 Unity：分段管线（`Tools/pipeline/`）、命名与预设、Painter 远程脚本协议
与探针、Unity 导入设置的自动化，见
[贴图管线.md](贴图管线.md)（2026-08-26；三段均已实测跑通，Painter 12.1.2，无 GUI 自动化；
**材质创作与贴花尚未实现**）。

从任意检查点开始玩（快速迭代，跳过启动画面和主菜单）：`RootsDance > Dev Play > Window` 一键打开 Main 的两个场景、进
Play、把玩家放到某个站点并按命令队列补齐此前应有的世界状态（flag、报告条目）；Play 中可直接跳到别的检查点；也可从 shell
调用。见 [dev-play-checkpoints.md](dev-play-checkpoints.md)（英文；2026-08-27）。

一条命令从当前提交出一个可分享的 zip：`python3 Tools/build/build.py [PROFILE] [--dev] [--package-only]
[--dry-run] [--force]` 跑 preflight 检查、以 `-executeMethod` 无头调用 Unity 构建、再把 `Builds/<PROFILE>/`
打包成按 `RootsDance_<平台>_v<版本>_<日期>_<短 sha>[-dirty][-dev].zip` 命名的压缩包；构建 profile
（`macOS-Release` / `Windows-Release`）由 Editor 菜单 `RootsDance > Build > Create Default Build
Profiles` 生成一次即可。见 [build-and-packaging.md](build-and-packaging.md)（英文；2026-08-28；macOS 路径已验证，
**Windows 路径未经实测，需要一台 Windows 机器**）。
