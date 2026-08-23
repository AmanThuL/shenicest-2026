---
title: "Scriptable Render Pipeline (SRP) Batcher in URP"
page_title: "Unity - Manual: Scriptable Render Pipeline (SRP) Batcher in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-landing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-landing.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Scriptable Render Pipeline (SRP) Batcher in URP

Resources for using the Scriptable Render Pipeline (SRP) Batcher to reduce the number of render state changes between draw calls.

| **Page**                                                                                                                                        | **Description**                                                                                                                                                                        |
|:------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Introduction to the SRP Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html)                                         | Understand how the SRP Batcher reduces render state changes between draw calls.                                                                                                        |
| [Check whether a GameObject is compatible with the SRP Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-Materials.html) | Find out if Unity can include a GameObject and a shader in the SRP Batcher.                                                                                                            |
| [Enable the SRP Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-Enable.html)                                           | Enable the SRP Batcher in the URP asset.                                                                                                                                               |
| [Troubleshoot the SRP Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-Profile.html)                                    | Use the Frame Debugger to solve common issues with the SRP Batcher, such as a low number of draw calls in batches.                                                                     |
| [Remove SRP Batcher compatibility for GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher-Incompatible.html)           | Make a shader or renderer incompatible with the SRP Batcher, for example if you want to use [GPU instancing](https://docs.unity3d.com/6000.3/Documentation/Manual/GPUInstancing.html). |

## Additional resources

-   [Choose a method for optimizing draw calls](https://docs.unity3d.com/6000.3/Documentation/Manual/optimizing-draw-calls-choose-method.html)
-   [GPU instancing](https://docs.unity3d.com/6000.3/Documentation/Manual/GPUInstancing.html)
