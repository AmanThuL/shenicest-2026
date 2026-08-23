---
title: "Scripting API: Material"
page_title: "Unity - Scripting API: Material"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Material

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html" class="cl">Object</a>

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Material.html" class="switch-link gray-btn sbtn left show" title="Go to Material Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

The material class.

This class exposes all properties from a material, allowing you to animate them. You can also use it to set custom shader properties that can't be accessed through the inspector (e.g. matrices).  
  
In order to get the material used by an object, use the [Renderer.material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html) property.  
  
Additional resources: [Materials](https://docs.unity3d.com/6000.3/Documentation/Manual/Materials.html), [Shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/Shaders.html).

### Properties

| Property                                                                                                                       | Description                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [color](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-color.html)                                     | The main color property of the Material.                                                                                                                                |
| [doubleSidedGI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-doubleSidedGI.html)                     | Gets and sets whether the Double Sided Global Illumination setting is enabled for this material.                                                                        |
| [enabledKeywords](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-enabledKeywords.html)                 | An array containing the local shader keywords that are currently enabled for this material.                                                                             |
| [enableInstancing](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-enableInstancing.html)               | Gets and sets whether GPU instancing is enabled for this material.                                                                                                      |
| [globalIlluminationFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-globalIlluminationFlags.html) | Defines how the material should interact with lightmaps and lightprobes.                                                                                                |
| [isVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-isVariant.html)                             | Returns true if this material is a material variant.                                                                                                                    |
| [mainTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-mainTexture.html)                         | The main texture.                                                                                                                                                       |
| [mainTextureOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-mainTextureOffset.html)             | Defines the UV offset for the main texture in the Material. This property adjusts the position of the texture mapping on a Mesh surface relative to its UV coordinates. |
| [mainTextureScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-mainTextureScale.html)               | The scale of the main texture.                                                                                                                                          |
| [parent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-parent.html)                                   | Parent of this material.                                                                                                                                                |
| [passCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-passCount.html)                             | How many passes are in this material (Read Only).                                                                                                                       |
| [rawRenderQueue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-rawRenderQueue.html)                   | Raw render queue of this material.                                                                                                                                      |
| [renderQueue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-renderQueue.html)                         | The render queue to use as an override on this material.                                                                                                                |
| [shader](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-shader.html)                                   | The shader used by the material.                                                                                                                                        |
| [shaderKeywords](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-shaderKeywords.html)                   | An array containing names of the local shader keywords that are currently enabled for this material.                                                                    |

### Constructors

| Constructor                                                                                  | Description |
|----------------------------------------------------------------------------------------------|-------------|
| [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material-ctor.html) |             |

### Public Methods

| Method                                                                                                                                               | Description                                                                                                                                      |
|------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| [ApplyPropertyOverride](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.ApplyPropertyOverride.html)                           | Applies an override associated with a Material Variant to a target.                                                                              |
| [ComputeCRC](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.ComputeCRC.html)                                                 | Computes a CRC hash value from the content of the material.                                                                                      |
| [CopyMatchingPropertiesFromMaterial](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.CopyMatchingPropertiesFromMaterial.html) | Copies properties, keyword states and settings from mat to this material, but only if they exist in both materials.                              |
| [CopyPropertiesFromMaterial](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.CopyPropertiesFromMaterial.html)                 | Copy properties from other material into this material.                                                                                          |
| [DisableKeyword](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.DisableKeyword.html)                                         | Disables a local shader keyword for this material.                                                                                               |
| [EnableKeyword](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.EnableKeyword.html)                                           | Enables a local shader keyword for this material.                                                                                                |
| [FindPass](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.FindPass.html)                                                     | Returns the index of the pass passName.                                                                                                          |
| [GetBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetBuffer.html)                                                   | Get a named Graphics Buffer value.                                                                                                               |
| [GetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetColor.html)                                                     | Get a named color value.                                                                                                                         |
| [GetColorArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetColorArray.html)                                           | Get a named color array.                                                                                                                         |
| [GetConstantBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetConstantBuffer.html)                                   | Get a named Constant Buffer value.                                                                                                               |
| [GetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetFloat.html)                                                     | Get a named float value.                                                                                                                         |
| [GetFloatArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetFloatArray.html)                                           | Get a named float array.                                                                                                                         |
| [GetInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetInt.html)                                                         | This method is deprecated. Use GetFloat or GetInteger instead.                                                                                   |
| [GetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetInteger.html)                                                 | Get a named integer value. If the integer property is not found an exception is thrown.                                                          |
| [GetMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetMatrix.html)                                                   | Get a named matrix value from the shader.                                                                                                        |
| [GetMatrixArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetMatrixArray.html)                                         | Get a named matrix array.                                                                                                                        |
| [GetPassName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetPassName.html)                                               | Returns the name of the shader pass at index pass.                                                                                               |
| [GetPropertyNames](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetPropertyNames.html)                                     | Retrieves a list of the named properties in the material that match the input property type.                                                     |
| [GetShaderPassEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetShaderPassEnabled.html)                             | Checks whether a given Shader pass is enabled on this Material.                                                                                  |
| [GetTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetTag.html)                                                         | Get the value of material's shader tag.                                                                                                          |
| [GetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetTexture.html)                                                 | Get a named texture.                                                                                                                             |
| [GetTextureOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetTextureOffset.html)                                     | Gets the placement offset of texture propertyName.                                                                                               |
| [GetTexturePropertyNameIDs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetTexturePropertyNameIDs.html)                   | Return the name IDs of all texture properties exposed on this material.                                                                          |
| [GetTexturePropertyNames](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetTexturePropertyNames.html)                       | Returns the names of all texture properties exposed on this material.                                                                            |
| [GetTextureScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetTextureScale.html)                                       | Gets the placement scale of texture propertyName.                                                                                                |
| [GetVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetVector.html)                                                   | Get a named vector value.                                                                                                                        |
| [GetVectorArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.GetVectorArray.html)                                         | Get a named vector array.                                                                                                                        |
| [HasBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasBuffer.html)                                                   | Checks if the ShaderLab file assigned to the Material has a ComputeBuffer property with the given name.                                          |
| [HasColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasColor.html)                                                     | Checks if the ShaderLab file assigned to the Material has a Color property with the given name.                                                  |
| [HasConstantBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasConstantBuffer.html)                                   | Checks if the ShaderLab file assigned to the Material has a ConstantBuffer property with the given name.                                         |
| [HasFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasFloat.html)                                                     | Checks if the ShaderLab file assigned to the Material has a Float property with the given name. This also works with the Float Array property.   |
| [HasInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasInt.html)                                                         | This method is deprecated. Use HasFloat or HasInteger instead.                                                                                   |
| [HasInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasInteger.html)                                                 | Checks if the ShaderLab file assigned to the Material has an Integer property with the given name.                                               |
| [HasMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasMatrix.html)                                                   | Checks if the ShaderLab file assigned to the Material has a Matrix property with the given name. This also works with the Matrix Array property. |
| [HasProperty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasProperty.html)                                               | Checks if the ShaderLab file assigned to the Material has a property with the given name.                                                        |
| [HasTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasTexture.html)                                                 | Checks if the ShaderLab file assigned to the Material has a Texture property with the given name.                                                |
| [HasVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.HasVector.html)                                                   | Checks if the ShaderLab file assigned to the Material has a Vector property with the given name. This also works with the Vector Array property. |
| [IsChildOf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.IsChildOf.html)                                                   | Returns True if the given material is an ancestor of this Material.                                                                              |
| [IsKeywordEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.IsKeywordEnabled.html)                                     | Checks whether a local shader keyword is enabled for this material.                                                                              |
| [IsPropertyLocked](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.IsPropertyLocked.html)                                     | Checks whether a property is locked by this material.                                                                                            |
| [IsPropertyLockedByAncestor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.IsPropertyLockedByAncestor.html)                 | Checks whether a property is locked by any of ancestor of this material.                                                                         |
| [IsPropertyOverriden](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.IsPropertyOverriden.html)                               | Checks whether a property is overriden by this material.                                                                                         |
| [Lerp](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.Lerp.html)                                                             | Interpolate properties between two materials.                                                                                                    |
| [RevertAllPropertyOverrides](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.RevertAllPropertyOverrides.html)                 | Removes all property overrides on this material.                                                                                                 |
| [RevertPropertyOverride](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.RevertPropertyOverride.html)                         | Removes the override on a property.                                                                                                              |
| [SetBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetBuffer.html)                                                   | Sets a named buffer value.                                                                                                                       |
| [SetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColor.html)                                                     | Sets the value of a color- or vector-type property.                                                                                              |
| [SetColorArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColorArray.html)                                           | Sets a color array property.                                                                                                                     |
| [SetConstantBuffer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetConstantBuffer.html)                                   | Sets a ComputeBuffer or GraphicsBuffer as a named constant buffer for the material.                                                              |
| [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetFloat.html)                                                     | Sets a named float value.                                                                                                                        |
| [SetFloatArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetFloatArray.html)                                           | Sets a float array property.                                                                                                                     |
| [SetInt](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetInt.html)                                                         | This method is deprecated. Use SetFloat or SetInteger instead.                                                                                   |
| [SetInteger](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetInteger.html)                                                 | Sets a named integer value.                                                                                                                      |
| [SetKeyword](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetKeyword.html)                                                 | Sets the state of a local shader keyword for this material.                                                                                      |
| [SetMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetMatrix.html)                                                   | Sets a named matrix for the shader.                                                                                                              |
| [SetMatrixArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetMatrixArray.html)                                         | Sets a matrix array property.                                                                                                                    |
| [SetOverrideTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetOverrideTag.html)                                         | Sets an override tag/value on the material.                                                                                                      |
| [SetPass](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetPass.html)                                                       | Activate the given pass for rendering.                                                                                                           |
| [SetPropertyLock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetPropertyLock.html)                                       | Sets the lock state of a property for this material.                                                                                             |
| [SetShaderPassEnabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetShaderPassEnabled.html)                             | Enables or disables a Shader pass on a per-Material level.                                                                                       |
| [SetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetTexture.html)                                                 | Sets a named texture.                                                                                                                            |
| [SetTextureOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetTextureOffset.html)                                     | Sets the placement offset of a given texture. The name parameter is defined in the shader. This method creates a new Material instance.          |
| [SetTextureScale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetTextureScale.html)                                       | Sets the placement scale of texture propertyName.                                                                                                |
| [SetVector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetVector.html)                                                   | Sets a value for a named vector in the material.                                                                                                 |
| [SetVectorArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetVectorArray.html)                                         | Sets a vector array property.                                                                                                                    |

### Inherited Members

### Properties

| Property                                                                                         | Description                                                                            |
|--------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html) | Controls whether the object is hidden, saved with the scene, and editable by the user. |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)           | The name of the object.                                                                |

### Public Methods

| Method                                                                                                   | Description                           |
|----------------------------------------------------------------------------------------------------------|---------------------------------------|
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)     | Returns the hash code for the object. |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html) | Gets the instance ID of the object.   |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)           | Returns the name of the object.       |

### Static Methods

| Method                                                                                                                   | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)                             | Removes a GameObject, component, or asset.                                                                                                                  |
| [DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)           | Destroys the specified object immediately. Use with caution and in Edit mode only.                                                                          |
| [DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html)         | Do not destroy the target Object when loading a new Scene.                                                                                                  |
| [FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)     | Retrieves any active loaded object of Type T.                                                                                                               |
| [FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) | Retrieves the first active loaded object of Type type.                                                                                                      |
| [FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html)         | Retrieves a list of all loaded objects of Type type and sorts the results according to sortMode.                                                            |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)                     | Clones the object original and returns the clone.                                                                                                           |
| [InstantiateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html)           | Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects. |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |
