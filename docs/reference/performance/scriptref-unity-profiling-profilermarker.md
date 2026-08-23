---
title: "ProfilerMarker (Script Reference)"
page_title: "Unity - Scripting API: ProfilerMarker"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ProfilerMarker

struct in Unity.Profiling

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Performance marker used for profiling arbitrary code blocks.

Use *ProfilerMarker* to mark up script code blocks for the Profiler.  
The information produced by markers is displayed in the [CPU Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerCPU.html) and can be also captured with [Recorder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Profiling.Recorder.html). During development (in Editor and Development Players) this can help to get performance overview of different parts of game code and identify performance issues.

``` codeExampleCS
using Unity.Profiling;

public class MySystemClass

    }
}
```

*ProfilerMarker* represents a named profiler handle and is the most efficient way of profiling your code. It can be used in jobified code.  
Methods [Begin](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.Begin.html) and [End](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.End.html) are marked with ConditionalAttribute. They are conditionally compiled away and thus have zero overhead in non-Development (Release) builds.  
  
When Profiler collects instrumentation data, *ProfilerMarker* helps to reduce overhead and the amount of transferred data. [Profiler.BeginSample](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Profiling.Profiler.BeginSample.html) transfers full string to the data stream while [ProfilerMarker.Begin](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.Begin.html) and [CustomSampler.Begin](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Profiling.CustomSampler.Begin.html) only integer identifier of the marker.  
  
Also [ProfilerMarker.End](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.End.html) provides a context information to the [Recorder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Profiling.Recorder.html) making it possible to track timings of a marked code in Players.  
  
Additional resources: [Recorder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Profiling.Recorder.html).

### Properties

| Property                                                                                                           | Description                               |
|--------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
| [Handle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.Handle.html) | Gets native handle of the ProfilerMarker. |

### Constructors

| Constructor                                                                                                              | Description                                                   |
|--------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| [ProfilerMarker](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker-ctor.html) | Constructs a new performance marker for code instrumentation. |

### Public Methods

| Method                                                                                                           | Description                                                                                           |
|------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| [Auto](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.Auto.html)   | Creates a helper struct for the scoped using blocks.                                                  |
| [Begin](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.Begin.html) | Begin profiling a piece of code marked with a custom name defined by this instance of ProfilerMarker. |
| [End](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerMarker.End.html)     | End profiling a piece of code marked with a custom name defined by this instance of ProfilerMarker.   |
