---
title: "Scripting API: Object.FindObjectsByType"
page_title: "Unity - Scripting API: Object.FindObjectsByType"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).FindObjectsByType

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

public static Object\[\] <span class="sig-kw">FindObjectsByType</span>(Type <span class="sig-kw">type</span>, [FindObjectsInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsInactive.html) <span class="sig-kw">findObjectsInactive</span>, [FindObjectsSortMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsSortMode.html) <span class="sig-kw">sortMode</span>);

<span style="color:red;"> </span>

## Declaration

public static Object\[\] <span class="sig-kw">FindObjectsByType</span>(Type <span class="sig-kw">type</span>, [FindObjectsSortMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsSortMode.html) <span class="sig-kw">sortMode</span>);

### Parameters

| Parameter           | Description                                                                                                                                                         |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| type                | The type of object to find. Must be a reference type derived from UnityEngine.Object.                                                                               |
| findObjectsInactive | Whether to include components attached to inactive GameObjects. If you don't specify this parameter, this function doesn't include inactive objects in the results. |
| sortMode            | Whether and how to sort the returned array. Not sorting saves time, which can be significant if the search returns many objects.                                    |

### Returns

**Object\[\]** An array of objects.

### Description

Retrieves a list of all loaded objects of Type `type` and sorts the results according to `sortMode`.

`FindObjectsByType` doesn't return assets (for example meshes, textures, or prefabs). It also doesn't return objects that have [HideFlags.DontSave](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideFlags.DontSave.html) set.Use [Resources.FindObjectsOfTypeAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.FindObjectsOfTypeAll.html) to avoid these limitations.  
  
You can't use `Object.FindObjectsByType` with interfaces directly. Instead, find all components of a base type and then filter the results by interface using LINQ's `OfType`.  
  
In the Editor, `FindObjectsByType` searches the Scene view by default. If you want to find an object in the Prefab stage, use the [StageUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.StageUtility.html) APIs.

``` codeExampleCS
using UnityEngine;

// Ten GameObjects are created and have TextMesh and
// CanvasRenderer components added.
// When the game runs press the Space key to display the
// number of TextMesh and CanvasRenderer components.

public class ScriptExample : MonoBehaviour

    }

    void Update()
    
    }
}
```

Additional resources: [Object.FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html), [Object.FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html).

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T\[\] <span class="sig-kw">FindObjectsByType</span>([FindObjectsSortMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsSortMode.html) <span class="sig-kw">sortMode</span>);

<span style="color:red;"> </span>

## Declaration

public static T\[\] <span class="sig-kw">FindObjectsByType</span>([FindObjectsInactive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsInactive.html) <span class="sig-kw">findObjectsInactive</span>, [FindObjectsSortMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FindObjectsSortMode.html) <span class="sig-kw">sortMode</span>);

### Parameters

| Parameter           | Description                                                                                                                                                         |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| findObjectsInactive | Whether to include components attached to inactive GameObjects. If you don't specify this parameter, this function doesn't include inactive objects in the results. |
| sortMode            | Whether and how to sort the returned array. Not sorting saves time, which can be significant if the search returns many objects.                                    |

### Returns

**T\[\]** The array of objects found matching the type specified.

### Description

Retrieves a list of all loaded objects of Type T.
