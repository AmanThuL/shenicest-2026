---
title: "Scripting API: MonoBehaviour.StartCoroutine"
page_title: "Unity - Scripting API: MonoBehaviour.StartCoroutine"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).StartCoroutine

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html" class="switch-link gray-btn sbtn left show" title="Go to MonoBehaviour Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public [Coroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html) <span class="sig-kw">StartCoroutine</span>(IEnumerator <span class="sig-kw">routine</span>);

### Description

Starts a coroutine.

The execution of a coroutine can be paused at any point using the `yield` statement. When a `yield` statement is used, the coroutine pauses execution and automatically resumes at the next frame. For more information, refer to [Write and run coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html) in the manual.  
  
Coroutines are useful for modeling behavior over several frames. The `StartCoroutine` method returns upon the first `yield return`, however you can also `yield` the result, which waits until the coroutine has finished execution. There is no guarantee coroutines end in the same order they started, even if they finish in the same frame.  
  
Yielding of any type, including `null`, results in the execution coming back on a later frame, unless the coroutine is stopped or has completed. If the coroutine runs to completion without yielding (for example, if the `yield` statement is unreachable), `StartCoroutine` returns `null`.  
  
To stop a coroutine, use [MonoBehaviour.StopCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html) or [MonoBehaviour.StopAllCoroutines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopAllCoroutines.html).  
  
Additional resources: [Coroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html), [YieldInstruction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html)

``` codeExampleCS
// This example invokes a coroutine and continues executing the function in parallel.

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    // every 2 seconds perform the print()
    private IEnumerator WaitAndPrint(float waitTime)
    
    }
}
```

``` codeExampleCS
// This example invokes a coroutine and waits until it is completed.

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    // suspend execution for waitTime seconds
    IEnumerator WaitAndPrint(float waitTime)
    
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [Coroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html) <span class="sig-kw">StartCoroutine</span>(string <span class="sig-kw">methodName</span>, object <span class="sig-kw">value</span> = null);

### Description

Starts a coroutine named `methodName`.

In most cases it's preferable to use the version of `StartCoroutine` that accepts an `IEnumerator` parameter, because it has lower runtime overhead. However, `StartCoroutine` with a string `methodName` lets you use [MonoBehaviour.StopCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html) with a specific method name.

``` codeExampleCS
// In this example we show how to invoke a coroutine using a string name and stop it.

using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    IEnumerator DoSomething(float someParameter)
    
    }
}
```

A coroutine can start another coroutine and the two can interoperate in several ways, including both coroutines running in parallel. Alternatively, one coroutine can stop the other while it continues itself. In the following example, one coroutine pauses as it starts another one. When the second coroutine finishes, it restarts the first one.

``` codeExampleCS
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExampleClass : MonoBehaviour

    IEnumerator coroutineA()
    
    IEnumerator coroutineB()
    
}
```
