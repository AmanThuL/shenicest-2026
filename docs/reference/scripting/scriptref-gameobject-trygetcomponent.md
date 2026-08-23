---
title: "Scripting API: GameObject.TryGetComponent"
page_title: "Unity - Scripting API: GameObject.TryGetComponent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.TryGetComponent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.TryGetComponent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).TryGetComponent

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html" class="switch-link gray-btn sbtn left show" title="Go to GameObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public bool <span class="sig-kw">TryGetComponent</span>(out T <span class="sig-kw">component</span>);

### Parameters

| Parameter | Description                                                |
|-----------|------------------------------------------------------------|
| component | The `out` parameter that contains the component or `null`. |

### Returns

**bool** Returns `true` if the component is found, `false` otherwise.

### Description

Retrieves the component of the specified type, if it exists.

`TryGetComponent` attempts to retrieve the component of the given type. The difference between this and [GameObject.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html) is that this method doesn't allocate memory in the Editor when the requested component does not exist.  
  
**Note**: This method doesn't search the hierarchy of parent or child GameObjects, but is confined to the GameObject itself. Because it only checks that GameObject, `TryGetComponent` returns the requested component whether the GameObject is active or inactive. The active state affects only the hierarchy-traversing methods such as [GameObject.GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentInChildren.html), which take an `includeInactive` parameter.

``` codeExampleCS
using UnityEngine;

public class TryGetComponentExample : MonoBehaviour

    }
}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [GameObject.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public bool <span class="sig-kw">TryGetComponent</span>(Type <span class="sig-kw">type</span>, out [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">component</span>);

### Parameters

| Parameter | Description                                                    |
|-----------|----------------------------------------------------------------|
| type      | The type of component to search for.                           |
| component | The `out` parameter that will contain the component or `null`. |

### Returns

**bool** Returns `true` if the component is found, `false` otherwise.

### Description

The non-generic version of this method.

This version of `TryGetComponent` is not as efficient as the Generic version (above), so you should only use it if necessary.
