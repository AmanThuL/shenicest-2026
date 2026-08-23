---
title: "ObjectPool<T0> (Unity 6.3 Scripting API)"
page_title: "Unity - Scripting API: ObjectPool<T0>"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ObjectPool\<T0>

class in UnityEngine.Pool

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

  

Implements interfaces:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.IObjectPool_1.html" class="cl">IObjectPool&lt;T0&gt;</a>

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

A stack-based pool of object instances of type T, which implements the IObjectPool interface.

Use this class to create a pool of object instances that can be reused to reduce the overhead of instantiating and destroying objects frequently.  
  
The constructor takes delegates as arguments to allow you to define the behavior of the pool when an item is created, taken from the pool, returned to the pool, or destroyed. You can also specify the default capacity of the pool, the maximum size the pool can grow to, and whether to perform collection checks when returning an item to the pool to catch double-release errors.  
  
Use [ObjectPool\<T0>.Get](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.Get.html) to get an instance from the pool. If the pool is empty then a new instance is created using the method passed as the `createFunc` parameter to the constructor. Use [ObjectPool\<T0>.Release](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.Release.html) to return an instance back to the pool. If the pool has reached its maximum size then the instance is destroyed using the method passed as the `actionOnDestroy` parameter to the constructor.  
  
**Important**: `ObjectPool<T>` stores its pooled object instances in a stack-like collection, so don't assume physical contiguity of the objects in memory. `ObjectPool<T>` is not safe to call from background threads.  
  
For more information on the concept and application of object pooling, refer to [Pooling and reusing objects](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reusable-code.html) in the manual.  
  
Additional resources: [IObjectPool\<T0>](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.IObjectPool_1.html)

``` codeExampleCS
using UnityEngine;
using UnityEngine.Pool;

public class SimplePoolExample : MonoBehaviour

    void Update()
    
    }

    // Creates a new pooled GameObject the first time (and whenever the pool needs more).
    private GameObject CreateItem()
    
    // Called when an item is taken from the pool.
    private void OnGet(GameObject pooledObject)
    
    // Called when an item is returned to the pool.
    private void OnRelease(GameObject pooledObject)
    
    // Called when the pool decides to destroy an item (e.g., above max size).
    private void OnDestroyItem(GameObject pooledObject)
    
    private System.Collections.IEnumerator ReturnAfter(GameObject pooledObject, float seconds)
    
}
```

### Properties

| Property                                                                                                            | Description                                                                                                   |
|---------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| [CountActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.CountActive.html)     | Number of objects that have been created by the pool but are currently in use and have not yet been returned. |
| [CountAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.CountAll.html)           | The total number of active and inactive objects.                                                              |
| [CountInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.CountInactive.html) | Number of objects that are currently available in the pool.                                                   |

### Constructors

| Constructor                                                                                               | Description                        |
|-----------------------------------------------------------------------------------------------------------|------------------------------------|
| [ObjectPool_1](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1-ctor.html) | Creates a new ObjectPool instance. |

### Public Methods

| Method                                                                                                  | Description                                                                                                      |
|---------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| [Clear](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.Clear.html)     | Removes all pooled items and invokes the pool's action on destroy callback for each item in the pool.            |
| [Dispose](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.Dispose.html) | Removes all pooled items and invokes the pool's action on destroy callback for each item in the pool.            |
| [Get](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.Get.html)         | Get an instance from the pool. If the pool is empty then a new instance is created.                              |
| [Release](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1.Release.html) | Returns the instance back to the pool. If the pool has reached maximum size, the returned instance is destroyed. |
