---
title: "Understand refraction"
page_title: "Understand refraction | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-refraction.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-refraction.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Understand refraction

Refraction is when light bends as it passes from one material ('medium') into another. Your eye can see refraction only through a transparent material, because most light is absorbed or reflected in opaque materials.

![Light rays bend as they travel through the different mediums of air, water, and glass, so the pencil appears deformed.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/refraction-glass-of-water.png)

Light rays bend as they travel through the different mediums of air, water, and glass, so the pencil appears deformed.

## How refraction works in HDRP

HDRP needs to find the color that's visible through each transparent pixel on an object. For each transparent pixel, HDRP starts from the Camera position, and follows the reverse direction of light to calculate how light is bent:

1.  HDRP finds the view vector, which is the direction of light from the camera to the pixel.
2.  When the light enters the object, HDRP bends the light. To calculate how much the light bends and how far it travels inside the object, HDRP uses simple shapes that approximate the object's internal dimensions (the [refraction model](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/refraction-models.html)), and the Material's [Surface Type](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Surface-Type.html) settings.
3.  When the light leaves the object, HDRP bends the light back, based on the simple shape that approximates the object's internal dimensions.
4.  HDRP uses the intersection of the light with a [Proxy Volume](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Reflection-Proxy-Volume.html) that contains a projection of the rendered scene, to find the color that's visible through the transparent pixel.

## Additional resources

- [Create a refractive Material](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/create-a-refractive-material.html)
- [Refraction models](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/refraction-models.html)
- [How HDRP calculates color for reflection and refraction](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/how-hdrp-calculates-color-for-reflection-and-refraction.html)
