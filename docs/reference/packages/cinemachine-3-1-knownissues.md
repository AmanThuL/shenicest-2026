---
title: "Cinemachine - Known Issues"
page_title: "Known Issues | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/KnownIssues.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/KnownIssues.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Known Issues

## Accumulation Buffer Projection Matrix

If accumulation's "Anti-aliasing" option is enabled and the scene contains a Cinemachine camera cut, the camera's FOV will be incorrect after the cut.
**Workaround**: Reset the projection matrix every frame, after CinemachineBrain has modified the camera.

```
public class FixProjection : MonoBehaviour
{
    void LateUpdate()
    {
        Camera.main.ResetProjectionMatrix();
    }
}
```
