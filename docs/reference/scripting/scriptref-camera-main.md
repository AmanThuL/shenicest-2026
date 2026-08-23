---
title: "Scripting API: Camera.main"
page_title: "Unity - Scripting API: Camera.main"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-main.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera-main.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Camera](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.html).main

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html" class="switch-link gray-btn sbtn left show" title="Go to Camera Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public static [Camera](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.html) <span class="sig-kw">main</span>;

### Description

The first enabled Camera component that is tagged "MainCamera" (Read Only).

If there is no enabled Camera component with the "MainCamera" tag, this property is null.  
  
Internally, Unity caches all GameObjects with the "MainCamera" tag. When you access this property, Unity returns the first valid result from its cache. Accessing this property has a small CPU overhead, comparable to calling [GameObject.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html). Where CPU performance is important, consider caching this property.  
  
Additional resources: [Tags](https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html)

``` codeExampleCS
//Place this script on a GameObject to switch between the main Camera and your own second Camera on the press of the "L" key
//Place a second Camera in your Scene and assign it as the "Camera Two" in the Inspector.

using UnityEngine;

public class Example : MonoBehaviour

    void Update()
    
            //Otherwise, if the Main Camera is not enabled, switch back to the Main Camera on a key press
            else if (!m_MainCamera.enabled)
            
        }
    }
}
```
