---
title: "Coroutines section (Unity 6.3 Manual)"
page_title: "Unity - Manual: Split tasks across frames with coroutines"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-section.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-section.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Split tasks across frames with coroutines

A coroutine is a method that can suspend execution and resume at a later time. In Unity, this means coroutines can start running in one frame and then resume in another, allowing you to spread tasks across several frames.

| **Topic**                                                                                                                  | **Description**                                                                                                      |
|:---------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------|
| **[Write and run coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html)**                       | Write and run coroutine methods to do work that takes effect over several frames, such as a gradual fade-out effect. |
| **[Analyzing coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-analyzing.html)**                 | Analyze coroutine performance in the Unity Profiler.                                                                 |
| **[Yield instruction reference](https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-yield-instructions.html)** | Yield different custom instructions in your coroutine methods to control when they resume.                           |

## Additional resources

-   [Per frame updates](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html)
-   [PlayerLoop API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html)
