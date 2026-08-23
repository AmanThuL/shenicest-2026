---
title: "Scripting API: Component.TryGetComponent"
page_title: "Unity - Scripting API: Component.TryGetComponent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html).TryGetComponent

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

<span style="color:red;"> </span>

## Declaration

public bool <span class="sig-kw">TryGetComponent</span>(out T <span class="sig-kw">component</span>);

### Parameters

| Parameter | Description                                                |
|-----------|------------------------------------------------------------|
| component | The output argument that contains the component or `null`. |

### Returns

**bool** Returns `true` if the component is found, `false` otherwise.

### Description

Gets the component of the specified type, if it exists.

`TryGetComponent` attempts to retrieve the component of type `T` on the same GameObject as the component it's called on. For more information on usage and behavior of the search, refer to [Component.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html). The difference between this and [Component.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html) is that `TryGetComponent` doesn't allocate in the Editor if the requested component doesn't exist.  
  
**Note**: This method doesn't search the hierarchy of parent or child GameObjects, but is confined to the GameObject the component it's called on is attached to. Because it only checks that GameObject, `TryGetComponent` returns the requested component whether the GameObject is active or inactive. The active state affects only the hierarchy-traversing methods such as [Component.GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html), which take an `includeInactive` parameter.

``` codeExampleCS
using UnityEngine;

public class TryGetComponentExample : MonoBehaviour

    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public bool <span class="sig-kw">TryGetComponent</span>(Type <span class="sig-kw">type</span>, out [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">component</span>);

### Parameters

| Parameter | Description                                                |
|-----------|------------------------------------------------------------|
| type      | The type of component to search for.                       |
| component | The output argument that contains the component or `null`. |

### Returns

**bool** Returns `true` if the component is found, `false` otherwise.

### Description

The non-generic version of this method.

This version of TryGetComponent is not as efficient as the Generic version (above), so you should only use it if necessary.
