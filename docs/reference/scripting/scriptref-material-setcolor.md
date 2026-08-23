---
title: "Scripting API: Material.SetColor"
page_title: "Unity - Scripting API: Material.SetColor"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColor.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html).SetColor

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Material.html" class="switch-link gray-btn sbtn left show" title="Go to Material Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetColor</span>(string <span class="sig-kw">name</span>, [Color](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Color.html) <span class="sig-kw">value</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetColor</span>(int <span class="sig-kw">nameID</span>, [Color](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Color.html) <span class="sig-kw">value</span>);

### Parameters

| Parameter | Description                                                                                                                                    |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------------|
| nameID    | Property name ID, use [Shader.PropertyToID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.PropertyToID.html) to get it. |
| name      | Property name. For example, "\_Color" in Built-in Render Pipeline, "\_BaseColor" in URP.                                                       |
| value     | Color value to set.                                                                                                                            |

### Description

Sets the value of a color- or vector-type property.

Many shaders use more than one color. Use SetColor to change the color (identified by shader property name, or unique property name ID).  
  
The behavior of this method depends on aspects of the target property and the project's active color space. A material property is considered to be in gamma space if either of the following are true:

-   The property is declared as a color and has the `[HDR]` attribute
-   The property is declared as a color or vector and has the `[Gamma]` attribute

If this method's target property is in gamma space and the project is in linear space, `value` is converted to linear space before being stored. Otherwise, `value` is stored without modification. For more information on color spaces, refer to [Color spaces in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/color-spaces.html).  
  
When setting color values on materials using the Standard Shader, you should be aware that you may need to use [EnableKeyword](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.EnableKeyword.html) to enable features of the shader that were not previously in use. For more detail, read [Accessing Materials via Script](https://docs.unity3d.com/6000.3/Documentation/Manual/MaterialsAccessingViaScript.html).  
  
Color property names are defined in the `Properties` section in the shader code. Here are examples of the color properties in Unity pre-built shaders:  
`_Color`: the main color of a material (URP: `_BaseColor`). You can access this shader property via the [color](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-color.html) property.  
`_EmissionColor`: the emissive color of a material. For more information on defining properties, refer to [Properties in Shader Programs](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-PropertiesInPrograms.html).  
  
Additional resources: [color](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-color.html), [GetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetColor.html), [Shader.PropertyToID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.PropertyToID.html).

``` codeExampleCS
//Attach this script to any GameObject in your scene to spawn a cube and change the material color
using UnityEngine;

public class Example : MonoBehaviour

}
```
