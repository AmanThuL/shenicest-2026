---
title: "Scripting API: MonoBehaviour.OnDrawGizmos"
page_title: "Unity - Scripting API: MonoBehaviour.OnDrawGizmos()"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmos.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmos.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html).OnDrawGizmos()

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

Implement OnDrawGizmos if you want to draw gizmos that can be pickable and are always drawn.

Allows you to quickly pick important objects in your Scene. When you select a child GameObject's gizmo, it selects the parent GameObject. this is because pickability is based on the callback’s host GameObject, not the transform used for drawing. To make a child GameObject’s gizmo directly selectable, implement `OnDrawGizmos` or `OnDrawGizmosSelected` on the child GameObject’s component.  
  
`OnDrawGizmos` uses a mouse position that is relative to the Scene View.  
  
**Note**: If **Auto-hide gizmos** is enabled in the Scene View [preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-scene-view.html), then `OnDrawGizmos` is not called on components that are collapsed in the Inspector.  
  
Use [MonoBehaviour.OnDrawGizmosSelected](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmosSelected.html) to draw gizmos when the GameObject is selected.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

Additional resources: [OnDrawGizmosSelected](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDrawGizmosSelected.html).
