---
title: "Using a custom update manager (Unity 6.3 Manual)"
page_title: "Unity - Manual: Using a custom update manager"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/events-per-frame-optimization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/events-per-frame-optimization.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Using a custom update manager

Unity’s built-in per-frame [event function](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html) updates such as [`Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html), [`FixedUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.FixedUpdate.html) and [`LateUpdate`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.LateUpdate.html) can impact performance at scale. Although the corresponding callbacks are invoked on your C# MonoBehaviour scripts, the function calls originate from Unity’s native code. Unity has to maintain internal lists to track which objects to call these update functions on. MonoBehaviour script instances are added to or removed from these lists when they are enabled or disabled, respectively.

While it’s convenient to add the appropriate callbacks to every MonoBehaviour instance in your project that requires them, this becomes more inefficient as the number of callbacks grows. There is a small but significant overhead to invoking managed-code callbacks from native code, which leads to the following consequences:

-   Degraded frame times when invoking large numbers of `Update` callbacks.
-   Degraded instantiation times when [instantiating prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs.html) that contain large numbers of MonoBehaviours, due to the performance overhead of invoking `Awake` and `OnEnable` callbacks on each component in a prefab.

To avoid these issues, instead of relying on built-in callbacks you can create a global custom update manager singleton instance and have MonoBehaviour scripts, or even standard C# objects, subscribe to it. This way, the update manager singleton can distribute `Update`, `LateUpdate`, and other callbacks to all objects that have subscribed to them, and all update code stays in the managed layer. This has the additional benefit of allowing code to unsubscribe from callbacks when they have no operation to perform, which reduces the number of functions that must be called each frame.

## When to use a custom update manager

A custom update manager can be beneficial when the number of MonoBehaviour instances with per-frame update callbacks reaches the hundreds or thousands.

You can improve performance significantly by eliminating callbacks that rarely execute. Consider the following example:

``` lang-cs
void Update() 
// … some operation …
}
```

If your project has many MonoBehaviours with `Update` callbacks similar to this, then a significant amount of the time consumed running `Update` callbacks is spent switching between native and managed code domains for MonoBehaviour execution that then exits immediately. If these classes instead subscribe to a global update manager only while `someVeryRareCondition` is true, and unsubscribe thereafter, then less time is spent both on switching code domains and evaluating the rare condition.

**Important**: A custom update manager is not a one-size-fits-all solution. It’s important to [profile](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) your project to determine its specific performance issues and whether a custom update manager is appropriate. Depending on the specific performance bottlenecks in your project, other ways to optimize performance include converting your project to use the Entity Component System (ECS) architecture, or [customizing the Player loop](https://docs.unity3d.com/6000.3/Documentation/Manual/player-loop-customizing.html).

## Example custom update manager

To implement a custom update manager, first create a C# script to define the interface as follows:

``` lang-cs
public interface IUpdatable

```

You can then create a MonoBehaviour script for the update manager singleton. The update manager implements the built-in `Update` callback and then other MonoBehaviour script components can subscribe to this update manager rather than to `Update` directly:

``` lang-cs
// Singleton update manager. Attach to a GameObject in your scene.

using System.Collections.Generic;
using UnityEngine;

public class UpdateManager : MonoBehaviour

    public void Register(IUpdatable updatable)
    
    public void Unregister(IUpdatable updatable)
    
    void Update()
    
    }
}
```

Finally, create a MonoBehaviour script component that registers itself with the update manager instance on enable and de-registers itself on disable. The following example uses the custom update callback to move the parent GameObject:

``` lang-cs
// Script component. Attach to a GameObject in your scene to move it on each custom update.

using UnityEngine;

public class MyMovingObject : MonoBehaviour, IUpdatable

    void OnDisable()
    
    public void CustomUpdate(float deltaTime)
    
}
```

## Additional resources

-   <span aria-hidden="true">📚</span> **Documentation**: [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html)
-   <span aria-hidden="true">📚</span> **Documentation**: [Event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html)
-   <span aria-hidden="true">📚</span> **Documentation**: [10000 Update calls](https://unity.com/blog/engine-platform/10000-update-calls)
