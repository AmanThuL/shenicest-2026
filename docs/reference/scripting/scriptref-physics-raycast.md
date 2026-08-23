---
title: "Scripting API: Physics.Raycast"
page_title: "Unity - Scripting API: Physics.Raycast"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Physics](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.html).Raycast

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

public static bool <span class="sig-kw">Raycast</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">origin</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">direction</span>, float <span class="sig-kw">maxDistance</span> = Mathf.Infinity, int <span class="sig-kw">layerMask</span> = DefaultRaycastLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                                            |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| origin                  | The starting point of the ray in world coordinates.                                                                                                                    |
| direction               | The direction of the ray.                                                                                                                                              |
| maxDistance             | The max distance the ray should check for collisions.                                                                                                                  |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a ray. |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                      |

### Returns

**bool** Returns true if the ray intersects with a Collider, otherwise false.

### Description

Casts a ray, from point `origin`, in direction `direction`, of length `maxDistance`, against all colliders in the Scene.

To select which layers a ray should collide with, use a [LayerMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.html).  
  
Specifying `queryTriggerInteraction` allows you to control whether or not Trigger colliders generate a hit, or whether to use the global [Physics.queriesHitTriggers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics-queriesHitTriggers.html) setting.  
  
**Notes:** Raycasts will not detect Colliders for which the Raycast origin is inside the Collider. In all these examples [FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerLoop.FixedUpdate.html) is used rather than [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerLoop.Update.html). Refer to [Order of execution for event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html) to understand the difference between [Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerLoop.Update.html) and [FixedUpdate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerLoop.FixedUpdate.html), and to see how they relate to physics queries.

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

    // See Order of Execution for Event Functions for information on FixedUpdate() and Update() related to physics queries
    void FixedUpdate()
    
        else
        
    }
}
```

This example creates a simple Raycast, projecting forwards from the position of the object's current position, extending for 10 units.

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static bool <span class="sig-kw">Raycast</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">origin</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">direction</span>, out [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html) <span class="sig-kw">hitInfo</span>, float <span class="sig-kw">maxDistance</span>, int <span class="sig-kw">layerMask</span>, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span>);

### Parameters

| Parameter               | Description                                                                                                                                                                                                                 |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| origin                  | The starting point of the ray in world coordinates.                                                                                                                                                                         |
| direction               | The direction of the ray.                                                                                                                                                                                                   |
| hitInfo                 | If true is returned, `hitInfo` will contain more information about where the closest collider was hit. (Additional resources: [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html)). |
| maxDistance             | The max distance the ray should check for collisions.                                                                                                                                                                       |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a ray.                                                      |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                                                                           |

### Returns

**bool** Returns true when the ray intersects any collider, otherwise false.

### Description

Casts a ray against all colliders in the Scene and returns detailed information on what was hit.

This example reports the distance between the current object and the reported Collider:

``` codeExampleCS
using UnityEngine;

public class RaycastExample : MonoBehaviour

}
```

This example re-introduces the `maxDistance` parameter to limit how far ahead to cast the Ray:

``` codeExampleCS
using UnityEngine;

public class RaycastExample : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static bool <span class="sig-kw">Raycast</span>([Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) <span class="sig-kw">ray</span>, float <span class="sig-kw">maxDistance</span> = Mathf.Infinity, int <span class="sig-kw">layerMask</span> = DefaultRaycastLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                                            |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ray                     | The starting point and direction of the ray.                                                                                                                           |
| maxDistance             | The max distance the ray should check for collisions.                                                                                                                  |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a ray. |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                      |

### Returns

**bool** Returns true when the ray intersects any collider, otherwise false.

### Description

Same as above using `ray.origin` and `ray.direction` instead of `origin` and `direction`.

``` codeExampleCS
using UnityEngine;
using UnityEngine.InputSystem;
                        
public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static bool <span class="sig-kw">Raycast</span>([Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) <span class="sig-kw">ray</span>, out [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html) <span class="sig-kw">hitInfo</span>, float <span class="sig-kw">maxDistance</span> = Mathf.Infinity, int <span class="sig-kw">layerMask</span> = DefaultRaycastLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                                                                                                 |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ray                     | The starting point and direction of the ray.                                                                                                                                                                                |
| hitInfo                 | If true is returned, `hitInfo` will contain more information about where the closest collider was hit. (Additional resources: [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html)). |
| maxDistance             | The max distance the ray should check for collisions.                                                                                                                                                                       |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a ray.                                                      |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                                                                           |

### Returns

**bool** Returns true when the ray intersects any collider, otherwise false.

### Description

Same as above using `ray.origin` and `ray.direction` instead of `origin` and `direction`.

This example draws a line along the length of the Ray whenever a collision is detected:

``` codeExampleCS
using UnityEngine;
using UnityEngine.InputSystem;
                        
public class ExampleClass : MonoBehaviour

}
```
