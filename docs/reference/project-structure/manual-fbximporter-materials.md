---
title: "Unity 6.3 Manual: Materials tab (Model Import Settings)"
page_title: "Unity - Manual: Materials tab"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Materials tab

You can use this tab to change how Unity deals with materials and textures when importing your model.

When Unity imports a model without any material assigned, it uses the Unity diffuse material. If the model has materials, Unity imports them as subassets.

![The Materials tab defines how Unity imports materials and textures](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/FBXImporter-Materials-1.png)

If your model has textures, you can also extract them into your project using the [Extract Textures](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#textures) button.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Function</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Material Creation Mode</strong></td><td style="text-align: left;">Define how you want Unity to generate or import the materials for your model. When you choose <strong>None</strong> from this drop-down menu, the Inspector hides the rest of the settings on this tab. The following options are available:<ul><li><strong>None</strong> - Do not use any materials embedded within this model. Use Unity’s default diffuse material instead.</li><li><strong>Standard (Legacy)</strong> - On import, Unity applies a set of default rules to generate materials. If you want to customize how Unity generates material via scripting, choose the <strong>Import via MaterialDescription</strong> mode instead.</li><li><strong>Import via MaterialDescription</strong> - On import, Unity uses the material description embedded within the FBX file to generate the materials. This method provides more accurate results than previous import methods, and supports a wider range of material types, such as <a href="https://www.arnoldrenderer.com/home/">Arnold</a> and <a href="https://knowledge.autodesk.com/support/3ds-max/learn-explore/caas/CloudHelp/cloudhelp/2020/ENU/3DSMax-Lighting-Shading/files/GUID-809B9123-21A2-443E-A7A4-0DAB70410B8D-htm.html?st=Physical%20Material">Physical</a> from Autodesk, as well as Unity’s <a href="https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest?subfolder=/manual/Material-Type.html">HDRP Materials</a>. For more information, see the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#material_description">Material description</a> section below.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>sRGB Albedo Colors</strong></td><td style="text-align: left;">Enable this option to use Albedo colors in gamma space. This is enabled by default for legacy import methods.<br />
<br />
Disable this for Projects using <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/color-spaces-landing.html">linear color space</a>.<br />
<br />
This property is not available if you choose <strong>Import via MaterialDescription</strong> from the <strong>Material Creation Mode</strong> drop-down menu.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Location</strong></td><td style="text-align: left;">Define how to access the materials and textures. Different properties are available depending on which of these options you choose. The following options are available:<ul><li><strong>Use Embedded Materials</strong> - <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#Embedded">Keep the imported materials inside the imported asset</a>. This is the default option from Unity 2017.2 onwards.</li><li><strong>Use External Materials (Legacy)</strong> - <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#Legacy">Extract imported materials as external assets</a>. This is a Legacy way of handling materials, and is intended for Projects created with 2017.1 or previous versions of Unity.</li></ul></td></tr><tr class="even"><td style="text-align: left;"><strong>Search Textures Globally</strong></td><td style="text-align: left;">Legacy behavior. When enabled, the importer searches the entire project for textures if they are not found near the model file. This can produce non-deterministic results when multiple textures share the same name. This option is disabled by default for newly imported assets. Existing assets imported with previous versions of Unity retain this as enabled for backward compatibility.</td></tr></tbody></table>

<span id="Embedded"></span>

## Use Embedded Materials

When you choose **Use Embedded Materials** for the **Location** option, the following import options appear:

![Import settings for materials](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/FBXImporter-Materials-2.png)

<span id="textures"></span>

**(A)** Click the **Extract Materials** and **Extract textures** buttons to extract all materials and textures that are embedded in your imported asset. These are greyed out if there are no subassets to extract. Below these buttons, Unity displays any messages about the import process.

**(B)** The [On Demand Remap](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#remapped) section provides the [Naming](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#naming) and [Search](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#search) properties which allow you to customize how Unity maps imported materials to the model. Click the **Search and Remap** button to remap your imported materials to existing material assets. Nothing changes if Unity can’t find any materials with the correct name.

**(C)** Unity displays all imported materials found in the asset in the [Remapped Materials](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#remapped) list. If Unity can’t automatically match each material to an existing material asset in your Project, you can set references to the materials yourself in this list.

<span id="remapped"></span>

### Remapped Materials

New imports or changes to the original asset do not affect extracted materials. If you want to re-import the materials from the source asset, you need to remove the references to the extracted materials in the **Remapped Materials** list. To remove an item from the list, select it and press the Backspace key on your keyboard.

<span id="naming"></span>

### Naming

Define a naming strategy for the materials.

| **Property**                      | **Function**                                                                                                                                                                              |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **By Base Texture Name**          | Use the name of the diffuse texture of the imported material to name the material. When you don’t assign a diffuse texture to the material, Unity uses the name of the imported material. |
| **From Model’s Material**         | Use the name of the imported material to name the material.                                                                                                                               |
| **Model Name + Model’s Material** | Use the name of the model file in combination with the name of the imported material to name the material.                                                                                |

<span id="search"></span>

### Search

Define where Unity tries to locate existing materials when it uses the name defined by the **Naming** option.

| **Property**               | **Function**                                                                                               |
|:---------------------------|:-----------------------------------------------------------------------------------------------------------|
| **Local Materials Folder** | Find existing materials in the local `Materials` subfolder, which is in the same folder as the model file. |
| **Recursive-Up**           | Find existing materials in all materials subfolders in all parent folders up to the `Assets` folder.       |
| **Project-Wide**           | Find existing materials in all Unity Project folders.                                                      |

<span id="material_description"></span>

### Material description

Starting with version 2019.3, Unity introduced the ability to modify the material mapping during import via scripting. Users can modify how Unity maps the imported material properties from the data embedded in an FBX file to Unity material properties. The material description defines a name and several sets of values that describe the material and any textures it references. For more information about the structure of this description, see the [MaterialDescription](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetImporters.MaterialDescription.html) class reference page.

When in [ImportViaMaterialDescription](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ModelImporterMaterialImportMode.ImportViaMaterialDescription.html) mode, the model importer delegates the creation of materials to the [AssetPostProcessor.OnPreprocessMaterialDescription](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessMaterialDescription.html) callback.

Unity provides default implementations of this Post Processor that handle the following materials:

-   FBX Standard Material, Arnold Standard, Autodesk Interactive, and 3ds Physical Material from FBX files
-   Sketchup, Collada, and 3ds Materials

These default implementations handle importing materials differently from the [ImportStandard](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ModelImporterMaterialImportMode.ImportStandard.html) mode, including the following improvements:

-   It supports more material types, such as Autodesk’s [Arnold](https://www.arnoldrenderer.com/home/) and Interactive, or [Physical](https://knowledge.autodesk.com/support/3ds-max/learn-explore/caas/CloudHelp/cloudhelp/2020/ENU/3DSMax-Lighting-Shading/files/GUID-809B9123-21A2-443E-A7A4-0DAB70410B8D-htm.html?st=Physical%20Material), as well as Unity’s [HDRP Materials](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@latest/manual/Material-Type.html).

-   It supports [Emissive Materials](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-emissive-materials.html).

-   If a diffuse texture is set, it ignores the diffuse color (this matches how it works in Autodesk® Maya® and Autodesk® 3ds Max®).

-   It takes the bump factor, the emissive color, and emissive factor into account.

-   It imports emissive color animation when defined in the FBX file.

    **Note**: 3ds Max does not export emissive color animation, so Unity cannot import it.

-   It imports transparent materials as fully transparent. The legacy system imports them as fully opaque.

In addition, it imports all [Autodesk Interactive](https://knowledge.autodesk.com/support/3ds-max/learn-explore/caas/CloudHelp/cloudhelp/2020/ENU/3DSMax-Lighting-Shading/files/GUID-7EEAC650-7D26-40AE-AC14-577F7A2EF2B3-htm.html) material property animations and no longer ignores the opacity when importing materials from 3ds files.

<span id="Legacy"></span>

## Use External Materials (Legacy)

When you choose **Use External Materials (Legacy)** for the **Location** option, the following import options appear:

![Import settings for Use External Materials (Legacy)](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/FBXImporter-Materials-3.png)

This option extracts materials and saves them externally instead of saving them inside your model asset. The [Naming](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#naming) and [Search](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Materials.html#search) properties help Unity find imported materials to map to the model.

Before Unity version 2017.2, this was the default way of handling materials.
