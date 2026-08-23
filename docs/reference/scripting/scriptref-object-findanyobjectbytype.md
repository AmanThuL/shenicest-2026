---
title: "Scripting API: Object.FindAnyObjectByType"
page_title: "Unity - Scripting API: Object.FindAnyObjectByType"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).FindAnyObjectByType

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

public static T <span class="sig-kw">FindAnyObjectByType</span>();

### Returns

**T** Returns an arbitrary active loaded object that matches the specified type. If no object matches the specified type, returns null.

### Description

Retrieves any active loaded object of Type T.

`Object.FindAnyObjectByType` doesn't return assets (for example meshes, textures, or prefabs), or inactive objects. It also doesn't return objects that have [HideFlags.DontSave](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideFlags.DontSave.html) set.  
  
The object that this method returns isn't guaranteed to be the same between calls, but it is always of the specified type. This method is faster than [Object.FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) if you don't need a specific object instance.  
  
See Also: [Object.FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html), [Object.FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

// Search for any object of Types TextMesh and CanvasRenderer,
// if found print the names, else print a message
// that says that it was not found.
public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">FindAnyObjectByType</span>([FindObjectsInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsInactive.html) <span class="sig-kw">findObjectsInactive</span>);

### Parameters

| Parameter           | Description                                                     |
|---------------------|-----------------------------------------------------------------|
| findObjectsInactive | Whether to include components attached to inactive GameObjects. |

### Returns

**T** An arbitrary loaded object that matches the specified type. If no object matches the specified type, returns null.

### Description

Retrieves any loaded object of type T, with the option to include inactive objects.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">FindAnyObjectByType</span>(Type <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                 |
|-----------|-----------------------------|
| type      | The type of object to find. |

### Returns

**Object** An arbitrary active loaded object that matches the specified type. If no object matches the specified type, returns null.

### Description

Retrieves any active loaded object of the specified type.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">FindAnyObjectByType</span>(Type <span class="sig-kw">type</span>, [FindObjectsInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsInactive.html) <span class="sig-kw">findObjectsInactive</span>);

### Parameters

| Parameter           | Description                                                     |
|---------------------|-----------------------------------------------------------------|
| type                | The type of object to find.                                     |
| findObjectsInactive | Whether to include components attached to inactive GameObjects. |

### Returns

**Object** An arbitrary loaded object that matches the specified type. If no object matches the specified type, returns null.

### Description

Retrieves any loaded object of the specified type, with the option to include inactive objects.
