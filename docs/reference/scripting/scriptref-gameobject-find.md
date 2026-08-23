---
title: "Scripting API: GameObject.Find"
page_title: "Unity - Scripting API: GameObject.Find"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.Find.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.Find.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).Find

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html" class="switch-link gray-btn sbtn left show" title="Go to GameObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) <span class="sig-kw">Find</span>(string <span class="sig-kw">name</span>);

### Parameters

| Parameter | Description                                           |
|-----------|-------------------------------------------------------|
| name      | The name or hierarchy path of the GameObject to find. |

### Description

Finds and returns a GameObject with the specified name or hierarchy path.

Only returns active GameObjects. Returns `null` if no GameObject with `name` exists. If `name` contains a `/` character, it is treated as a path to the GameObject in the Hierarchy window. If there are multiple GameObjects with the same name, the recommended best practice is to not use this method.  
  
If a path starts with `/`, the first object in the path must not have any parents in the Hierarchy view. Paths that don't start with a `/` can start from a child GameObject. For example, if there is a GameObject named Hand which is a child of Arm which is a child of Monster, you can find it with `/Monster/Arm/Hand` or `Arm/Hand` but not `/Arm/Hand`.  
  
`GameObject.Find` causes significant performance degradation at scale and is not recommended for performance-critical code, especially in [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html). `Find` searches the entire scene and if the game is running with multiple scenes, it searches all of them. The search is linear, checking each GameObject one by one and, in the case of a path, traversing the hierarchy. The result is not cached automatically and every call performs the full search again.  
  
The more GameObjects you have and the more frequently you call `GameObject.Find`, the greater the impact on your application's performance. Instead, cache the result in a member variable at startup, or use [GameObject.FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html).  
  
To find a child GameObject, it's often preferable to use [Transform.Find](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.Find.html), which only searches the children of the specific transform rather than the whole scene.

``` codeExampleCS
using UnityEngine;
using System.Collections;

// This returns the GameObject named Hand in one of the Scenes.

public class ExampleClass : MonoBehaviour

}
```

`GameObject.Find` is useful for automatically connecting references to other objects at load time; for example, inside [MonoBehaviour.Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) or [MonoBehaviour.Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html).  
  
A common pattern is to assign a GameObject to a variable inside [MonoBehaviour.Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html), and use the variable in [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

// Find the GameObject named Hand and rotate it every frame

public class ExampleClass : MonoBehaviour

    void Update()
    
}
```

Additional resources: [GameObject.FindGameObjectsWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindGameObjectsWithTag.html)
