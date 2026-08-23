---
title: "Scripting API: MonoBehaviour.Awake()"
page_title: "Unity - Scripting API: MonoBehaviour.Awake()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).Awake()

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

### Description

Unity calls `Awake` when loading an instance of a script component.

Unity calls `Awake` only once during the lifetime of the script instance. A script's lifetime lasts until the script is destroyed or the scene that contains it is unloaded. If the scene is loaded again, Unity loads the script instance again and calls `Awake` again. If the scene is loaded multiple times additively, Unity loads several script instances, and `Awake` is called once for each instance.  
  
Unity calls `Awake` on `MonoBehaviour` script components when whichever of the following scenarios occurs first in the script instance's lifetime:

-   The GameObject the script is attached to is active in the Hierarchy ([GameObject.activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) == `true`) and initializes on scene load.
-   The GameObject the script is attached to goes from inactive ([GameObject.activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) == `false`) to active ([GameObject.activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) == `true`) for the first time.
-   An active GameObject the script is attached to is created with [Object.Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html) and initializes.

Unity calls `Awake` regardless of the value of [Behaviour.enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html) for the script component itself, as long as the other conditions are met.  
  
Use `Awake` to initialize variables or states before the application starts.  
  
For active GameObjects in a scene, Unity calls `Awake` after all active GameObjects in the scene are initialized, so you can safely use methods such as [GameObject.FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html) to query other GameObjects.  
  
The order in which Unity calls each GameObject's `Awake` is not deterministic and you can't rely on `Awake` being called on one GameObject before or after another. For example, don't assume that a reference set up by one GameObject's `Awake` will be usable in another GameObject's `Awake`. Instead, you should use `Awake` to set up references between scripts, and use [Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html), which is called after all `Awake` calls are finished, to pass any information back and forth.  
  
`Awake` is always called before any [Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html) functions. This allows you to order initialization of scripts. `Awake` is called even if the script is a disabled component of an active GameObject. If a script component's `Awake` throws an exception, Unity disables the component. `Awake` cannot act as a coroutine.  
  
Use `Awake` instead of the constructor for initialization, as the serialized state of the component is undefined at construction time. `Awake` is called once, just like the constructor.  
  
For more information on the order of execution for event functions, refer to [Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html) in the manual.

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

}
```

An inactive [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) can be activated when [GameObject.SetActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html) is called on it.  
  
  
The following two example scripts **Example1** and **Example2** work together, and illustrate two timings when Awake() is called.  
To reproduce the example, create a scene with two GameObjects Cube1 and Cube2. Assign Example1 as a script component to Cube1, and set Cube1 as inactive, by unchecking the Inspector top-left check box (Cube1 will become invisible). Assign Example2 as a script component to Cube2, and set Cube1 as its `GO` variable.  
Enter Play mode: pressing the space key will execute code in Example2.Update that activates Cube1, and causes Example1.Awake() to be called.

``` codeExampleCS
using UnityEngine;

// Make sure that Cube1 is assigned this script and is inactive at the start of the game.

public class Example1 : MonoBehaviour

    void Start()
    
    void Update()
    
    }
}
```

Example2. This causes Example1.Awake() to be called. The Space key is used to perform this:

``` codeExampleCS
using UnityEngine;

public class Example2 : MonoBehaviour

    void Start()
    
    // track if Cube1 was already activated
    private bool activateGO = true;

    void Update()
    
        }
    }
}
```
