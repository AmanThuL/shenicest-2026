---
title: "Scripting API: Object.FindObjectsOfType"
page_title: "Unity - Scripting API: Object.FindObjectsOfType"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsOfType.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsOfType.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity - Scripting API: Object.FindObjectsOfType

**Method group is Obsolete**  

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).FindObjectsOfType

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

public static Object\[\] <span class="sig-kw">FindObjectsOfType</span>(Type <span class="sig-kw">type</span>);

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static Object\[\] <span class="sig-kw">FindObjectsOfType</span>(Type <span class="sig-kw">type</span>, bool <span class="sig-kw">includeInactive</span>);

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static T\[\] <span class="sig-kw">FindObjectsOfType</span>(bool <span class="sig-kw">includeInactive</span>);

<span style="color:red;"> **Obsolete** </span>

## Declaration

public static T\[\] <span class="sig-kw">FindObjectsOfType</span>();

### Parameters

| Parameter       | Description                                                             |
|-----------------|-------------------------------------------------------------------------|
| type            | The type of object to find.                                             |
| includeInactive | If true, components attached to inactive GameObjects are also included. |

### Returns

**Object\[\]** The array of objects found matching the type specified.

### Description

Gets a list of all loaded objects of Type `type`.

This does not return assets (such as meshes, textures or prefabs), or objects with [HideFlags.DontSave](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideFlags.DontSave.html) set. Objects attached to inactive GameObjects are only included if `includeInactive` is set to true. Use [Resources.FindObjectsOfTypeAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.FindObjectsOfTypeAll.html) to avoid these limitations.  
  
In Editor, this searches the Scene view by default. If you want to find an object in the Prefab stage, see the [StageUtility](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.StageUtility.html) APIs.  
  
**Note**: This function is very slow. It is not recommended to use this function every frame. In most cases you can use the singleton pattern instead.  
  
**Obsolete**: This function is obsolete, use [Object.FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html) instead. This replacement allows you to specify whether to sort the resulting array. FindObjectsOfType() always sorts by InstanceID, so calling FindObjectsByType(FindObjectsSortMode.InstanceID) produces identical results. If you specify not to sort the array, the function runs significantly faster, however, the order of the results can change between calls.

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

Additional resources: [Object.FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html).
