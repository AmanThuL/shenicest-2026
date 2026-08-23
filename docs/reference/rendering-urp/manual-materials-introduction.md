---
title: "Unity 6.3 Manual: Introduction to materials"
page_title: "Unity - Manual: Introduction to materials"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/materials-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/materials-introduction.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to materials

To draw something in Unity, you must provide information that describes its shape, and information that describes the appearance of its surface. You use [meshes](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Mesh.html) to describe shapes, and materials to describe the appearance of surfaces.

Materials and shaders are closely linked; you always use materials with shaders.

## Render pipeline compatibility

| Feature   | Universal Render Pipeline (URP) | High Definition Render Pipeline (HDRP) | Custom Scriptable Render Pipeline (SRP) | Built-in Render Pipeline |
|:----------|:--------------------------------|:---------------------------------------|:----------------------------------------|:-------------------------|
| Materials | Yes                             | Yes                                    | Yes                                     | Yes                      |

<span id="fundamentals"></span>

## Material fundamentals

A material contains a reference to a [Shader object](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-objects.html). If that Shader object defines [material properties](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-Properties.html), then the material can also contain data such as colors or references to textures.

The [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html) class represents a material in C# code. For information, see [Using Materials with C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/MaterialsAccessingViaScript.html).

A material asset is a file with the `.mat` extension. It represents a material in your Unity project. For information on viewing and editing a material asset using the Inspector window, see [Material Inspector reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Material.html).

## Material Variants

Unity supports functionality for creating variants of Materials. To learn more about this functionality, see [Material Variants](https://docs.unity3d.com/6000.3/Documentation/Manual/materialvariant-landingpage.html).
