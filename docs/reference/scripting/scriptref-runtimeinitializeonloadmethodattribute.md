---
title: "Scripting API: RuntimeInitializeOnLoadMethodAttribute"
page_title: "Unity - Scripting API: RuntimeInitializeOnLoadMethodAttribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# RuntimeInitializeOnLoadMethodAttribute

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.PreserveAttribute.html" class="cl">Scripting.PreserveAttribute</a>

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

Use this attribute to get a callback when the runtime is starting up and loading the first scene.

Use the various options for [RuntimeInitializeLoadType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.html) to control when the method is invoked in the startup sequence.  
  
The following list shows the execution order of the [RuntimeInitializeLoadType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.html) callbacks:

1.  Various low level systems are initialized (window, assemblies, gfx etc.)
2.  [RuntimeInitializeLoadType.SubsystemRegistration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.SubsystemRegistration.html) and [RuntimeInitializeLoadType.AfterAssembliesLoaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.AfterAssembliesLoaded.html) callbacks are invoked.
3.  More setup (input systems etc.)
4.  [RuntimeInitializeLoadType.BeforeSplashScreen](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.BeforeSplashScreen.html) callback is invoked.
5.  First scene starts loading.
6.  [RuntimeInitializeLoadType.BeforeSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.BeforeSceneLoad.html) callback is invoked. Objects of the scene are loaded but `Awake` hasn't been called yet. All objects are considered inactive.
7.  `Awake` and `OnEnable` are invoked on MonoBehaviours.
8.  [RuntimeInitializeLoadType.AfterSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.AfterSceneLoad.html) callback is invoked. Objects of the scene are considered fully loaded and setup. Active objects can be found with FindObjectsByType.

The above details are when starting up a Player build. When entering Play mode in the Editor the same invocations are ensured.  
  
The default callback invocation time is [RuntimeInitializeLoadType.AfterSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.AfterSceneLoad.html). The execution order within each of the [RuntimeInitializeLoadType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.html) callbacks is not guaranteed.  
  
**Note:** Use the [AlwaysLinkAssemblyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.AlwaysLinkAssemblyAttribute.html) on package or precompiled assemblies that contain one or more methods with the `[RuntimeInitializeOnLoadMethod]` attribute, but which may not contain types used directly or indirectly in any scenes built for the project.  
  
Additional resources: [Managed code stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping.html)

``` codeExampleCS
// Demonstration of the RuntimeInitializeOnLoadMethod attribute
using UnityEngine;

class MyClass

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
    static void OnBeforeSceneLoad()
    
    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
    static void OnAfterSceneLoad()
    
    [RuntimeInitializeOnLoadMethod]
    static void OnRuntimeInitialized()
    
}
```

### Properties

| Property                                                                                                                       | Description                              |
|--------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| [loadType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute-loadType.html) | Controling the callback invocation time. |

### Constructors

| Constructor                                                                                                                                              | Description                                                                |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| [RuntimeInitializeOnLoadMethodAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute-ctor.html) | Use the RuntimeInitializeLoadType to control when the callback is invoked. |

### Inherited Members
