---
title: "Scripting API: Physics.SphereCast"
page_title: "Unity - Scripting API: Physics.SphereCast"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCast.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCast.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Physics](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.html).SphereCast

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

public static bool <span class="sig-kw">SphereCast</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">origin</span>, float <span class="sig-kw">radius</span>, [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">direction</span>, out [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html) <span class="sig-kw">hitInfo</span>, float <span class="sig-kw">maxDistance</span> = Mathf.Infinity, int <span class="sig-kw">layerMask</span> = DefaultRaycastLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                                                                                         |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| origin                  | The center of the sphere at the start of the sweep.                                                                                                                                                                 |
| radius                  | The radius of the sphere.                                                                                                                                                                                           |
| direction               | The direction into which to sweep the sphere.                                                                                                                                                                       |
| hitInfo                 | If true is returned, `hitInfo` will contain more information about where the collider was hit. (Additional resources: [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html)). |
| maxDistance             | The max length of the cast.                                                                                                                                                                                         |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a sphere.                                           |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                                                                   |

### Returns

**bool** True when the sphere sweep intersects any collider, otherwise false.

### Description

Casts a sphere along a ray and returns detailed information on what was hit.

This is useful when a Raycast does not give enough precision, because you want to find out if an object of a specific size, such as a character, will be able to move somewhere without colliding with anything on the way. Think of the sphere cast like a thick raycast. In this case the ray is specified by a start vector and a direction.  
  
**Notes:** SphereCast will not detect colliders for which the sphere overlaps the collider. Passing a zero radius results in undefined output and doesn't always behave the same as [Physics.Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html).  
  
**Notes:** hit.normal from a [Physics.SphereCast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCast.html) does not always represent the surface normal. It is often the direction from the contact point to the center of the sphere. This can be misleading if you're using it for sliding, bouncing, or aligning objects. Consider using a [Physics.Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html) if you need the true surface normal.  
  
Additional resources: [Physics.SphereCastAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCastAll.html), [Physics.CapsuleCast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CapsuleCast.html), [Physics.Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html), [Rigidbody.SweepTest](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.SweepTest.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    void Update()
    
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static bool <span class="sig-kw">SphereCast</span>([Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) <span class="sig-kw">ray</span>, float <span class="sig-kw">radius</span>, float <span class="sig-kw">maxDistance</span> = Mathf.Infinity, int <span class="sig-kw">layerMask</span> = DefaultRaycastLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                                               |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ray                     | The starting point and direction of the ray into which the sphere sweep is cast.                                                                                          |
| radius                  | The radius of the sphere.                                                                                                                                                 |
| maxDistance             | The max length of the cast.                                                                                                                                               |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a sphere. |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                         |

### Returns

**bool** True when the sphere sweep intersects any collider, otherwise false.

### Description

Casts a sphere along a ray and returns detailed information on what was hit.

This is useful when a Raycast does not give enough precision, because you want to find out if an object of a specific size, such as a character, will be able to move somewhere without colliding with anything on the way. Think of the sphere cast like a thick raycast.  
  
Additional resources: [Physics.SphereCastAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.SphereCastAll.html), [Physics.CapsuleCast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.CapsuleCast.html), [Physics.Raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html), [Rigidbody.SweepTest](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.SweepTest.html).

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static bool <span class="sig-kw">SphereCast</span>([Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) <span class="sig-kw">ray</span>, float <span class="sig-kw">radius</span>, out [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html) <span class="sig-kw">hitInfo</span>, float <span class="sig-kw">maxDistance</span> = Mathf.Infinity, int <span class="sig-kw">layerMask</span> = DefaultRaycastLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                                                                                         |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ray                     | The starting point and direction of the ray into which the sphere sweep is cast.                                                                                                                                    |
| radius                  | The radius of the sphere.                                                                                                                                                                                           |
| hitInfo                 | If true is returned, `hitInfo` will contain more information about where the collider was hit. (Additional resources: [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html)). |
| maxDistance             | The max length of the cast.                                                                                                                                                                                         |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) that is used to selectively filter which colliders are considered when casting a sphere.                                           |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                                                                                                   |

### Description
