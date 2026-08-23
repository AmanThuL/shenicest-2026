---
title: "Unity 6.3 Manual: Importing a model"
page_title: "Unity - Manual: Importing a model"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingModelFiles.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingModelFiles.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Importing a model

Model files can contain a variety of data, such as meshes, animation rigs and clips, materials, and textures.

Unity’s primary support for model files is the FBX format. However, you can save your 3D files from most common 3D modeling software in [their native format](https://docs.unity3d.com/6000.3/Documentation/Manual/HOWTO-ImportObjectsFrom3DApps.html) (for example, .max, .blend, .mb, .ma). When Unity finds these file types in your `Assets` folder, it calls your 3D modeling software’s FBX export plug-in, and imports the file. The 3D modeling software must be installed on the same computer as Unity, so in most cases it’s best practice to directly export as FBX from your application into your `Assets` folder.

## Adjusting model settings

To open a model’s Import Settings, select the model from the [Project window](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html). The [Inspector](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html) then displays the Import Settings for the selected model.

![The Import Settings window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/model-import-settings.png)

**Note:** A SpeedTree model has different importing settings. For more information, refer to [SpeedTree Model tab reference](https://docs.unity3d.com/6000.3/Documentation/Manual/SpeedTreeImporter-Model.html).

## Rig and animation settings

If your file contains animation data, you can set up the rig with the [Rig tab](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Rig.html) and then extract or define Animation Clips with the [Animation tab](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AnimationClip.html). The workflow differs between humanoid and generic animation types because Unity needs the humanoid’s bone structure to be specific, but only needs to know which bone is the root node for the generic type. For more information, refer to [Importing a model with humanoid animations](https://docs.unity3d.com/6000.3/Documentation/Manual/ConfiguringtheAvatar.html) and [Importing a model with non-humanoid (generic) animations](https://docs.unity3d.com/6000.3/Documentation/Manual/GenericAnimations.html).

## Importing materials

If your file contains materials and textures, you can define how you want to deal with them:

1.  Select a model file from the Project window.
2.  In the Inspector, select [the Materials tab](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html).
3.  Use the [Material Creation Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html) drop-down menu to choose how you want to import the materials from the FBX file.

## Importing textures

Unity follows a specific search pattern to automatically look for textures on import. First, the importer looks for a subfolder called `Textures` within the same folder as the mesh, or in any parent folder. If the [Search Textures Globally](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ModelImporter-searchTexturesGlobally.html) option is enabled, and the texture is not found near the model, Unity also performs an exhaustive search of all textures in the project. This is legacy behavior and can produce non-deterministic results when multiple textures share the same name.

For newly imported assets, **Search Textures Globally** is disabled by default. Existing assets imported with previous versions of Unity retain the previous behavior (enabled) for backward compatibility. You can change this setting on the [Materials tab](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html) of the model import settings.

## Importing normal maps

If you have a character with a [normal map](https://docs.unity3d.com/6000.3/Documentation/Manual/StandardShaderMaterialParameterNormalMap.html) that was generated from a high-polygon version of the model, import the game-quality version with the [Smoothing Angle](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#geometry) property set to 180°. This prevents odd-looking seams in lighting due to tangent splitting. If the seams are still present with these settings, choose the [Calculate Legacy With Split Tangents](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#geometry) setting from the **Tangents** drop-down menu. If you’re converting a grayscale image into a normal map, you don’t need to do this.

<span id="importing-blend-shapes"></span>

## Importing blend shapes

Unity supports blend shapes (morphing) and can import blend shapes from FBX and DAE files exported from 3D modeling applications. You can also import animation from FBX files. Unity supports vertex-level animation for blend shapes on vertices, normals and tangents.

Skin and blend shapes can affect meshes at the same time. When Unity imports meshes containing blend shapes, it uses the [`SkinnedMeshRenderer`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SkinnedMeshRenderer.html) component instead of the [`MeshRendere`r](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html) component, regardless of whether it has skin or not.

Unity imports blend shape animation as part of regular animation and animates blend shape weights on skinned mesh renderers.

To import blend shapes with normals perform one of the following:

-   Use the normals from the FBX file. In the **Model** tab, set the [Blend Shape Normals](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#geometry) property to **Import**.
-   Use the same logic to calculate normals on a mesh and blend shapes. In the **Model** tab, set the [Blend Shape Normals](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#geometry) property to **Calculate**.

**Note:** If you want tangents on your blend shapes then set the [Tangents](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#geometry) import setting to **Calculate**.

<span id="importing-visibility-properties"></span>

## Importing visibility properties

Unity can read visibility properties from FBX files with the [Import Visibility](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#scene) property. Values and animation curves can enable or disable MeshRenderer components by controlling the [`Renderer.enabled`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-enabled.html) property.

Visibility inheritance is true by default but can be overridden. For example, if the visibility on a parent mesh is set to 0, all the renderers on its children are also disabled. In this case, one animation curve is created for each child’s `Renderer.enabled` property.

Some 3D modeling applications either don’t support or have limitations with visibility properties. For more information refer to [Support for proprietary model file formats](https://docs.unity3d.com/6000.3/Documentation/Manual/HOWTO-ImportObjectsFrom3DApps.html).

<span id="camera-support"></span>

## Camera support

The following properties are supported when importing cameras from an FBX file:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Projection</strong> mode</td><td style="text-align: left;">Orthographic or perspective. Doesn’t support animation.</td></tr><tr class="even"><td style="text-align: left;"><strong>Field of View</strong></td><td style="text-align: left;">Supports animation.</td></tr><tr class="odd"><td style="text-align: left;">All <strong>Physical Camera</strong> properties</td><td style="text-align: left;">If you import a Camera with Physical Properties (for example, from Maya), Unity creates a Camera with the <strong>Physical Camera</strong> property enabled and the <strong>Focal Length</strong>, <strong>Sensor Type</strong>, <strong>Sensor Size</strong>, <strong>Lens Shift</strong>, and <strong>Gate Fit</strong> values from the FBX file.<br />
<br />
<strong>Note:</strong> Not all 3D modeling applications have a concept of <strong>Gate Fit</strong>. When not supported by the 3D modeling application, the default value in Unity is <strong>None</strong>.</td></tr><tr class="even"><td style="text-align: left;"><strong>Near</strong> and <strong>Far</strong> <strong>Clipping Plane</strong> distance</td><td style="text-align: left;">Unity doesn’t import any animation on these properties. When exporting from 3ds Max, enable the <strong>Clip Manually</strong> setting; otherwise the default values are applied on import.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Target Cameras</strong></td><td style="text-align: left;">If you import a Target Camera, Unity creates a camera with a <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-LookAtConstraint.html">LookAt</a> constraint using the target object as the source.</td></tr></tbody></table>

For more information, refer to [Camera Inspector window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html).

<span id="light-support"></span>

## Light support

The following light types are supported:

-   Omni
-   Spot
-   Directional
-   Area

The following light properties are supported:

| **Property**   | **Description**                                                                                                                    |
|:---------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| **Range**      | The **FarAttenuationEndValue** is used if **UseFarAttenuation** is enabled. **FarAttenuationEndValue** does not support animation. |
| **Color**      | Supports animation.                                                                                                                |
| **Intensity**  | Supports animation.                                                                                                                |
| **Spot Angle** | Supports animation. Only available for Spot Lights.                                                                                |

**Note**: In 3ds Max, the exported default value is the value of the property at the current selected frame. To avoid confusion, move the playhead to frame 0 when exporting.

### Limitations

Some 3D modeling applications apply scaling on light properties. For instance, you can scale a spotlight by its hierarchy and affect the light cone. Unity doesn’t do this, which can cause lights to look different in Unity.

The FBX format doesn’t define the width and height of area lights. Some 3D modeling applications don’t have this property and only allow you to use scaling to define the rectangle or disc area. Because of this, area lights always have a size of 1 when imported.

Targeted light animations aren’t supported unless their animation is baked.

## Using a model file

To add a model file to your scene perform one of the following actions:

-   If the model contains a mesh, drag the file into the Scene view to instantiate it as a [prefab](https://docs.unity3d.com/6000.3/Documentation/Manual/Prefabs.html) for a GameObject.
-   If it contains Animation Clips, drag the file into [the Animator window](https://docs.unity3d.com/6000.3/Documentation/Manual/AnimatorWindow.html) to use in [the State Machine](https://docs.unity3d.com/6000.3/Documentation/Manual/StateMachineBasics.html). You can also drag the animation directly onto an instantiated Prefab in the Scene view. This automatically creates an Animation Controller and connects the animation to the model.

## Additional resources

-   [Preparing humanoid models for export](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingHumanoidChars.html).
