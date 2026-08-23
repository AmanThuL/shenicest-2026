---
title: "Instrument all function calls (deep profiling)"
page_title: "Unity - Manual: Instrument all function calls"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-deep-profiling.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-deep-profiling.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Instrument all function calls

The Profiler only profiles code timings that are explicitly wrapped in [Profiler markers](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html). This includes the first call stack depth of invocations from Unity’s native code into your scripting code, such as `MonoBehaviour.Start`, `MonoBehaviour.Update`, or similar methods.

The only samples you can visualize as child samples of your scripting code are those that call back into Unity’s API, if that API is instrumented, or any of your own code which has explicit Profiler marker instrumentation. Most API calls that carry a performance overhead are instrumented. For example, accessing the main Camera through the `Camera.main` API registers as a `FindMainCamera` sample.

## Deep profiling

If you want to get data about all function calls to find out where your code impacts on your application’s performance, you can use the **Deep Profile** setting. When you enable the Deep Profile setting, the Profiler injects profiler instrumentation into all your script methods to record all function calls, including at least the first call stack depth into any Unity API.

Deep Profiling is resource-intensive and uses a lot of memory. As a result, your application runs significantly slower while it’s profiling. Deep Profiling works best for small games with simple scripting. If you use complex script code, your application might not be able to use Deep Profiling, and for many larger applications, Deep Profiling might make Unity run out of memory.

### Enabling Deep Profiling

You can enable Deep Profiling if you’re collecting performance data from a connected application, or if you’re collecting data in the Unity Editor.

To enable Deep Profiling for a built application:

1.  Open the **Build Profiles** window (**File** > **Build Profiles**)
2.  Select your application’s target platform
3.  Enable the **Development Build** setting
4.  Enable **Deep Profiling**

To enable Deep Profiling when you collect data in the Editor:

1.  Open the Profiler window (**Window** > **Analysis** > **Profiler**)
2.  Select **Deep Profile** from the [Profiler toolbar](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerWindow.html).

The Profiler then instruments all function calls when you start a profiling session.

## Additional resources

-   [Build Profiles Profile settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-build-settings-reference.html)
-   [Profiler markers introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html)
-   [Collect performance data introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/profiling-collect-data-introduction.html)
