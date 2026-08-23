---
title: "Unity 6.3 Manual: Model file formats reference"
page_title: "Unity - Manual: Model file formats reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/3D-formats.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/3D-formats.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Model file formats reference

Unity uses the `.fbx` file format as its internal importing chain. It’s best practice to use the `.fbx` file format whenever possible, and not use proprietary model file formats in production.

## Supported model file formats

Unity supports the following standard and proprietary model file formats.

### Standard file formats

Unity can read the following standard 3D file formats:

-   [.fbx](https://www.autodesk.com/products/fbx/overview)
-   [.dae (Collada)](https://www.khronos.org/collada/)
-   .dxf
-   .obj.

These file formats are widely supported. They’re also often smaller than the proprietary equivalent, which makes your project size smaller, and faster to iterate over.

You can also re-import exported .fbx or .obj files into your 3D modeling software of choice to check that all the information has been exported correctly.

### Proprietary file formats

Don’t use proprietary file formats in production and export to the `.fbx`format wherever possible. If you need to include these files as part of your project, then Unity can import proprietary files from the following 3D modeling software, and then convert them into `.fbx` files:

-   [Autodesk Maya](https://www.autodesk.com/products/maya/overview)
-   [Blender](https://www.blender.org/)
-   [Modo](https://www.foundry.com/products/modo)
-   [Cheetah3D](https://www.cheetah3d.com/)

For more information, refer to [Importing proprietary model files into Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/HOWTO-ImportObjectsFrom3DApps.html).

The following applications don’t use `.fbx` as an intermediary. Unity converts them into `.fbx` files before importing them into the Unity Editor:

-   [SketchUp](https://www.sketchup.com/)
-   [SpeedTree](https://unity.com/products/speedtree)
-   [Autodesk® 3ds Max®](https://www.autodesk.com/products/3ds-max/overview)

For more information, see the documentation on [SketchUp Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SketchUpImporter.html) and [SpeedTree Import Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SpeedTreeImporter.html).

## Unsupported model file formats

Unity doesn’t provide built-in support for Cinema4D files. To use Cinema4D files in Unity, export them from the proprietary software as `.fbx` files.

Assets saved as `.ma`, `.mb`, `.max`, `.c4d`, or `.blend` files fail to import unless you have the corresponding 3D modeling software installed on your computer. This means that everybody working on your Unity project must have the correct software installed.

## Additional resources

-   [Model Import Settings window](https://docs.unity3d.com/6000.3/Documentation/Manual/class-FBXImporter.html)
-   [Importing objects from 3D applications](https://docs.unity3d.com/6000.3/Documentation/Manual/HOWTO-ImportObjectsFrom3DApps.html)
-   [Creating and using Materials](https://docs.unity3d.com/6000.3/Documentation/Manual/Materials.html)
-   [Working with textures](https://docs.unity3d.com/6000.3/Documentation/Manual/Textures.html)
-   [Asset workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetWorkflow.html)
