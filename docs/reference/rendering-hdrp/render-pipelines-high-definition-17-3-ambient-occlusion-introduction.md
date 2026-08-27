---
title: "Ambient occlusion (introduction)"
page_title: "Ambient occlusion | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/ambient-occlusion-introduction.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/ambient-occlusion-introduction.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Ambient occlusion

Ambient occlusion (AO) darkens corners in areas where surfaces are close to each other and difficult for indirect light to reach.

The High Definition Render Pipeline (HDRP) can create ambient occlusion by reducing how much light a surface gets from indirect ambient light sources. For more information about indirect ambient light, refer to [Environment lighting](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Environment-Lighting.html).

**Note:** Ambient occlusion doesn't affect direct lighting.

To enable ambient occlusion, use one of the following methods:

- [Assign an ambient occlusion texture](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ambient-Occlusion.html) for each GameObject.
- [Screen space ambient occlusion (SSAO)](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Override-Ambient-Occlusion.html), which uses information from the whole screen. SSAO is enabled by default.
- [Ray-traced ambient occlusion (RTAO)](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Ray-Traced-Ambient-Occlusion.html), which uses information from beyond the screen.

If you create an ambient occlusion texture, HDRP also uses it to calculate specular occlusion, by reducing the intensity of reflections in corners.

![Four versions of a scene with dragon statues in a brick dungeon, lit brightly from above. With no ambient occlusion, there are no shadows in corners and crevices. Ambient occlusion, SSAO with ambient occlusion, and RTAO with ambient occlusion give progressively better results.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/aocomparison.png)\
Four versions of a scene with dragon statues in a brick dungeon, lit brightly from above. With no ambient occlusion, there are no shadows in corners and crevices. Ambient occlusion, SSAO with ambient occlusion, and RTAO with ambient occlusion give progressively better results.

## Additional resources

- [Ambient light](https://docs.unity3d.com/Manual/lighting-ambient-light.html)
- [Reflection and refraction](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-in-HDRP.html)
