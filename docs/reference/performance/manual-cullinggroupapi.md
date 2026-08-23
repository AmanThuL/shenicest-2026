---
title: "Introduction to the CullingGroup API"
page_title: "Unity - Manual: Introduction to the CullingGroup API"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CullingGroupAPI.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CullingGroupAPI.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to the CullingGroup API

CullingGroup offers a way to integrate your own systems into Unity’s culling and LOD pipeline. This can be used for many purposes; for example:

-   Simulating a crowd of people, while only having full GameObjects for the characters that are actually visible right now
-   Building a GPU particle system driven by Graphics.DrawProcedural, but skipping rendering particle systems that are behind a wall
-   Tracking which spawn points are hidden from the camera in order to spawn enemies without the player seeing them ‘pop’ into view
-   Switching characters from full-quality animation and AI calculations when close, to lower-quality cheaper behaviour at a distance
-   Having 10,000 marker points in your scene and efficiently finding out when the player gets within 1m of any of them

The API works by having you provide an array of bounding spheres. The visibility of these spheres relative to a particular camera is then calculated, along with a ‘distance band’ value that can be treated like a LOD level number.

## CullingGroup API Best Practices

When considering how you might apply CullingGroup to your project, consider the following aspects of the CullingGroup design.

### Using visibility

All the volumes for which CullingGroup computes visibility are defined by bounding spheres - in practice, a position (the center of the sphere) and a radius value. No other bounding shapes are supported, for performance reasons. In practice this means you will be defining a sphere that fully encloses the object you are interested in culling. If a tighter fit is needed, consider using multiple spheres to cover different parts of the object, and making decisions based on the visibility state of all of the spheres.

In order to evaluate visibility, the CullingGroup needs to know which camera visibility should be computed from. Currently a single CullingGroup only supports a single camera. If you need to evaluate visibility to multiple cameras, you should use one CullingGroup per camera and combine the results.

The CullingGroup will calculate visibility based on frustum culling and static occlusion culling only. It will not take dynamic objects into account as potential occluders.

### Using distance

The CullingGroup is capable of calculating the distance between some reference point (for example, the position of the camera or player) and the closest point on each sphere. This distance value is not provided to you directly, but is instead quantized using a set of threshold values that you provide, in order to calculate a discrete ‘distance band’ integer result. The intention is that you interpret these distance bands as ‘close range’, ‘medium range’, ‘far range’, and so on.

The CullingGroup will provide callbacks when an object moves from being in one band to being in another, giving you the opportunity to do things like change the behaviour of that object to something less CPU-intensive.

Any spheres that are beyond the last distance band will be considered to be invisible, allowing you to easily construct a culling implementation that completely deactivates objects that are very far away. If you do not want this behaviour, simply set your final threshold value to be at an infinite distance away.

Only a single reference point is supported per CullingGroup.

### Performance and design

The CullingGroup API does not give you the ability to make changes to your scene and then immediately request the new visibility state of a bounding sphere. For performance reasons, the CullingGroup only calculates new visibility information during execution of culling for the camera as a whole; it’s at this point that the information is available to you, either via a callback, or via the CullingGroup query API. In practice, this means you should approach CullingGroup in an asynchronous manner.

The bounding spheres array you provide to the CullingGroup is referenced by the CullingGroup, rather than copied. This means you should keep a reference to the array that you pass to SetBoundingSpheres, and that you can modify the contents of this array without needing to call SetBoundingSpheres again. If you need multiple CullingGroups that calculate visibility and distances for the same set of spheres - for example, for multiple cameras - then it’s efficient to have all the CullingGroups share the same bounding sphere array instance.
