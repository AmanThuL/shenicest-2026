---
title: "Scripting API: Transform.position"
page_title: "Unity - Scripting API: Transform.position"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-position.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-position.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html).position

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html" class="switch-link gray-btn sbtn left show" title="Go to Transform Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>;

### Description

The world space position of the Transform.

The [position](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-position.html) property of a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html)’s [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html), which is accessible in the Unity Editor and through scripts. Alter this value to move a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html). Get this value to locate the [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) in 3D world space.  
  
For more information about the position and axis, refer to [class-Transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html).  
  
You need to instantiate the object in the scene so that it can move on change. Prefab assets are still [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html), but they are not instantiated. For this reason, Unity doesn't use the data from the [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) [position](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-position.html) of the root asset of the Prefab hierarchy.

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

}
```

This example gets the Input from Horizontal and Vertical axes and moves the GameObject up/down or left/right by changing its position.  
  
Another example:

``` codeExampleCS
using UnityEngine;

public class ExampleClass2 : MonoBehaviour

    void InstantiateAbove(GameObject prefab)
    
}
```

This example instantiates the given prefab 5 units above the position of the GameObject using this script.
