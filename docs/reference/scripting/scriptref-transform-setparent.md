---
title: "Scripting API: Transform.SetParent"
page_title: "Unity - Scripting API: Transform.SetParent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.SetParent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.SetParent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html).SetParent

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

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetParent</span>([Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">p</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetParent</span>([Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, bool <span class="sig-kw">worldPositionStays</span>);

### Parameters

| Parameter          | Description                                                                                                                                                    |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| parent             | The parent Transform to use.                                                                                                                                   |
| worldPositionStays | If true, the parent-relative position, scale and rotation are modified such that the object keeps the same world space position, rotation and scale as before. |

### Description

Set the parent of the transform.

This method is the same as the [parent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform-parent.html) property except that it also lets the [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) keep its local orientation rather than its global orientation. This means for example, if the GameObject was previously next to its parent, setting `worldPositionStays` to false will move the GameObject to be positioned next to its new parent in the same way.  
  
The default value of `worldPositionStays` argument is true.  
  
The following images are of a scene with three GameObjects: a new parent cube, a parent sphere, and a child sphere.  
  
![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/TransformSetParentOriginal.png)  
  
The new parent cube is on the left of the screen and the child sphere is in its original position, next to the parent sphere on the right of the screen.  
  
![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/TransformSetParentWorldTrue.png)  
  
After calling `SetParent` with `worldPositionStays` set to true, all objects are in the same position as their original positions.  
  
![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/TransformSetParentWorldFalse.png)  
  
After calling `SetParent` with `worldPositionStays` set to false, the child sphere is in the same position but is now relative to the new parent cube instead.  
  

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

}
```
