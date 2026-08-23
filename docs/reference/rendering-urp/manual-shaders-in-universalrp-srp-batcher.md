---
title: "Make a URP shader compatible with the SRP Batcher"
page_title: "Unity - Manual: Make a URP shader compatible with the SRP Batcher"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shaders-in-universalrp-srp-batcher.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shaders-in-universalrp-srp-batcher.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Make a URP shader compatible with the SRP Batcher

To ensure that a Shader is SRP Batcher compatible:

-   Declare all Material properties in a single CBUFFER called `UnityPerMaterial`.
-   Declare all built-in engine properties, such as `unity_ObjectToWorld` or `unity_WorldTransformParams`, in a single CBUFFER called `UnityPerDraw`.

For more information on the SRP Batcher, refer to the documentation on the [Scriptable Render Pipeline (SRP) Batcher](https://docs.unity3d.com/Manual/SRPBatcher.html).
