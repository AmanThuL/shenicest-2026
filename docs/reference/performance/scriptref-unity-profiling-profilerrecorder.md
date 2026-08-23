---
title: "ProfilerRecorder (Script Reference)"
page_title: "Unity - Scripting API: ProfilerRecorder"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ProfilerRecorder

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

Records the Profiler metric data that a Profiler marker or counter produces.

Use ProfilerRecorder to access performance metrics that the Profiler exposes. You can use it to read Profiler counter data such as memory or render statistics, and Profiler marker timing data in a uniform way.  
  
You can use this API in Editor and Player builds, including Release Players. Use [ProfilerRecorderHandle.GetAvailable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.LowLevel.Unsafe.ProfilerRecorderHandle.GetAvailable.html) to get the full list of supported metrics. For a list of built-in Profiler markers and counters available, refer to [Profiler markers reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-markers.html) and [Profiler counters reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-counters-reference.html).  
  
The following example demonstrates how you can use ProfilerRecorder to get memory and timing statistics.

``` codeExampleCS
using System.Collections.Generic;
using System.Text;
using Unity.Profiling;
using UnityEngine;

public class ExampleScript : MonoBehaviour

        return r;
    }

    void OnEnable()
    
    void OnDisable()
    
    void Update()
    {
        var sb = new StringBuilder(500);
        sb.AppendLine($"Frame Time: {GetRecorderFrameAverage(mainThreadTimeRecorder) * (1e-6f):F1} ms");
        sb.AppendLine($"GC Memory: {gcMemoryRecorder.LastValue / (1024 * 1024)} MB");
        sb.AppendLine($"System Memory: {systemMemoryRecorder.LastValue / (1024 * 1024)} MB");
        statsText = sb.ToString();
    }

    void OnGUI()
    
}
```

**Note:**  
ProfilerRecorder allocates unmanaged resources and implements IDisposable interface. Use [Dispose](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Dispose.html) to free resources when you no longer need to record statistics.  
  
ProfilerRecorder gives you access to Unity metrics in two modes: immediate access to a value of a counter, and the counter value when the frame ends. Additional resources: [CurrentValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.CurrentValue.html), [LastValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.LastValue.html), [GetSample](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.GetSample.html), [ProfilerRecorderHandle.GetAvailable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.LowLevel.Unsafe.ProfilerRecorderHandle.GetAvailable.html).

### Properties

| Property                                                                                                                                         | Description                                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| [Capacity](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Capacity.html)                         | Maximum amount of samples ProfilerRecorder can capture.                                   |
| [Count](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Count.html)                               | Collected samples count.                                                                  |
| [CurrentValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.CurrentValue.html)                 | Gets current value of the Profiler metric.                                                |
| [CurrentValueAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.CurrentValueAsDouble.html) | Gets current value of the Profiler metric as double value.                                |
| [DataType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.DataType.html)                         | Value data type of the Profiler metric.                                                   |
| [IsRunning](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.IsRunning.html)                       | Indicates if ProfilerRecorder is attached to the Profiler metric.                         |
| [LastValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.LastValue.html)                       | Gets the last value collected by the ProfilerRecorder.                                    |
| [LastValueAsDouble](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.LastValueAsDouble.html)       | Gets the last value collected by the ProfilerRecorder as double.                          |
| [UnitType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.UnitType.html)                         | Unit type.                                                                                |
| [Valid](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Valid.html)                               | Indicates whether ProfilerRecorder is associated with a valid Profiler marker or counter. |
| [WrappedAround](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.WrappedAround.html)               | Indicates if ProfilerRecorder capacity has been exceeded.                                 |

### Constructors

| Constructor                                                                                                                  | Description                                                                    |
|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| [ProfilerRecorder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder-ctor.html) | Constructs ProfilerRecorder instance with a Profiler metric name and category. |

### Public Methods

| Method                                                                                                                     | Description                                          |
|----------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [CopyTo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.CopyTo.html)       | Copies collected samples to the destination array.   |
| [Dispose](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Dispose.html)     | Releases unmanaged instance of the ProfilerRecorder. |
| [GetSample](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.GetSample.html) | Gets sample data.                                    |
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Reset.html)         | Stops data collection and clears collected samples.  |
| [Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Start.html)         | Start data collection.                               |
| [Stop](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.Stop.html)           | Stops data collection.                               |
| [ToArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.ToArray.html)     | Use to convert collected samples to an array.        |

### Static Methods

| Method                                                                                                                   | Description                                                              |
|--------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [StartNew](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Profiling.ProfilerRecorder.StartNew.html) | Initialize a new instance of ProfilerRecorder and start data collection. |
