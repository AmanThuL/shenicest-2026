---
title: "Scripting API: Object.FindFirstObjectByType"
page_title: "Unity - Scripting API: Object.FindFirstObjectByType"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).FindFirstObjectByType

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">FindFirstObjectByType</span>();

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">FindFirstObjectByType</span>([FindObjectsInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsInactive.html) <span class="sig-kw">findObjectsInactive</span>);

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">FindFirstObjectByType</span>(Type <span class="sig-kw">type</span>);

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">FindFirstObjectByType</span>(Type <span class="sig-kw">type</span>, [FindObjectsInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsInactive.html) <span class="sig-kw">findObjectsInactive</span>);

### Parameters

| Parameter           | Description                                                                                                                                                         |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| type                | The type of object to find.                                                                                                                                         |
| findObjectsInactive | Whether to include components attached to inactive GameObjects. If you don't specify this parameter, this function doesn't include inactive objects in the results. |

### Returns

**T** Returns the first active loaded object that matches the specified type. If no object matches the specified type, returns null.

### Description

Retrieves the first active loaded object of Type `type`.

Object.FindFirstObjectByType doesn't return Assets (for example meshes, textures, or prefabs), or inactive objects. It also doesn't return objects that have [HideFlags.DontSave](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideFlags.DontSave.html) set.  
  
**Note**: This function is very resource intensive. It's best practice to not use this function every frame and instead, in most cases, use the singleton pattern. Alternatively if you only need any instance of a matching object rather than the first one you can use the faster [Object.FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)  
  
See Also: [Object.FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html), [Object.FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

// Search for the first active TextMesh and first active or inactive CanvasRenderer.
// If found print the names, else print a message saying none were found.
public class ExampleClass : MonoBehaviour

}
```
