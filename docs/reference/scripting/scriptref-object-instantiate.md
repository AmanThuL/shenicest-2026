---
title: "Scripting API: Object.Instantiate"
page_title: "Unity - Scripting API: Object.Instantiate"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).Instantiate

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

public static Object <span class="sig-kw">Instantiate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">original</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |

### Returns

**Object** The instantiated clone.

### Description

Clones the object `original` and returns the clone.

This method makes a copy of an object, similar to the **Duplicate** command in the Editor.  
  
When you clone a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) or [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), Unity also clones all of its child objects and components, and sets their properties to match the original. If you clone a [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), Unity also clones the [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) that the component is attached to.  
  
This overload doesn't set a position, rotation, or parent for the clone. By default, the new object has no parent, even if `original` has one. To set a position, rotation, or parent, use one of the other overloads, or an overload that takes an [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct to pass any combination of these values.  
  
The clone keeps the active state of the original, so if `original` is inactive, the clone is also inactive. For the clone and each object in its hierarchy, Unity calls the `Awake` and `OnEnable` methods on a [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) or [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) only if it's active in the hierarchy when you call this method.  
  
**Note:** When this method clones a child object, it also clones that child's own children. To prevent a stack overflow, Unity limits this nested cloning. If the cloning exceeds more than half of the stack size, Unity throws an `InsufficientExecutionStackException`.  
  
This method doesn't create a prefab connection to the new object. To create an object with a prefab connection, use [PrefabUtility.InstantiatePrefab](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrefabUtility.InstantiatePrefab.html) instead.  
  
Additional resources:  
  
[Instantiating prefabs at run time](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs.html)  
[PrefabUtility.InstantiatePrefab](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrefabUtility.InstantiatePrefab.html).

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Instantiate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">original</span>, [SceneManagement.Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) <span class="sig-kw">scene</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |
| scene     | The scene to add the new object to.                 |

### Returns

**Object** The instantiated clone.

### Description

Clones the object `original` and adds the clone to the specified scene.

This overload adds the clone to a specific loaded scene instead of the active scene.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Instantiate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">original</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                   |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |

### Returns

**Object** The instantiated clone.

### Description

Clones the object `original` and sets `parent` as the parent of the clone.

This overload sets a parent for the clone but doesn't set a position or rotation. Unity uses the existing object's position and rotation as the clone's local position and rotation, relative to `parent`.  
  
To keep the existing object's world position and rotation instead, use Object.Instantiate(Object,Transform,bool) and set `instantiateInWorldSpace` to true.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Instantiate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">original</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, bool <span class="sig-kw">instantiateInWorldSpace</span>);

### Parameters

| Parameter               | Description                                                                                                                           |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| original                | An existing object that you want to make a copy of.                                                                                   |
| parent                  | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |
| instantiateInWorldSpace | Set to true to keep the new object's world position and rotation. Set to false to position the new object relative to `parent`.       |

### Returns

**Object** The instantiated clone.

### Description

Clones the object `original`, sets `parent` as the parent of the clone, and sets whether the clone keeps its local or world position.

If `instantiateInWorldSpace` is false, Unity uses the existing object's position and rotation as the clone's local position and rotation, relative to `parent`. If `instantiateInWorldSpace` is true, Unity keeps the existing object's world position and rotation.  
  
The following example instantiates a prefab as a child of another [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html), first keeping the prefab's local position relative to the parent, then keeping its original world position.

``` codeExampleCS
using UnityEngine;

// Instantiate a Prefab as a child of another object.

public class Example : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Instantiate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                         |
|-----------|-----------------------------------------------------|
| original  | An existing object that you want to make a copy of. |
| position  | The position for the new object, in world space.    |
| rotation  | The orientation of the new object.                  |

### Returns

**Object** The instantiated clone.

### Description

Clones the object `original` and sets the position and rotation of the clone.

Unity uses the `position` and `rotation` that you specify as the clone's position and rotation in world space. The new object has no parent.  
  
You can use this method to create new objects at runtime, such as projectiles or particle systems for explosion effects.

``` codeExampleCS
using UnityEngine;

