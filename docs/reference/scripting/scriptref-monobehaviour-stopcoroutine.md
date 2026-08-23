---
title: "Scripting API: MonoBehaviour.StopCoroutine"
page_title: "Unity - Scripting API: MonoBehaviour.StopCoroutine"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StopCoroutine.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).StopCoroutine

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

public void <span class="sig-kw">StopCoroutine</span>(string <span class="sig-kw">methodName</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">StopCoroutine</span>(IEnumerator <span class="sig-kw">routine</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">StopCoroutine</span>([Coroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html) <span class="sig-kw">routine</span>);

### Parameters

| Parameter  | Description                                         |
|------------|-----------------------------------------------------|
| methodName | Name of coroutine.                                  |
| routine    | Name of the function in code, including coroutines. |

### Description

Stops the first coroutine named `methodName`, or the coroutine stored in `routine` running on this behaviour.

`StopCoroutine` takes one of three arguments that specify which coroutine to stop:

-   A string function naming the active coroutine.
-   The `IEnumerator` variable used earlier to create the coroutine.
-   The `Coroutine` to stop the manually created `Coroutine`.

You must use the same parameter type to stop a coroutine with `StopCoroutine` as was used to start it with [StartCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html).  
  
Coroutines also stop if:

-   The value of [GameObject.activeSelf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html) becomes \`false\` for the GameObject the script is attached to.
-   The MonoBehaviour script is destroyed with a call to [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html).

**Note**: Disabling the MonoBehaviour script by setting [Behaviour.enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html) to \`false\` doesn't stop coroutines.  
  
`StopCoroutine(null)` throws a NullReferenceException. Add checks to your code to ensure the argument is not null before calling `StopCoroutine`.  
  
The following example uses the [IEnumerator](https://msdn.microsoft.com/en-us/library/system.collections.ienumerator(v=vs.110).aspx) to stop a coroutine.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class Example : MonoBehaviour

    // print to the console every 3 seconds.
    // yield is causing WaitAndPrint to pause every 3 seconds
    public IEnumerator WaitAndPrint(float waitTime)
    
    }

    void Update()
    
    }
}
```

The following example uses the [Coroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html) parameter to stop a coroutine.

``` codeExampleCS
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExampleClass : MonoBehaviour

    IEnumerator coroutineA()
    
    IEnumerator coroutineB()
    
        // Intended to handling exit of the this coroutine.
        // However coroutineA() shuts coroutineB() down. This
        // means the following lines are not called.
        float t = Time.time - start;
        Debug.Log("coroutineB() finished " + t);
        yield return null;
    }
}
```
