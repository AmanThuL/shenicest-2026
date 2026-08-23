---
title: "Profiler introduction"
page_title: "Unity - Manual: Profiler introduction"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-introduction.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Profiler introduction

Analyze the performance of your application with the Profiler.

The Profiler records multiple areas of your application’s performance, and displays that information to you. You can use this information to decide what you might need to optimize in your application, and to test the performance of changes you make.

To open the Profiler window go to **Window** \> **Analysis** \> **Profiler**.

![Profiler window with a frame in the CPU Usage Profiler module selected. The Timeline view is selected in the details pane.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/profiler-cpu-module.png)

You can inspect script code and view how your application uses certain assets and resources that might be slowing it down. You can also compare how your application performs on different devices. The Profiler has several different [Profiler modules](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-modules-introduction.html) which display performance data in areas such as rendering, memory, and audio.

The Profiler is an instrumentation-based profiler, which means that the Profiler uses markers in your application’s code to record detailed timing information about how long the code in each marker takes to execute. The Unity API has profiler markers built in so you can explore the performance of your code, locate performance issues, and identify areas to optimize.

You can also use custom [Profiler markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html) to monitor specific data, or use [Deep Profiling](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-deep-profiling.html) to further customize the data you gather.

## Additional resources

-   [Collect performance data](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-profiling-applications.html)
-   [Profiler modules](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-visualizing-data.html)
-   [Using the Profiler window](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerWindow.html)
