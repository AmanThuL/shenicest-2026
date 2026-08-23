---
title: "Scripting API: Component.GetComponent"
page_title: "Unity - Scripting API: Component.GetComponent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html).GetComponent

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

public T <span class="sig-kw">GetComponent</span>();

### Returns

**T** A reference to a component of the type `T` if one is found, otherwise `null`.

### Description

Gets a reference to a component of type `T` on the same GameObject as the component specified.

The typical usage for this method is to call it from a MonoBehaviour script (which itself is a type of component), to find references to other Components or MonoBehaviours attached to the same GameObject as that script. In this case you can call the method with no preceding object specified. For example:  
  
`myResults = GetComponent<ComponentType>()`  
  
You can also call this method on a reference to different component, which might be attached to a different GameObject. In this case, the GameObject to which that component is attached is searched. For example:  
  
`myResults = otherComponent.GetComponent<ComponentType>()`  
  
Note: GetComponent returns only the first matching component found on the GameObject on which it is called, and the order that the components are checked is not defined. Therefore, if there are more than one of the specified type that could match, and you need to find a specific one, you should use [Component.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponents.html) and check the list of components returned to identify the one you want.  
  
To find components attached to other GameObjects, you need a [reference to that other GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html#AccessingOtherGameObjects) (or any component attached to that GameObject). You can then call `GetComponent` on that reference.  
  
See the [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) and [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) class reference pages for the other variations of the `GetComponent` family of methods.  
  
The following example gets a reference to a hinge joint component on the same GameObject as the script, and if found, sets a property on that hinge joint component.

``` codeExampleCS
using UnityEngine;

public class GetComponentExample : MonoBehaviour

    }
}
```

Note: If the type you request is a derivative of MonoBehaviour and the associated script can't be loaded then this function will return \`null\` for that component.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">GetComponent</span>(Type <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                          |
|-----------|--------------------------------------|
| type      | The `type` of Component to retrieve. |

### Returns

**Component** A Component of the matching `type`, otherwise `null` if no Component is found.

### Description

The non-generic version of this method.

This version of GetComponent is not as efficient as the Generic version (above), so you should only use it if necessary.

``` codeExampleCS
using UnityEngine;

public class GetComponentExample : MonoBehaviour

    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">GetComponent</span>(string <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                                 |
|-----------|---------------------------------------------|
| type      | The name of the `type` of Component to get. |

### Returns

**Component** A Component of the matching `type`, otherwise `null` if no Component is found.

### Description

The string-based version of this method.

This version of GetComponent is not as efficient as the Generic version (above), so you should only use it if necessary.

``` codeExampleCS
using UnityEngine;

public class GetComponentExample : MonoBehaviour

    }
}
```
