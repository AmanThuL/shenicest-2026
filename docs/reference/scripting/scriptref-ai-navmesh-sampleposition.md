---
title: "Scripting API: AI.NavMesh.SamplePosition"
page_title: "Unity - Scripting API: AI.NavMesh.SamplePosition"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.SamplePosition.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.SamplePosition.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [NavMesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.html).SamplePosition

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

public static bool <span class="sig-kw">SamplePosition</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">sourcePosition</span>, out [AI.NavMeshHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshHit.html) <span class="sig-kw">hit</span>, float <span class="sig-kw">maxDistance</span>, int <span class="sig-kw">areaMask</span>);

### Parameters

| Parameter      | Description                                                                                                        |
|----------------|--------------------------------------------------------------------------------------------------------------------|
| sourcePosition | The origin of the sample query.                                                                                    |
| hit            | Holds the properties of the resulting location. The value of `hit.normal` is never computed. It is always (0,0,0). |
| maxDistance    | Sample within this distance from sourcePosition.                                                                   |
| areaMask       | A mask that specifies the NavMesh areas allowed when finding the nearest point.                                    |

### Returns

**bool** True if the nearest point is found.

### Description

Finds the nearest point based on the NavMesh within a specified range.

The nearest point is found by projecting the input point onto nearby NavMesh instances along the vertical axis. This vertical axis has been chosen for each instance at the time of [creation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMesh.AddNavMeshData.html). If this step does not find a projected point within the specified distance, then sampling is extended to surrounding NavMesh positions.  
  
Finds the nearest point based on the distance to the query point. This function does not consider obstructions. For example, in a two-story structure, if the sourcePosition is set to a point on the ceiling on the first floor, the nearest point might be found on the second floor rather than the first floor. The ceiling is not considered as an obstruction.  
  
This function may reduce the frame rate if a large search radius is specified. To avoid frame rate issues, it is recommended that you specify a maxDistance of twice the agent height.  
  
If you are trying to find a random point on the NavMesh, you should use the recommended radius and perform the find multiple times instead of using a very large radius.

``` codeExampleCS
// RandomPointOnNavMesh
using UnityEngine;
using UnityEngine.AI;

public class RandomPointOnNavMesh : MonoBehaviour

        }
        result = Vector3.zero;
        return false;
    }

    void Update()
    
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static bool <span class="sig-kw">SamplePosition</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">sourcePosition</span>, out [AI.NavMeshHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshHit.html) <span class="sig-kw">hit</span>, float <span class="sig-kw">maxDistance</span>, [AI.NavMeshQueryFilter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshQueryFilter.html) <span class="sig-kw">filter</span>);

### Parameters

| Parameter      | Description                                                                                                        |
|----------------|--------------------------------------------------------------------------------------------------------------------|
| sourcePosition | The origin of the sample query.                                                                                    |
| hit            | Holds the properties of the resulting location. The value of `hit.normal` is never computed. It is always (0,0,0). |
| maxDistance    | Sample within this distance from sourcePosition.                                                                   |
| filter         | A filter specifying which NavMesh areas are allowed when finding the nearest point.                                |

### Returns

**bool** True if the nearest point is found.

### Description

Samples the position nearest the sourcePosition on any NavMesh built for the agent type specified by the filter.

Consider only positions on areas defined in the [NavMeshQueryFilter.areaMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshQueryFilter-areaMask.html). A maximum search radius is set by maxDistance. The information of any found position is returned in the hit argument.