// Instantiate a rigidbody then set the velocity

public class Example : MonoBehaviour

    }
}
```

You can also use this method to clone script instances directly. Unity clones the entire [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) hierarchy and returns the cloned script instance.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class Missile : MonoBehaviour

public class ExampleClass : MonoBehaviour

    }
}
```

You can also instantiate multiple clones at different positions.

``` codeExampleCS
// Instantiates 10 copies of Prefab each 2 units apart from each other

using UnityEngine;

public class Example : MonoBehaviour

    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Instantiate</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | An existing object that you want to make a copy of.                                                                                   |
| position  | The position for the new object, in world space.                                                                                      |
| rotation  | The orientation of the new object.                                                                                                    |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |

### Returns

**Object** The instantiated clone.

### Description

Clones the object `original`, sets the position and rotation of the clone, and sets `parent` as the parent of the clone.

Unity uses the `position` and `rotation` that you specify as the clone's position and rotation in world space, and sets `parent` as the parent of the clone.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>);

### Parameters

| Parameter | Description                              |
|-----------|------------------------------------------|
| original  | Object of type T that you want to clone. |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T and returns the clone.

You can use generic types to instantiate objects so you don't have to cast the result to a specific type. For more information on generics in C#, refer to Microsoft's [Generic methods](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/generic-methods) documentation.

``` codeExampleCS
using UnityEngine;

public class Missile : MonoBehaviour

public class InstantiateGenericsExample : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>);

### Parameters

| Parameter  | Description                                                                                                                                                                                                                                        |
|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original   | Object of type T that you want to clone.                                                                                                                                                                                                           |
| parameters | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T using the settings in `parameters`, and returns the clone.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | Object of type T that you want to clone.                                                                                              |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T and sets `parent` as the parent of the clone.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>, bool <span class="sig-kw">worldPositionStays</span>);

### Parameters

| Parameter          | Description                                                                                                                           |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| original           | Object of type T that you want to clone.                                                                                              |
| parent             | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |
| worldPositionStays | Set to true to keep the new object's world position and rotation. Set to false to position the new object relative to `parent`.       |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T, sets `parent` as the parent of the clone, and sets whether the clone keeps its local or world position.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>);

### Parameters

| Parameter | Description                                      |
|-----------|--------------------------------------------------|
| original  | Object of type T that you want to clone.         |
| position  | The position for the new object, in world space. |
| rotation  | The orientation of the new object.               |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T and sets the position and rotation of the clone.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>, [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) <span class="sig-kw">parameters</span>);

### Parameters

| Parameter  | Description                                                                                                                                                                                                                                        |
|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| original   | Object of type T that you want to clone.                                                                                                                                                                                                           |
| position   | The position for the new object, in world space.                                                                                                                                                                                                   |
| rotation   | The orientation of the new object.                                                                                                                                                                                                                 |
| parameters | An [InstantiateParameters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/InstantiateParameters.html) struct that specifies options for the new object, such as its parent, the scene to add it to, and whether to use world space. |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T, sets the position and rotation of the clone, and applies the settings in `parameters`.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Instantiate</span>(T <span class="sig-kw">original</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html) <span class="sig-kw">rotation</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">parent</span>);

### Parameters

| Parameter | Description                                                                                                                           |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------|
| original  | Object of type T that you want to clone.                                                                                              |
| position  | The position for the new object, in world space.                                                                                      |
| rotation  | The orientation of the new object.                                                                                                    |
| parent    | The [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) to set as the parent of the new object. |

### Returns

**T** The instantiated cloned object of type T.

### Description

Clones the object of type T, sets the position and rotation of the clone, and sets `parent` as the parent of the clone.
