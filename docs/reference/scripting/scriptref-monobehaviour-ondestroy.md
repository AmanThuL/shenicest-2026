---
title: "Scripting API: MonoBehaviour.OnDestroy()"
page_title: "Unity - Scripting API: MonoBehaviour.OnDestroy()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDestroy.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDestroy.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnDestroy()

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

Called when a GameObject or component is about to be destroyed.

`OnDestroy` is called in the following scenarios:

-   When a component or its parent GameObject is explicitly destroyed with [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html).
-   When a scene ends or is unloaded, all GameObjects not preserved with a call to [Object.DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html) are destroyed, and their MonoBehaviours receive `OnDestroy`. This includes closing and opening scenes in the Editor, or by using [SceneManager.UnloadSceneAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.UnloadSceneAsync.html) and [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html).
-   On quitting the runtime application, or exiting Play mode in the Editor.

**Note:** `OnDestroy` is only called on GameObjects that have previously been active.  
  
`OnDestroy` cannot be a [coroutine](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html).  
  
**Warning**: If a user suspends your application on a mobile platform, the operating system can quit the application to free up resources. In this case, depending on the operating system, Unity might be unable to call this method. On mobile platforms, it is best practice to not rely on this method to save the state of your application. Instead, consider every loss of application focus as the exit of the application and use [MonoBehaviour.OnApplicationFocus](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnApplicationFocus.html) to save any data.  
  
Additional resources: [MonoBehaviour.OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html).

``` codeExampleCS
// ExampleClass1 includes a button to switch scene, which calls OnDestroy and then switches to
// ExampleClass2. Once ExampleClass2 is active, OnDestroy will be called when the application closes. 
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class ExampleClass1 : MonoBehaviour

    // code that generates a message every second
    void Update()
    
    }

    void OnGUI()
    
    }

    // generate a message before the Start() function
    void OnEnable()
    
    // generate a message when the game shuts down or switches to another Scene
    // or switched to ExampleClass2
    void OnDestroy()
    
}
```

ExampleClass2:

``` codeExampleCS
using UnityEngine;
using UnityEngine.UI;

public class ExampleClass2 : MonoBehaviour

    void OnEnable()
    
    // generate a message when the game shuts down
    void OnDestroy()
    
}
```
