---
title: "Unity 6.3 Manual: Import a texture"
page_title: "Unity - Manual: Import a texture"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingTextures.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingTextures.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Import a texture

A [texture](https://docs.unity3d.com/6000.3/Documentation/Manual/Textures.html) is a bitmap image. You can create textures in a digital content creation application, such as Photoshop, and import them into Unity.

In a 3D Project, Unity imports image and movie files in the Assets folder as Textures. In a 2D Project, Unity imports image and movie files in the Assets folder as Sprites.

As long as the image meets the [specified size requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingTextures.html#TextureSizes), Unity imports and optimizes it for game use. This extends to [multi-layer Photoshop PSD or TIFF files](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingTextures.html#formats).

To import image and movie files as Textures and Sprites in Unity:

1.  Select the image file in the Project window.
2.  In the Inspector, set the [Texture Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html).
3.  Click the **Apply** button to save the changes.
4.  To use the imported Assets in your Project:
    -   For 3D Projects, [create a Material](https://docs.unity3d.com/6000.3/Documentation/Manual/Materials.html) and assign the Texture to the new Material.
    -   For 2D Projects, refer to [Create sprites from a texture](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/sprite-editor/use-editor.html).

<span id="formats"></span>

### Supported file formats

Unity can read the following file formats:

-   BMP
-   EXR
-   GIF
-   HDR
-   IFF
-   JPG
-   PICT
-   PNG
-   PSD
-   TGA
-   TIFF
-   SVG

Unity automatically flattens multi-layer Photoshop PSD or TIFF files on import so that there is no size penalty for your game. This flattening happens to the imported data in Unity, not to the file itself, so you can continue to save and import your PSD or TIFF files without losing any of your work when using these file types natively. This allows you to have one copy of each Texture which you can use in Photoshop, your 3D modelling application, and in Unity.

When importing from an EXR or HDR file containing HDR information, the [Texture Importer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html) automatically chooses the right HDR format for the output Texture. This format changes automatically depending on which platform you are building for.

<span id="TextureSizes"></span>

## Texture dimensions

Ideally, Texture dimension sizes should be powers of two on each side (that is, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048 pixels (px), and so on). The Textures do not have to be square; the width can be different from height.

It is possible to use NPOT (non-power of two) Texture sizes with Unity. However, NPOT Texture sizes generally take slightly more memory and might be slower for the GPU to sample, so it’s better for performance to use power of two sizes whenever you can.

If the platform or GPU does not support NPOT Texture sizes, Unity scales and pads the Texture up to the next power of two size. This process uses more memory and makes loading slower (especially on older mobile devices). In general, you should only use NPOT sizes for GUI purposes.

You can scale up NPOT Texture Assets at import time using the **Non Power of 2** option in the **Advanced** section of the Texture Importer.

**Note:** Specific platforms may impose maximum Texture dimension sizes. For DirectX, the maximum Texture sizes for different feature levels are as follows:

| Graphics APIs / Feature levels                                                          | Maximum 2D and Cubemap texture dimension size (px) |
|:----------------------------------------------------------------------------------------|:---------------------------------------------------|
| DX9 Shader Model 2 (PC GPUs before 2004)                                                | 2048                                               |
| DX9 Shader Model 3 (PC GPUs before 2006) / Windows Phone DX11 9.3 level / OpenGL ES 3.0 | 4096                                               |
| DX10 Shader Model 4 / GL3 (PC GPUs before 2007) / OpenGL ES 3.1                         | 8192                                               |
| DX11 Shader Model 5 / GL4 (PC GPUs since 2008)                                          | 16384                                              |

**Notes:**

-   The Texture Importer only allows you to choose dimension sizes up to 16384 (16384 × 16384 pixels).
-   Most [Mali GPUs](https://en.wikipedia.org/wiki/Mali_(GPU)) support Texture dimension sizes up to 4K for cubemaps.

## Platform-specific overrides

When building for different platforms, you need to think about the resolution, the file size with associated memory size requirements, the quality of your Textures, and what compression format to use for each target platform. The **Platform-specific overrides** panel provides one tab for the **Default** options, and one tab for every target platform you are building for. Some texture import settings can also be overridden globally in [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html), mostly to speed up iteration time during development.

To set up override values:

1.  Set the default properties on the **Default** tab.
2.  Navigate to a specific target platform tab and enable the **Override for \<target-platform>** option.
3.  Set the override properties.

## Additional resources

-   [Textures reference](https://docs.unity3d.com/6000.3/Documentation/Manual/textures-reference.html)
