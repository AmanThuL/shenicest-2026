---
title: "Scripting API: WaitForSeconds"
page_title: "Unity - Scripting API: WaitForSeconds"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# WaitForSeconds

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html" class="cl">YieldInstruction</a>

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

Suspends the coroutine execution for the specified scaled time in seconds.

[WaitForSeconds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds.html) can only be used with a `yield` statement in coroutines.  
  
The real time suspended is equal to the given time divided by [Time.timeScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-timeScale.html). To wait using unscaled time, refer to [WaitForSecondsRealtime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime.html).  
  
The actual length of time waited might not match the time specified for the following reasons:

-   If you start `WaitForSeconds` with duration `t` in a long frame (for example, one which has a long operation which blocks the main thread such as some synchronous loading), the coroutine resumes `t` seconds after the end of the frame rather than `t` seconds after it was called.
-   The coroutine might resume on the first frame after `t` seconds has passed rather than immediately after `t` seconds has passed.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class WaitForSecondsExample : MonoBehaviour

    IEnumerator ExampleCoroutine()
    
}
```

Additional resources: [MonoBehaviour.StartCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html), [AsyncOperation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AsyncOperation.html), [WaitForEndOfFrame](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForEndOfFrame.html), [WaitForFixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForFixedUpdate.html), [WaitForSecondsRealtime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSecondsRealtime.html), [WaitUntil](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitUntil.html), [WaitWhile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitWhile.html).

### Constructors

| Constructor                                                                                              | Description                                                                         |
|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| [WaitForSeconds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/WaitForSeconds-ctor.html) | Suspends the coroutine execution for the given amount of seconds using scaled time. |

### Inherited Members
