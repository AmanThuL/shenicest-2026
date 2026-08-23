---
title: "Unity 6.3 Manual: Preparing your model files for export"
page_title: "Unity - Manual: Preparing your model files for export"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/models-preparing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/models-preparing.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Preparing your model files for export

<span id="Scaling"></span>

## Scaling factors

Unity’s physics and lighting systems expect **1** meter in the game world to be **1** unit in the imported Model file.

The defaults for different 3D packages are as follows:

-   .fbx, .max, .jas = **0.01**
-   .3ds = **0.1**
-   .mb, .ma, .lxo, .dxf, .blend, .dae = **1**

When importing Model files into Unity from a 3D modeling application with a different scaling factor, you can convert the file units to use the Unity scale by enabling the [Convert Units](https://docs.unity3d.com/6000.3/Documentation/Manual/FBXImporter-Model.html#scene) option.

<span id="optimising"></span>

## Optimizing your files

Before you import your files into Unity, there are a number of steps you should follow to ensure that your files are optimized in the best way.

Think about what you want to export: some scene objects are essential but others might be unnecessary, so you can optimize the data in Unity by keeping only the essential objects. This helps remove unwanted data from your scene, and also means you can use a preset or custom scene exporter to automate or simplify the export process.

### Preparing what you need to include

The following table outlines special considerations you should make for each asset type to work most optimally in Unity:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Object</strong></th><th style="text-align: left;"><strong>Preparations</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Meshes</strong></td><td style="text-align: left;">All NURBS, NURMS, splines, patches, and subdiv surfaces must be converted to polygons (triangulation or quadrangulation)</td></tr><tr class="even"><td style="text-align: left;"><strong>Bake deformers</strong></td><td style="text-align: left;">Make sure that you bake deformers onto the models in your application before exporting to the .fbx file format. For example, if you want to export a complex rig from Maya, you can bake the deformation onto skin weights before you export the Model to .fbx.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Textures</strong></td><td style="text-align: left;">Make sure the textures in your application are either sourced from your Unity Project, or copy them into a folder called <code>Textures</code> inside your Unity Project.<br />
<br />
<strong>Note:</strong> Don’t use the <strong>Embed Media</strong> option to embed textures into the .fbx file. Because Unity has to extract the textures before it uses them, embedding them enlarges your project and slows the import process.</td></tr><tr class="even"><td style="text-align: left;"><strong>Smoothing</strong></td><td style="text-align: left;">If you want to import blend shape normals, you must have smoothing groups in the .fbx file.</td></tr></tbody></table>

### Setting the .fbx export options

Before you export the .fbx file, make sure that you use the latest .fbx exporter version that your 3D modeling application supports. When you export to .fbx, make a note of each setting in the export dialog of your 3D modeling application so that you can match up the .fbx import settings in Unity. Most .fbx exporters allow you to enable or disable exporting of certain animations, cameras, and lighting effects, so if anything is missing when you import it into Unity, check to see if it was exported.

## Verifying and importing into Unity

Before importing your .fbx file into Unity, verify the size of your exported file. Perform a sanity check on the file size (for example, to see if it is larger than 10KB). Re-import your .fbx file back into the 3D modeling software you used to generate it (for example, into a new scene). Check to make sure it is what you expected.

To import your file into Unity, follow the instructions for [Importing](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingModelFiles.html), keeping in mind how you set the export options in your 3D modeling software.
