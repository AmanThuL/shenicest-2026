---
title: "Light Probes"
page_title: "Unity - Manual: Light Probes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LightProbes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LightProbes.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Light Probes

**Light Probes** provide a way to capture and use information about light that is passing through the empty space in your scene.

Similar to lightmaps, light probes store “baked” information about lighting in your scene. The difference is that while lightmaps store lighting information about light hitting the *surfaces* in your scene, light probes store information about light passing through *empty space* in your scene.

Light Probes are positions in the scene where the light is measured (probed) during the bake. At runtime, the indirect light that hits dynamic GameObjects is approximated using the values from the nearest Light Probes to that object.

![An extremely simple scene showing light probes placed around two cubes](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/LightProbes-0.png)

Light Probes have two main uses:

The primary use of light probes is to provide high quality lighting (including indirect bounced light) on moving objects in your scene.

The secondary use of light probes is to provide the lighting information for static scenery when that scenery is using Unity’s **LOD system**.

When using light probes for either of these two distinct purposes, many of the techniques you need to use are the same. It’s important to understand how light probes work so that you can choose where to place your probes in the scene.

## Additional resources

-   [Adaptive Probe Volumes (APV) in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probevolumes.html)
