---
title: "Add ambient light from the environment"
page_title: "Unity - Manual: Add ambient light from the environment"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-ambient-light.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-ambient-light.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Add ambient light from the environment

Ambient light, also known as diffuse environmental light, is light that is present all around the Scene and doesn’t come from any specific source object. It can be an important contributor to the overall look and brightness of a scene.

Ambient light can be useful in a number of cases, depending upon your chosen art style. An example would be bright, cartoon-style rendering where dark shadows may be undesirable or where lighting is perhaps hand-painted into textures. Ambient light can also be useful if you need to increase the overall brightness of a scene without adjusting individual lights.

## Add ambient light

After you [create a skybox material](https://docs.unity3d.com/6000.3/Documentation/Manual/skyboxes-using.html), Unity can use it to generate ambient lighting in your Scene. To make Unity do this:

1.  Open the Lighting window (menu: **Window** > **Rendering** > **Lighting**).
2.  Select the **Environment** tab.
3.  Assign your chosen skybox to the **Skybox Material** property.
4.  Click the **Source** drop-down and, from the list, click **Skybox**.

## Additional resources

-   [Skyboxes](https://docs.unity3d.com/6000.3/Documentation/Manual/sky-landing.html)
-   [Visual environment in the High Definition Render Pipeline (HDRP)](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/index.html?subfolder=/manual/Override-Visual-Environment.html)
-   [Changing lighting at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/probe-volumes-change-lighting-at-runtime.html)
-   [Add ambient occlusion](https://docs.unity3d.com/6000.3/Documentation/Manual/LightingBakedAmbientOcclusion.html)
-   [Screen space ambient occlusion in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing-ssao-landing.html)
