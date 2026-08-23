---
title: "Scripting API: GameObject.GetComponentInChildren"
page_title: "Unity - Scripting API: GameObject.GetComponentInChildren"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentInChildren.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentInChildren.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).GetComponentInChildren

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

public T <span class="sig-kw">GetComponentInChildren</span>(bool <span class="sig-kw">includeInactive</span> = false);

### Parameters

| Parameter       | Description                                                  |
|-----------------|--------------------------------------------------------------|
| includeInactive | Whether to include inactive child GameObjects in the search. |

### Returns

**T** A Component of the matching type `T`, otherwise `null` if no matching Component is found.

### Description

Retrieves a reference to a component of type T on the specified GameObject, or any child of the GameObject.

This method checks the GameObject on which it is called first, then recurses downwards through all child GameObjects using a depth-first search, until it finds a matching Component of the specified type `T`.  
  
Only active child GameObjects are included in the search, unless you call the method with the `includeInactive` parameter set to `true`, in which case inactive child GameObjects are also included. The GameObject on which the method is called is always searched regardless of this parameter.  
  
The typical usage for this method is to call it on a reference to a different GameObject than the one your script is on. For example:  
  
`myResults = otherGameObject.GetComponentInChildren<ComponentType>()`  
  
However, if you're writing code inside a MonoBehaviour class, you can omit the preceding GameObject reference to perform the search on the same GameObject your script is attached to, and its children. In this instance, you're actually calling [Component.GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html) because the script itself is a type of component, but the result is the same as if you'd referenced the GameObject itself. For example:  
  
`myResults = GetComponentInChildren<ComponentType>()`  
  
`GetComponentInChildren` returns only the first matching component found, and components are not checked in a defined order. If there are multiple components of the specified type and you need to find a specific one, you should use [Component.GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html) and check the list of components returned to identify the one you want.  
  
To find components attached to other GameObjects, you need a [reference to that other GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html#AccessingOtherGameObjects) (or any component attached to that GameObject). You can then call `GetComponentInChildren` on that reference.  
  
**Note**: If the type you request is a derivative of MonoBehaviour and the associated script can't be loaded then this function will return \`null\` for that component.  
  
The following example gets a reference to a hinge joint component on the referenced GameObject, or any of its children, and if found, sets a property on that hinge joint component.

``` codeExampleCS
using UnityEngine;

public class GetComponentInChildrenExample : MonoBehaviour

        else
        
        }
    }
}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">GetComponentInChildren</span>(Type <span class="sig-kw">type</span>);

<span style="color:red;"> </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">GetComponentInChildren</span>(Type <span class="sig-kw">type</span>, bool <span class="sig-kw">includeInactive</span>);

### Parameters

| Parameter       | Description                                                  |
|-----------------|--------------------------------------------------------------|
| type            | The type of Component to retrieve.                           |
| includeInactive | Whether to include inactive child GameObjects in the search. |

### Returns

**Component** A component of the matching type, if found.

### Description

This is the non-generic version of this method.

This version of `GetComponentInChildren` is not as efficient as the Generic version (above), so you should only use it if necessary.

``` codeExampleCS
using UnityEngine;

public class GetComponentInChildrenExample : MonoBehaviour

        else
        
        }
    }
}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html)
