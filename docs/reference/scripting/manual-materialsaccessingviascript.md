---
title: "Unity 6.3 Manual: Access material properties in a script"
page_title: "Unity - Manual: Access material properties in a script"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/MaterialsAccessingViaScript.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/MaterialsAccessingViaScript.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Access material properties in a script

All the parameters of a material asset that you see in the Inspector window are accessible via script, giving you the power to change or animate how a material works at runtime.

This allows you to modify numeric values on the material, change colours, and swap textures dynamically during gameplay. Some of the most commonly used methods to do this are:

| Method Name                                                                                          | Use                                                        |
|:-----------------------------------------------------------------------------------------------------|:-----------------------------------------------------------|
| [SetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColor.html)     | Change the color of a material (Eg. the albedo tint color) |
| [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetFloat.html)     | Set a floating point value (Eg. the normal map multiplier) |
| [SetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetInteger.html) | Set an integer value in the material                       |
| [SetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetTexture.html) | Assign a new texture to the material                       |

The full set of methods available for manipulating materials via script can be found on the [Material class scripting reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html).

One important note is that these methods **only set properties that are available for the current Shader object** on the material. This means that if you have a shader that doesn’t use any textures, or if you have no shader bound at all, calling [SetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetTexture.html) will have no effect. This is true even if you later set a shader that needs the texture. For this reason it is recommended to set the shader you want before setting any properties. However, after you have set the shader you can switch from one shader to another that use the same textures or properties and values will be preserved.
