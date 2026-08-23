---
title: "Scripting API: Transform.forward"
page_title: "Unity - Scripting API: Transform.forward"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-forward.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-forward.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html).forward

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

<span style="color:red;"> </span>public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">forward</span>;

### Description

Returns a normalized vector representing the blue axis of the transform in world space.

Unlike [Vector3.forward](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3-forward.html), which is a constant direction in world space, [Transform.forward](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-forward.html) is the local forward direction for this GameObject. Rotating this GameObject will change the [Transform.forward](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-forward.html) direction.  
  
The example below shows how to manipulate a GameObject’s position along the Z axis (blue axis) of the transform in world space.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
        if (Input.GetKey(KeyCode.DownArrow))
        
        if (Input.GetKey(KeyCode.RightArrow))
        
        if (Input.GetKey(KeyCode.LeftArrow))
        
    }
}
```

Another example:

``` codeExampleCS
using UnityEngine;

// Computes the angle between the direction of the target from this object and this object's viewing direction (forward).

public class Example : MonoBehaviour

}
```
