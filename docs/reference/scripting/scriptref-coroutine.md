---
title: "Scripting API: Coroutine"
page_title: "Unity - Scripting API: Coroutine"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Coroutine.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Coroutine

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

[MonoBehaviour.StartCoroutine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.StartCoroutine.html) returns a Coroutine. Instances of this class are only used to reference these coroutines, and do not hold any exposed properties or functions.

A coroutine is a function that can suspend its execution (yield) until the given [YieldInstruction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/YieldInstruction.html) finishes.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    IEnumerator Start()
    
}
```

This example shows a normal Start:

``` codeExampleCS
using UnityEngine;
using System.Collections;

// In this example we show how to invoke a coroutine and execute
// the function in parallel.  Start does not need IEnumerator.

public class ExampleClass : MonoBehaviour

    private IEnumerator WaitAndPrint(float waitTime)
    
}
```

### Inherited Members
