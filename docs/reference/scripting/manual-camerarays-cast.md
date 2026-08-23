---
title: "Unity 6.3 Manual: Cast a ray from a camera"
page_title: "Unity - Manual: Cast a ray from a camera"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CameraRays-cast.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CameraRays-cast.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Cast a ray from a camera

The most common use of a Ray from the camera is to perform a [raycast](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html) out into the scene. A raycast sends an imaginary “laser beam” along the ray from its origin until it hits a collider in the scene. Information is then returned about the object and the point that was hit in a [RaycastHit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RaycastHit.html) object. This is a very useful way to locate an object based on its onscreen image. For example, the object at the mouse position can be determined with the following code:

``` lang-cs
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour 
    }
}
```
