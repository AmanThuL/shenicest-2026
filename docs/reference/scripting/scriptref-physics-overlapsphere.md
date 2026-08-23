---
title: "Scripting API: Physics.OverlapSphere"
page_title: "Unity - Scripting API: Physics.OverlapSphere"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphere.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphere.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Physics](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.html).OverlapSphere

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

public static Collider\[\] <span class="sig-kw">OverlapSphere</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">position</span>, float <span class="sig-kw">radius</span>, int <span class="sig-kw">layerMask</span> = AllLayers, [QueryTriggerInteraction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html) <span class="sig-kw">queryTriggerInteraction</span> = QueryTriggerInteraction.UseGlobal);

### Parameters

| Parameter               | Description                                                                                                                                 |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| position                | Center of the sphere.                                                                                                                       |
| radius                  | Radius of the sphere.                                                                                                                       |
| layerMask               | A [Layer mask](https://docs.unity3d.com/6000.3/Documentation/Manual/Layers.html) defines which layers of colliders to include in the query. |
| queryTriggerInteraction | Specifies whether this query should hit Triggers.                                                                                           |

### Returns

**Collider\[\]** Returns an array with all colliders touching or inside the sphere.

### Description

Computes and stores colliders touching or inside the sphere.

Additional resources: [Physics.AllLayers](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.AllLayers.html). Allocates memory. Consider using [Physics.OverlapSphereNonAlloc](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.OverlapSphereNonAlloc.html) instead.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

    }
}
```

Additional resources: Ray cast with layers section of [Use of layers in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/use-layers.html).
