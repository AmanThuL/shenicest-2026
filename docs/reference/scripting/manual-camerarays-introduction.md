---
title: "Unity 6.3 Manual: Introduction to raycasting"
page_title: "Unity - Manual: Introduction to raycasting"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CameraRays-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CameraRays-introduction.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to raycasting

In the section [Understanding the View Frustum](https://docs.unity3d.com/6000.3/Documentation/Manual/UnderstandingFrustum.html), it was explained that any point in the camera’s view corresponds to a line in world space. It is sometimes useful to have a mathematical representation of that line and Unity can provide this in the form of a [Ray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Ray.html) object. The Ray always corresponds to a point in the view, so the Camera class provides the [ScreenPointToRay](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.ScreenPointToRay.html) and [ViewportPointToRay](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Camera.ViewportPointToRay.html) functions. The difference between the two is that ScreenPointToRay expects the point to be provided as a pixel coordinate, while ViewportPointToRay takes normalized coordinates in the range 0..1 (where 0 represents the bottom or left and 1 represents the top or right of the view). Each of these functions returns a Ray which consists of a point of origin and a vector which shows the direction of the line from that origin. The Ray originates from the near clipping plane rather than the Camera’s transform.position point.
