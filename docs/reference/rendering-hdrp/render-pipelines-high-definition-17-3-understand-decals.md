---
title: "Understand decals"
page_title: "Understand decals | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-decals.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/understand-decals.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Understand decals

The High Definition Render Pipeline (HDRP) includes the following ways to create decals in a Scene.

- Use a Decal Mesh and manually position the decal.
- Use the [Decal Projector](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-projector-reference.html) component to project the decal.

To use these methods, you need to create a decal material. A decal material is a material that uses the Decal Shader or Decal Master Stack. You can then place or project your decal material into a Scene.

![Rocky ground with two dark iridescent oil patches.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/HDRPFeatures-DecalShader.png)

Refer to [Use decals](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-decals.html) for more information.

## How Unity organises decals

For [decals applied to opaque surfaces](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html#decalopaque), HDRP uses a [decal atlas](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html#Decals) to store and manage decal textures. A decal atlas is a texture resource that combines multiple opaque decal textures into one. HDRP shares this resource across general opaque decal types in the scene.

For [decals applied to transparent surfaces](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/HDRP-Asset.html#decaltransparent) (such as water or glass), HDRP uses clustered structures to store and manage decal textures. HDRP doesn't use decal atlases for transparent surfaces.

## Decal Projector

When the Decal Projector component projects decals into the Scene, they interact with the Scene’s lighting and wrap around Meshes. You can use thousands of decals in your Scene simultaneously because HDRP instances them. This means that the rendering process isn't resource intensive as long as the decals use the same material.

The Decal Projector also supports [Decal Layers](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/use-decals.html#decal-layers) which means you can control which materials receive decals on a Layer by Layer basis.

![A stony forest floor in the Scene view, with a rectangular area representing a Decal Projector above a reflective puddle.](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/images/DecalProjector1.png)

## Limitations

- A Decal Projector can only affect transparent materials when you use the [Decal Shader](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-material-inspector-reference.html).

- The Decal Shader doesn't support emissive on transparent materials and does support Decal Layers.

- Decal Meshes can only affect opaque materials with either a [Decal Shader](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-material-inspector-reference.html) or a [Decal Master Stack](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-master-stack-reference.html).

- Decal Meshes don't support Decal Layers.

### Migration of data before Unity 2020.2

When you convert a project from 2020.2, Mesh renderers and Terrain don't receive any decals by default.

This is because, before Unity 2020.2, the default value for the **Rendering Layer Mask** for new Mesh Renderers and Terrain doesn't include Decal Layer flags.
