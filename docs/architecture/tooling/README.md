# 工具说明

这里放调试、预览、接线和可视化工具的说明。

切片 00 当前的事件频道调试方式：选中 `Data/Events/` 下的频道资产，Inspector 里就有 Raise 按钮
（`Scripts/Editor/Events/`），用途见 [UI 与前端契约](../contracts/UI与前端契约.md)。

从 shell 驱动 Editor（人和 AI agent）：官方 Unity CLI + `com.unity.pipeline` 的已验证流程——跑测试/构建、进 Play mode、
读 Console、截图、eval C#、打断点，以及包的取舍和 agent 安全规则，见
[unity-cli-agent-workflow.md](unity-cli-agent-workflow.md)（英文；2026-08-25 验证，包是否保留待团队决定）。
