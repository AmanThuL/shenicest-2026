---
title: "Scripting API: WaitForSecondsRealtime"
page_title: "Unity - Scripting API: WaitForSecondsRealtime"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# WaitForSecondsRealtime

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomYieldInstruction.html" class="cl">CustomYieldInstruction</a>

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

Suspends the coroutine execution for the specified real (unscaled) time in seconds.

`WaitForSecondsRealtime` can only be used with a `yield` statement in coroutines.  
  
To wait using scaled time, refer to [WaitForSeconds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class WaitForSecondsExample : MonoBehaviour

    IEnumerator Example()
    
}
```

See Also [MonoBehaviour.StartCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html).

### Properties

| Property                                                                                                       | Description                                                           |
|----------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [waitTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime-waitTime.html) | The given amount of seconds that the yield instruction will wait for. |

### Constructors

| Constructor                                                                                                              | Description                                                                            |
|--------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| [WaitForSecondsRealtime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime-ctor.html) | Creates a yield instruction to wait for a given number of seconds using unscaled time. |

### Inherited Members

### Properties

| Property                                                                                                             | Description                                      |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| [keepWaiting](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomYieldInstruction-keepWaiting.html) | Indicates if coroutine should be kept suspended. |
