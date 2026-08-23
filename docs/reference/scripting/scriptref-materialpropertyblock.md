---
title: "Scripting API: MaterialPropertyBlock"
page_title: "Unity - Scripting API: MaterialPropertyBlock"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# MaterialPropertyBlock

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

<span style="color:red;"> </span>

### Description

A block of material values to apply.

MaterialPropertyBlock is used by [Graphics.RenderMesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.RenderMesh.html) and [Renderer.SetPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.SetPropertyBlock.html). Use it in situations where you want to draw multiple objects with the same material, but slightly different properties. For example, if you want to slightly change the color of each mesh drawn. Changing the render state is not supported.  
  
Unity's terrain engine uses MaterialPropertyBlock to draw trees; all of them use the same material, but each tree has different color, scale & wind factor.  
  
The block passed to [Graphics.RenderMesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.RenderMesh.html) or [Renderer.SetPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.SetPropertyBlock.html) is copied, so the most efficient way of using it is to create one block and reuse it for all DrawMesh calls. Use [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetFloat.html), [SetVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetVector.html), [SetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetColor.html), [SetMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetMatrix.html), [SetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetTexture.html), [SetBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetBuffer.html) to add or replace values.  
  
Note that this is not compatible with [SRP Batcher](https://docs.unity3d.com/6000.3/Documentation/Manual/SRPBatcher.html). Using this in the Universal Render Pipeline (URP), High Definition Render Pipeline (HDRP) or a custom render pipeline based on the Scriptable Render Pipeline (SRP) will likely result in a drop in performance.  
  
The following example creates 10 GameObjects with random colors using `MaterialPropertyBlock`. To use the example, attach a prefab to the `myPrefab` property.  
  
Additional resources: [Graphics.RenderMesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Graphics.RenderMesh.html), [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html).

``` codeExampleCS
using UnityEngine;

public class CreateTenGameObjects : MonoBehaviour

    }
}
```

### Properties

| Property                                                                                                    | Description                                       |
|-------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| [isEmpty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock-isEmpty.html) | Is the material property block empty? (Read Only) |

### Public Methods

| Method                                                                                                                                              | Description                                                                                                                                                                                                                       |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Clear](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.Clear.html)                                             | Clear material property values.                                                                                                                                                                                                   |
| [CopyProbeOcclusionArrayFrom](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.CopyProbeOcclusionArrayFrom.html) | This function copies the entire source array into a Vector4 property array named unity_ProbesOcclusion for use with instanced Shadowmask rendering.                                                                               |
| [CopySHCoefficientArraysFrom](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.CopySHCoefficientArraysFrom.html) | This function converts and copies the entire source array into 7 Vector4 property arrays named unity_SHAr, unity_SHAg, unity_SHAb, unity_SHBr, unity_SHBg, unity_SHBb and unity_SHC for use with instanced light probe rendering. |
| [GetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetColor.html)                                       | Get a color from the property block.                                                                                                                                                                                              |
| [GetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetFloat.html)                                       | Get a float from the property block.                                                                                                                                                                                              |
| [GetFloatArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetFloatArray.html)                             | Get a float array from the property block.                                                                                                                                                                                        |
| [GetInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetInt.html)                                           | This method is deprecated. Use GetFloat or GetInteger instead.                                                                                                                                                                    |
| [GetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetInteger.html)                                   | Get an integer from the property block.                                                                                                                                                                                           |
| [GetMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetMatrix.html)                                     | Get a matrix from the property block.                                                                                                                                                                                             |
| [GetMatrixArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetMatrixArray.html)                           | Get a matrix array from the property block.                                                                                                                                                                                       |
| [GetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetTexture.html)                                   | Get a texture from the property block.                                                                                                                                                                                            |
| [GetVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetVector.html)                                     | Get a vector from the property block.                                                                                                                                                                                             |
| [GetVectorArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.GetVectorArray.html)                           | Get a vector array from the property block.                                                                                                                                                                                       |
| [HasBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasBuffer.html)                                     | Checks if MaterialPropertyBlock has the ComputeBuffer property with the given name or name ID. To set the property, use SetBuffer.                                                                                                |
| [HasColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasColor.html)                                       | Checks if MaterialPropertyBlock has the Color property with the given name or name ID. To set the property, use SetColor.                                                                                                         |
| [HasConstantBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasConstantBuffer.html)                     | Checks if MaterialPropertyBlock has the ConstantBuffer property with the given name or name ID. To set the property, use SetConstantBuffer.                                                                                       |
| [HasFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasFloat.html)                                       | Checks if MaterialPropertyBlock has the Float property with the given name or name ID. To set the property, use SetFloat.                                                                                                         |
| [HasInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasInt.html)                                           | This method is deprecated. Use HasFloat or HasInteger instead.                                                                                                                                                                    |
| [HasInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasInteger.html)                                   | Checks if MaterialPropertyBlock has the Integer property with the given name or name ID. To set the property, use SetInteger.                                                                                                     |
| [HasMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasMatrix.html)                                     | Checks if MaterialPropertyBlock has the Matrix property with the given name or name ID. This also works with the Matrix Array property. To set the property, use SetMatrix.                                                       |
| [HasProperty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasProperty.html)                                 | Checks if MaterialPropertyBlock has the property with the given name or name ID. To set the property, use one of the Set methods for MaterialPropertyBlock.                                                                       |
| [HasTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasTexture.html)                                   | Checks if MaterialPropertyBlock has the Texture property with the given name or name ID. To set the property, use SetTexture.                                                                                                     |
| [HasVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.HasVector.html)                                     | Checks if MaterialPropertyBlock has the Vector property with the given name or name ID. This also works with the Vector Array property. To set the property, use SetVector.                                                       |
| [SetBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetBuffer.html)                                     | Set a buffer property.                                                                                                                                                                                                            |
| [SetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetColor.html)                                       | Set a color property.                                                                                                                                                                                                             |
| [SetConstantBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetConstantBuffer.html)                     | Sets a ComputeBuffer or GraphicsBuffer as a named constant buffer for the MaterialPropertyBlock.                                                                                                                                  |
| [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetFloat.html)                                       | Set a float property.                                                                                                                                                                                                             |
| [SetFloatArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetFloatArray.html)                             | Set a float array property.                                                                                                                                                                                                       |
| [SetInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetInt.html)                                           | This method is deprecated. Use SetFloat or SetInteger instead.                                                                                                                                                                    |
| [SetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetInteger.html)                                   | Adds a property to the block. If an integer property with the given name already exists, the old value is replaced.                                                                                                               |
| [SetMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetMatrix.html)                                     | Set a matrix property.                                                                                                                                                                                                            |
| [SetMatrixArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetMatrixArray.html)                           | Set a matrix array property.                                                                                                                                                                                                      |
| [SetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetTexture.html)                                   | Set a texture property.                                                                                                                                                                                                           |
| [SetVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetVector.html)                                     | Set a vector property.                                                                                                                                                                                                            |
| [SetVectorArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.SetVectorArray.html)                           | Set a vector array property.                                                                                                                                                                                                      |
