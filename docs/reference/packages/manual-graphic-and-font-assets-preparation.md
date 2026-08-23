---
title: "UI Toolkit BPG - Graphic and font assets preparation"
page_title: "Unity - Manual: Graphic and font assets preparation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Graphic and font assets preparation

Table of Contents

-   [Bitmap images](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#bitmap-images)

-   [Sprites](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#sprites)

-   [Render Texture asset](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#render-texture-asset)

-   [2D PSD Importer](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#2d-psd-importer)

-   [Vector images](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#vector-images)

-   [Fonts](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#fonts)

-   [Texture packers](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#texture-packers)

A lot of UI design happens outside of Unity in a Digital Content Creation (DCC) application. Depending on the style and preferences of the UI artist, designing the UI can take place in a raster drawing application like Adobe Photoshop or in a vector-based tool. Typically, every piece of UI graphic is exported as a lossless bitmap image with transparency, such as a PNG, and combined into a texture atlas with other UI elements for runtime efficiency.

If you work in a vector-based DCC application, you’ll need to export vector graphics into a raster format in order to work with UI Toolkit. For more details, refer to the Vector images [section](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/graphic-and-font-assets-preparation.html#vector-images).

<span id="bitmap-images"></span>

## Bitmap images

Unity supports most common image file types, like PNG, BMP, TIF, TGA, JPG, and PSD. When you add files of these formats to your Assets folder, Unity will import them as Texture 2D assets for 3D projects or as Sprites for 2D projects. You can change the type in the Texture Type field within the Inspector once imported. UI Toolkit supports both formats for UI bitmap graphics.

Textures don't contain much more information besides the size and format of the image, but sprites have some additional properties that are used by UI Toolkit.

<span id="sprites"></span>

## Sprites

Sprites are textures prepared for 2D game development to be used by the Sprite Renderer component. 2D sprites in Unity can be tiled, rigged and skinned for animation, have custom geometry or include additional maps for 2D lighting. This section solely focuses on settings that are relevant to the UI Toolkit. For a deeper understanding of 2D graphics you can find more in the Unity 6 edition of the 2D game art, animation, and lighting e-book that will soon be available at <https://unity.com/resources>.

Most UI graphic assets will be rendered on screen space rather than following Unity’s world scale (where one unit represents a cubic meter in 3D space). UI Toolkit manages the scale of these graphics, but the **PPU (Pixels Per Unit)** of sprites affects the size of the sprites in the UI. For example, if your sprite is meant to have 128 pixels of resolution per grid unit, set the PPU to 128.

The Sprite Editor provides tools for modifying your graphics, such as cropping with the blue handles or slicing with the green handles. These tools allow you to make the graphic tileable or use the [9-slice](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/9-slice/9-slicing.html) technique, a common way to create scalable elements.

Sprites are 2D textures mapped onto flat, rectangular 3D meshes. By default, when imported, they use the setting **Mesh Type**: **Tight**. This setting adjusts the mesh to closely follow the outline of the opaque (non-transparent) pixels of the sprite. This improves performance by reducing overdraw, which happens when the GPU draws the same pixel more than once within a single frame, due to transparent overlapping areas. You can manually adjust and optimize this mesh in the Sprite Editor under the Outline section.

**Sprite Modes** is a useful feature that you can select from the Inspector of a sprite asset. It provides the following modes:

-   **Single**: This is the default mode, where the image only contains a single image element.

-   **Multiple**: Choose this value if the texture source file has several elements in the same image. Then define the location of the elements in the [Sprite Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/sprite-editor/sprite-editor-landing) so that Unity knows how to split the image into different sub-assets. Once sliced, each graphic becomes an individual sprite that can be used separately in the UI Toolkit.

-   **Polygon:** Best for images that are circular or a regular polygon, this mode helps you to set up an outline that closely matches the image shape, resulting in a cleaner outline.

<span id="render-texture-asset"></span>

## Render Texture asset

Render textures are snapshots of a camera view in a texture, updated every frame. They can be created via **Assets \< Create \< Rendering** and referenced from a Camera component in the Output menu. You can then use these textures in the UI Toolkit to display elements such as mini-maps, character selection screens, or any other in-game visuals that need to be integrated into the UI.

Examples of render textures in [*UI Toolkit Sample: Dragon Crashers*](https://assetstore.unity.com/packages/essentials/tutorial-projects/dragon-crashers-ui-toolkit-sample-project-231178?srsltid=AfmBOopI1_drII69mU9Yvtc9PqO3LfvL5iG8brZ5sMOBD9_6CHfjH7I5) include the character preview in the level meter and the particle effects rendered over the UI buttons.

The opposite use case is also possible, where you want the UI to be displayed within a game element. For example, imagine a 3D computer model in your application displaying a functional interface made in UI Toolkit. You can render the UI Toolkit interface to a render texture, assign it in the Panel Settings and Camera, and then apply it to a material of the 3D model.

![The Render Texture settings and simple tests](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image265.png)

Just be aware that render textures are expensive. Use them sparingly and be sure to profile your project to optimize performance. For full screen interfaces without other active gameplay elements, adding extra effects this way is unlikely to pose major performance issues.

<span id="2d-psd-importer"></span>

## 2D PSD Importer

Unity imports PSD (or Adobe Photoshop files) as flattened textures unless your project has the 2D PSD Importer package installed. PSD files are generally used for storing multiple images in layers in one single file. Most DCC tools support exporting to this format.

![Creating the UI assets in Photoshop: Normally each element has its own layer, group, or is a smart object. Smart objects allow you to work on each element in isolation and preserve the original resolution of the element, even if resized later in the main document.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image54.png)

PSD files simplify workflows by allowing direct import into Unity, avoiding the need for you to export each layer as individual files and repeat the process whenever changes are needed.

After installing the [2D PSD Importer](https://docs.unity3d.com/Packages/com.unity.2d.psdimporter@10.0/manual/index.html) package from the Package manager, ensure the PSD files are imported from the Inspector.

![Select the PSD Importer in the Inspector to see options for handling the file.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image240.png)

When working with UI assets, deselect the **Use as Rig** option in the Inspector under **Character Rig**. That setting is only relevant for 2D character skeletal animation and is unnecessary for UI elements. You should also find options for importing layers (e.g., discarding hidden layers, grouping objects by layer, etc.)

![Switch to the PSD Importer to give yourself more import options.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image217.png)

The sprites in the Project view generated from the PSD are usable as normal sprites. You can slice them, change the outline, or modify the Pixels Per Unit (PPU) from the Sprite Editor just as you would with regular Sprite assets.

💡 **Tip: Iterative design**

Unity will automatically refresh the sprites included in the PSD file every time you save it. This allows you to make a quick placeholder and iterate on it while viewing changes in the Game view. This can be a great time saver and improve the quality of the work by letting you see it in context without swapping files or needing support from a fellow developer in the team.

<span id="vector-images"></span>

## Vector images

Although the vector format support is still in development at the time of writing, it’s available as an option for background images in the UI Builder. However, raster images (sprites and textures) are currently the recommended image format for UI Toolkit.

If you want to test this functionality, you will need the Vector Graphics package which is still in preview and hidden from the Package Manager by default. Follow the steps in the [documentation](https://docs.unity3d.com/Packages/com.unity.vectorgraphics@2.0/manual/index.html) to install it. This package includes a setting for defining the tessellation level when converting vector graphics into polygons. For the **Generated Asset Type** setting, choose **UI Toolkit Vector Image** to be able to use it in UI Toolkit.

![With the Vector Graphics package you can test using SVG images for your game or UI in a limited capacity.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image140.png)

Currently, SVG files are tessellated into polygons when rendering, which limits the benefits of vector images. You may notice polygonal edges when scaling up, rather than the smooth curved edges typical of vector images. At the time of writing, anti-aliasing is not yet enabled for UI Toolkit.

The finalized version of vector support is expected to be able to support real vector shapes natively, eliminating the need for a separate Vector Graphics package.

<span id="fonts"></span>

## Fonts

UI Toolkit supports both Font and FontAsset:

-   **Font:** Standard font formats, such as TTF or OTF, are supported for backwards compatibility. However, they are automatically converted to Font Assets when UI Builder finds them in the project (the converter is also available manually via the menu).

-   **[FontAsset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html):** This is the recommended format, and allows you to fine-tune aspects like kerning or baseline without modifying the original font asset. This is useful for the highly stylized fonts commonly found in games.

    -   Font Asset also provides precise control on how atlases are created, including the character set, resolution, and [atlas population options](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-font-asset.html). These settings can help reduce the memory footprint, especially when working with Unicode fonts that support languages with large amounts of characters.

<span id="texture-packers"></span>

## Texture packers

Combining 2D graphics into the same texture is a common optimization technique to reduce draw calls and improve memory usage. UI Toolkit supports two current atlasing systems.

### Sprite atlas

![A typical game UI atlas from the UI Toolkit Sample – *Dragon Crashers*](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image298.png)

[Sprite Atlas](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/atlas/atlas-landing.html) is Unity’s atlasing tool for 2D game development and sprites, but you can also use it for UI graphics. It automatically packs assets in the same project folder, creating an atlas for the sprites, and normal and mask maps. It also supports platform-specific variants and has an [API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/U2D.SpriteAtlas.html) for advanced control. Sprite Atlas is commonly used in the Editor to pack assets but not at runtime.

### Dynamic atlas

![Dynamic atlas generated from a Unity editor window, shown in the Texture Atlas Viewer, the atlas grows horizontally and vertically in multiples of 2 fitting in the max allowed texture size](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image58.png)

When UI graphics are not packed with Sprite Atlas, they are automatically packed with the [dynamic atlas](https://docs.unity3d.com/Manual/UIE-control-textures-of-the-dynamic-atlas.html) feature in UI Toolkit during a pre-pass.

The referenced images within a visual element will be atlased according to the criteria defined in the Panel Settings of the UI Document. For example, you can define the minimum or maximum texture sizes to be packed or filter images based on other properties. You can preview generated atlases in the Texture Atlas Viewer within the UI Toolkit Debugger.

The dynamic atlas tool works both at runtime and in the Editor, making it useful for UI elements that are dynamically generated, like a player’s inventory.

Common good practices for your graphics include:

-   Once you start creating mockup screens, make sure to set the highest target resolution in your drawing software to avoid having to redo work later. If you plan to support up to 4K graphics, for instance, make that your minimum working resolution.

-   Avoid scaling raster images up after they’re created. This can result in pixelation and blurriness, thereby lowering visual quality. Instead, begin from the highest resolution supported, then scale down when exporting from a graphics application.

-   If you design with vector graphics, resizing assets later is less of an issue. But try to work with a Reference Resolution, so that each asset has the correct relative scale – for example, keeping the outline thickness of the element consistent.

-   Make the most out of the [2D PSD Importer](https://docs.unity3d.com/Packages/com.unity.2d.psdimporter@10.0/manual/index.html) by importing PSDs directly into Unity. Any changes to a layer will be reflected in Unity once you save the PSD file. If you have the PSD file in Unity, it can also benefit from [Version Control](https://docs.unity.com/ugs/en-us/manual/devops/manual/unity-version-control).

-   Automate your import process. Avoid manually changing the asset settings every time you add a graphic asset. The [Preset](https://docs.unity3d.com/Manual/Presets.html) feature allows you to save settings applied to one asset and automatically apply them to all assets of the same kind in a given folder.

-   If you need to automate the process even further, such as running checks on assets, or mass-changing settings for multiple assets, you can use the [Asset PostProcessor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.html) API.
