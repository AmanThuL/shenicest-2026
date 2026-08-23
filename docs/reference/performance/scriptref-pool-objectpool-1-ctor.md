---
title: "Scripting API: Pool.ObjectPool<T> constructor"
page_title: "Unity - Scripting API: Pool.ObjectPool_1.ObjectPool<T0>"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1-ctor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Pool.ObjectPool_1-ctor.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ObjectPool\<T0> Constructor

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

## Declaration

public <span class="sig-kw">ObjectPool\<T0></span>(Func\<T> <span class="sig-kw">createFunc</span>, Action\<T> <span class="sig-kw">actionOnGet</span>, Action\<T> <span class="sig-kw">actionOnRelease</span>, Action\<T> <span class="sig-kw">actionOnDestroy</span>, bool <span class="sig-kw">collectionCheck</span>, int <span class="sig-kw">defaultCapacity</span>, int <span class="sig-kw">maxSize</span>);

### Parameters

| Parameter       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| createFunc      | Method called to create a new instance when the pool is empty. In most cases, this is a simple method that just returns a newly constructed instance of the pooled type.                                                                                                                                                                                                                                                                                                                                  |
| actionOnGet     | Method called when the instance is taken from the pool. Use this to set up and activate the instance.                                                                                                                                                                                                                                                                                                                                                                                                     |
| actionOnRelease | Method called when the instance is returned to the pool. Use this to clean up and deactivate the instance.                                                                                                                                                                                                                                                                                                                                                                                                |
| actionOnDestroy | Method called when an instance can't be returned to the pool because the pool has reached its maximum size.                                                                                                                                                                                                                                                                                                                                                                                               |
| collectionCheck | If true, collection checks are performed when an instance is returned to the pool and an exception is thrown if the instance is already in the pool. Collection checks are only performed in the Editor and not in Player builds. If false, no collection checks are performed.                                                                                                                                                                                                                           |
| defaultCapacity | The default capacity of the pool at creation as a number of object instances. This is the starting capacity of the stack-like structure the pool uses for internal storage. Note that this does not mean this number of instances are created at construction: they're created individually on each call to `Get`, which invokes `createFunc`. When the pool reaches `defaultCapacity`, it expands to accommodate any additional instances returned to it, but only up to the limit defined by `maxSize`. |
| maxSize         | The maximum number of object instances that the pool can hold. The pool can expand from its starting `defaultCapacity` up to `maxSize` and no further. When the pool reaches the `maxSize` then any further instances returned to the pool are ignored and can be garbage collected. Use this to prevent the pool growing beyond a pre-defined limit.                                                                                                                                                     |

### Description

Creates a new ObjectPool instance.

``` codeExampleCS
using System.Text;
using UnityEngine;
using UnityEngine.Pool;

// This component returns the particle system to the pool when the OnParticleSystemStopped event is received.
[RequireComponent(typeof(ParticleSystem))]
public class ReturnToPool : MonoBehaviour

    void OnParticleSystemStopped()
    
}

// This example spans a random number of ParticleSystems using a pool so that old systems can be reused.
public class PoolExample : MonoBehaviour

    public PoolType poolType;

    // Collection checks will throw errors if we try to release an item that is already in the pool.
    public bool collectionChecks = true;
    public int maxPoolSize = 10;

    IObjectPool<ParticleSystem> m_Pool;

    public IObjectPool<ParticleSystem> Pool
    
            return m_Pool;
        }
    }

    ParticleSystem CreatePooledItem()
    
    // Called when an item is returned to the pool using Release
    void OnReturnedToPool(ParticleSystem system)
    
    // Called when an item is taken from the pool using Get
    void OnTakeFromPool(ParticleSystem system)
    
    // If the pool capacity is reached then any items returned will be destroyed.
    // We can control what the destroy behavior does, here we destroy the GameObject.
    void OnDestroyPoolObject(ParticleSystem system)
    
    void OnGUI()
    
        }
    }
}
```
