---
title: "Collect performance data in Play mode"
page_title: "Unity - Manual: Collect performance data in Play mode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-play-mode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-play-mode.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Collect performance data in Play mode

Profile in Play mode to quickly test changes and monitor the performance of your application without having to rebuild your application every time.

To profile in Play mode:

1.  Open the Profiler (**Window > Analysis > Profiler**)
2.  Select the Target Selection dropdown, next to Record
3.  Select **Play Mode**

![Profiler window’s Target Selection dropdown](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/profiler-target-player.png)

Unity Profiler minimizes the overhead of profiling the Editor itself and represents any Editor-only activity when profiling Play mode as **EditorLoop** markers.

![Timeline view of Play mode frame](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/profiler-playmode-timeline.png)

**Tip:** Whenever you profile Play mode, open it in a maximized view to run your application at a resolution closer to that of your target device. This directly affects performance issues such as those related to fill rate.

To make sure that windows other than Play mode or the Profiler don’t use up time on the render thread and GPU, which affects performance data, reduce the amount of open Unity Editor windows.

## Additional resources

-   [Collect performance data introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-collect-data-introduction.html)
-   [Collect performance data on a target platform](https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-target-device.html)
-   [Collect performance data about the Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-edit-mode.html)
