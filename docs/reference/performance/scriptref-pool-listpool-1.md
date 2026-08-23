---
title: "ListPool<T0> (Script Reference)"
page_title: "Unity - Scripting API: ListPool<T0>"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ListPool_1.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ListPool_1.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ListPool\<T0>

class in UnityEngine.Pool

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.CollectionPool_2.html" class="cl">Pool.CollectionPool_2</a>

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

A version of [CollectionPool\<T0,T1>](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.CollectionPool_2.html) for Lists.

``` codeExampleCS
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

// This example shows how both version of Get could be used to simplify a line of points.
public class Simplify2DLine

            LineUtility.Simplify(tempList, 1.5f, simplifiedPoints);
        }
        return simplifiedPoints;
    }
}
```

### Inherited Members

### Static Methods

| Method                                                                                                      | Description                                                                              |
|-------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| [Get](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.CollectionPool_2.Get.html)         | Get an instance from the pool. If the pool is empty then a new instance will be created. |
| [Release](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.CollectionPool_2.Release.html) | Returns the instance back to the pool.                                                   |
