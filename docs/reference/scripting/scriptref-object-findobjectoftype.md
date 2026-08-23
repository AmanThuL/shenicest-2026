---
title: "Scripting API: Object.FindObjectOfType (obsolete)"
page_title: "Unity - Scripting API: Object.FindObjectOfType"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectOfType.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectOfType.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity - Scripting API: Object.FindObjectOfType

**Method group is Obsolete**  

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).FindObjectOfType

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

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static T <span class="sig-kw">FindObjectOfType</span>();

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static T <span class="sig-kw">FindObjectOfType</span>(bool <span class="sig-kw">includeInactive</span>);

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static Object <span class="sig-kw">FindObjectOfType</span>(Type <span class="sig-kw">type</span>);

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static Object <span class="sig-kw">FindObjectOfType</span>(Type <span class="sig-kw">type</span>, bool <span class="sig-kw">includeInactive</span>);

### Parameters

| Parameter       | Description                                                                                                                                                         |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| type            | The type of object to find.                                                                                                                                         |
| includeInactive | Whether to include components attached to inactive GameObjects. If you don't specify this parameter, this function doesn't include inactive objects in the results. |

### Returns

**T** **Object** The first active loaded object that matches the specified type. It returns null if no Object matches the type.

### Description

Returns the first active loaded object of Type `type`.

Object.FindObjectOfType will not return Assets (meshes, textures, prefabs, ...) or inactive objects. It will not return an object that has [HideFlags.DontSave](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideFlags.DontSave.html) set.  
  
Please note that this function is very slow. It is not recommended to use this function every frame. In most cases you can use the singleton pattern instead.  
  
**Obsolete**: This function is obsolete, use [Object.FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) as a direct replacement or the faster [Object.FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html) if any object of the specified type is acceptable.  
  
See Also: [Object.FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html), [Object.FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html), Object.FindObjectsOfType.

``` codeExampleCS
using UnityEngine;
using System.Collections;

// Search for any object of Types TextMesh and CanvasRenderer,
// if found print the names, else print a message
// that says that it was not found.
public class ExampleClass : MonoBehaviour

}
```
