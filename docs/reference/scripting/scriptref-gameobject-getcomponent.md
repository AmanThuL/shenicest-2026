---
title: "Scripting API: GameObject.GetComponent"
page_title: "Unity - Scripting API: GameObject.GetComponent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).GetComponent

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

public T <span class="sig-kw">GetComponent</span>();

### Returns

**T** A reference to a component of the specified type, returned as an object of type `T`. If no component is found, returns `null`.

### Description

Retrieves a reference to a component of the specified type, by providing the component type as a type parameter to the generic method.

`GetComponent` returns only the first matching component found on the GameObject, and components aren't checked in a defined order. If there are multiple components of the same type and you need to find a specific one, use [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html) and check the list of components returned to identify the one you want.  
  
**Note**: If the type you request is a derivative of MonoBehaviour and the script it's defined in can't be loaded, then this function returns \`null\` for that component. This might happen if you've named your class ambiguously. Refer to [Naming scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/Namespaces.html) in the Manual for more information on naming considerations.  
  
The typical usage for this method is to call it on a reference to a different GameObject than the one your script is on. For example:  
  
`ComponentType myComponent = otherGameObject.GetComponent<ComponentType>()`  
  
To find components attached to other GameObjects, you need a [reference to that other GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html#AccessingOtherGameObjects), or to any component attached to that GameObject. You can then call `GetComponent` on that reference.  
  
You can also use this method to get a reference to a component on the GameObject that this script is attached to, by calling this method inside a `MonoBehaviour`-derived class attached to the GameObject. You can omit the preceding `GameObject` qualifier to reference the GameObject the script is attached to. In this instance, you're actually calling [Component.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html) because the script itself is a type of component, but the result is the same as if you'd referenced the GameObject itself. For example:  
  
`ComponentType myComponent = GetComponent<ComponentType>()`  
  
The following example gets a reference to a hinge joint component on the referenced GameObject, and if found, sets a property on it.

``` codeExampleCS
using UnityEngine;

public class GetComponentExample : MonoBehaviour
// Attach this script to a GameObject as a component.

    }
}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">GetComponent</span>(Type <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                                                        |
|-----------|--------------------------------------------------------------------|
| type      | The type of component to search for, specified as a `Type` object. |

### Returns

**Component** A reference to a component of the specified type, returned as a `Component` type. If no component is found, returns `null`.

### Description

Retrieves a reference to a component of specified type, by providing the component type as a method parameter.

This version of `GetComponent` isn't as efficient as the generic version. Use this version only if necessary.  
  
`GetComponent` returns only the first matching component found on the GameObject, and components aren't checked in a defined order. If there are multiple components of the same type and you need to find a specific one, use [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html) and check the list of components returned to identify the one you want.  
  
**Note**: If the type you request is a derivative of MonoBehaviour and the script it's defined in can't be loaded, then this function returns \`null\` for that component. This might happen if you've named your class ambiguously. Refer to [Naming scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/Namespaces.html) in the Manual for more information on naming considerations.  
  
The typical usage for this method is to call it on a reference to a different GameObject than the one your script is on. For example:  
  
`ComponentType myComponent = otherGameObject.GetComponent(typeof(ComponentType)) as ComponentType`  
  
To find components attached to other GameObjects, you need a [reference to that other GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html#AccessingOtherGameObjects), or to any component attached to that GameObject. You can then call `GetComponent` on that reference.  
  
You can also use this method to get a reference to a component on the GameObject that this script is attached to, by calling this method inside a `MonoBehaviour`-derived class attached to the GameObject. You can omit the preceding `GameObject` qualifier to reference the GameObject the script is attached to. In this instance, you're actually calling [Component.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html) because the script itself is a type of component, but the result is the same as if you'd referenced the GameObject itself. For example:  
  
`ComponentType myComponent = GetComponent(typeof(ComponentType)) as ComponentType`  
  
The following example gets a reference to a hinge joint component on the referenced GameObject, and if found, sets a property on it.

``` codeExampleCS
using UnityEngine;

public class GetComponentExample : MonoBehaviour
// Attach this script to a GameObject as a component.

    }
}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">GetComponent</span>(string <span class="sig-kw">type</span>);

### Parameters

| Parameter | Description                                                             |
|-----------|-------------------------------------------------------------------------|
| type      | The name of the type of component to search for, specified as a string. |

### Returns

**Component** A reference to a component of the specified type, returned as a `Component` type. If no component is found, returns `null`.

### Description

Retrieves a reference to a component of the specified type, by providing the name of the component type as a method parameter.

This version of `GetComponent` isn't as efficient as the generic version. Use this version only if necessary.  
  
`GetComponent` returns only the first matching component found on the GameObject, and components aren't checked in a defined order. If there are multiple components of the same type and you need to find a specific one, use [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html) and check the list of components returned to identify the one you want.  
  
**Note**: If the type you request is a derivative of MonoBehaviour and the script it's defined in can't be loaded then this function returns \`null\` for that component. This might happen if you've named your class ambiguously. Refer to [Naming scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/Namespaces.html) in the Manual for more information on naming considerations.  
  
The typical usage for this method is to call it on a reference to a different GameObject than the one your script is on. For example:  
  
`ComponentType myComponent = otherGameObject.GetComponent("ComponentType") as ComponentType`  
  
To find components attached to other GameObjects, you need a [reference to that other GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html#AccessingOtherGameObjects), or to any component attached to that GameObject. You can then call `GetComponent` on that reference.  
  
You can also use this method to get a reference to a component on the GameObject that this script is attached to, by calling this method inside a `MonoBehaviour`-derived class attached to the GameObject. You can omit the preceding `GameObject` qualifier to reference the GameObject the script is attached to. In this instance, you're actually calling [Component.GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html) because the script itself is a type of component, but the result is the same as if you'd referenced the GameObject itself. For example:  
  
`ComponentType myComponent = GetComponent("ComponentType") as ComponentType`  
  
The following example gets a reference to a hinge joint component on the referenced GameObject, and if found, sets a property on it.

``` codeExampleCS
using UnityEngine;

public class GetComponentNonPerformantExample : MonoBehaviour
// Attach this script to a GameObject as a component.

    }
}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [GameObject.GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html)
