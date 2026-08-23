---
title: "Scripting API: Material constructor"
page_title: "Unity - Scripting API: Material.Material"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-ctor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-ctor.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Material Constructor

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

public <span class="sig-kw">Material</span>([Shader](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.html) <span class="sig-kw">shader</span>);

<span style="color:red;"> </span>

## Declaration

public <span class="sig-kw">Material</span>([Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html) <span class="sig-kw">source</span>);

### Parameters

| Parameter | Description                                                                                                         |
|-----------|---------------------------------------------------------------------------------------------------------------------|
| shader    | Create a material with a given [Shader](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.html). |
| source    | Create a material by copying all properties from another material.                                                  |

### Description

Create a temporary Material.

If you have a script which implements a custom special effect, you implement all the graphic setup using shaders & materials. Use this function to create a custom shader & material inside your script. After creating the material, use [SetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColor.html), [SetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetTexture.html), [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetFloat.html), [SetVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetVector.html), [SetMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetMatrix.html) to populate the shader property values.  
  
Additional resources: [Materials](https://docs.unity3d.com/6000.3/Documentation/Manual/Materials.html), [Shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/Shaders.html).

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

}
```
