---
title: "Scripting API: Renderer"
page_title: "Unity - Scripting API: Renderer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Renderer

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html" class="cl">Component</a>

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

General functionality for all renderers.

A renderer is what makes an object appear on the screen. Use this class to access the renderer of any object, mesh or Particle System. Renderers can be disabled to make objects invisible (see [enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-enabled.html)), and the materials can be accessed and modified through them (see [material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html)).  
  
Additional resources: Renderer components for [meshes](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html), [particles](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ParticleSystemRenderer.html), [lines](https://docs.unity3d.com/6000.3/Documentation/Manual/class-LineRenderer.html) and [trails](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TrailRenderer.html).

### Properties

| Property                                                                                                                                                                           | Description                                                                                                                                        |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| [allowOcclusionWhenDynamic](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-allowOcclusionWhenDynamic.html)                                                 | Controls if dynamic occlusion culling should be performed for this renderer.                                                                       |
| [bounds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-bounds.html)                                                                                       | The bounding box of the renderer in world space.                                                                                                   |
| [enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-enabled.html)                                                                                     | Makes the rendered 3D object visible if enabled.                                                                                                   |
| [forceMeshLod](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-forceMeshLod.html)                                                                           | Force a specific Mesh LOD level for this renderer if the mesh has Mesh LODs. If the value is -1, Unity uses the default Mesh LOD selection method. |
| [forceRenderingOff](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-forceRenderingOff.html)                                                                 | Allows turning off rendering for a specific component.                                                                                             |
| [isLOD0](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-isLOD0.html)                                                                                       | Is the renderer the first LOD level in its group.                                                                                                  |
| [isPartOfStaticBatch](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-isPartOfStaticBatch.html)                                                             | Indicates whether the renderer is part of a static batch with other renderers.                                                                     |
| [isVisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-isVisible.html)                                                                                 | Is this renderer visible in any camera? (Read Only)                                                                                                |
| [lightmapIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-lightmapIndex.html)                                                                         | The index of the baked lightmap applied to this renderer.                                                                                          |
| [lightmapScaleOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-lightmapScaleOffset.html)                                                             | The UV scale & offset used for a lightmap.                                                                                                         |
| [lightProbeProxyVolumeOverride](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-lightProbeProxyVolumeOverride.html)                                         | If set, the Renderer will use the Light Probe Proxy Volume component attached to the source GameObject.                                            |
| [lightProbeUsage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-lightProbeUsage.html)                                                                     | The light probe interpolation type.                                                                                                                |
| [localBounds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-localBounds.html)                                                                             | The bounding box of the renderer in local space.                                                                                                   |
| [localToWorldMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-localToWorldMatrix.html)                                                               | Matrix that transforms a point from local space into world space (Read Only).                                                                      |
| [LODGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.LODGroup.html)                                                                                   | The LODGroup for this Renderer.                                                                                                                    |
| [material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html)                                                                                   | Returns the first instantiated Material assigned to the renderer.                                                                                  |
| [materials](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-materials.html)                                                                                 | Returns all the instantiated materials of this object.                                                                                             |
| [meshLodSelectionBias](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-meshLodSelectionBias.html)                                                           | Bias to add to the calculated value when selecting a Mesh LOD level.                                                                               |
| [motionVectorGenerationMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-motionVectorGenerationMode.html)                                               | Specifies the mode for motion vector rendering.                                                                                                    |
| [probeAnchor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-probeAnchor.html)                                                                             | If set, Renderer will use this Transform's position to find the light or reflection probe.                                                         |
| [rayTracingAccelerationStructureBuildFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-rayTracingAccelerationStructureBuildFlags.html)                 | The flags Unity uses when it builds acceleration structures associated with geometry used by renderers.                                            |
| [rayTracingAccelerationStructureBuildFlagsOverride](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-rayTracingAccelerationStructureBuildFlagsOverride.html) | Whether to override the default build flags specified when creating a RayTracingAccelerationStructure.                                             |
| [rayTracingMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-rayTracingMode.html)                                                                       | Describes how this renderer is updated for ray tracing.                                                                                            |
| [realtimeLightmapIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-realtimeLightmapIndex.html)                                                         | The index of the real-time lightmap applied to this renderer.                                                                                      |
| [realtimeLightmapScaleOffset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-realtimeLightmapScaleOffset.html)                                             | The UV scale & offset used for a real-time lightmap.                                                                                               |
| [receiveShadows](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-receiveShadows.html)                                                                       | Does this object receive shadows?                                                                                                                  |
| [reflectionProbeUsage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-reflectionProbeUsage.html)                                                           | Should reflection probes be used for this Renderer?                                                                                                |
| [rendererPriority](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-rendererPriority.html)                                                                   | This value sorts renderers by priority. Lower values are rendered first and higher values are rendered last.                                       |
| [renderingLayerMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-renderingLayerMask.html)                                                               | Determines which rendering layer this renderer lives on, if you use a scriptable render pipeline.                                                  |
| [shadowCastingMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-shadowCastingMode.html)                                                                 | Does this object cast shadows?                                                                                                                     |
| [sharedMaterial](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sharedMaterial.html)                                                                       | The shared material of this object.                                                                                                                |
| [sharedMaterials](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sharedMaterials.html)                                                                     | All the shared materials of this object.                                                                                                           |
| [sortingLayerID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sortingLayerID.html)                                                                       | Unique ID of the Renderer's sorting layer.                                                                                                         |
| [sortingLayerName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sortingLayerName.html)                                                                   | Name of the Renderer's sorting layer.                                                                                                              |
| [sortingOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sortingOrder.html)                                                                           | Renderer's order within a sorting layer.                                                                                                           |
| [staticShadowCaster](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-staticShadowCaster.html)                                                               | Is this renderer a static shadow caster?                                                                                                           |
| [worldToLocalMatrix](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-worldToLocalMatrix.html)                                                               | Matrix that transforms a point from world space into local space (Read Only).                                                                      |

### Public Methods

| Method                                                                                                                               | Description                                                                                                                                                                                       |
|--------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GetClosestReflectionProbes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.GetClosestReflectionProbes.html) | Returns an array of closest reflection probes with weights, weight shows how much influence the probe has on the renderer, this value is also used when blending between reflection probes occur. |
| [GetMaterials](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.GetMaterials.html)                             | Returns all the instantiated materials of this object.                                                                                                                                            |
| [GetPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.GetPropertyBlock.html)                     | Get per-Renderer or per-Material property block.                                                                                                                                                  |
| [GetSharedMaterials](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.GetSharedMaterials.html)                 | Returns all the shared materials of this object.                                                                                                                                                  |
| [HasPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.HasPropertyBlock.html)                     | Returns true if the Renderer has a material property block attached via SetPropertyBlock.                                                                                                         |
| [ResetBounds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.ResetBounds.html)                               | Reset custom world space bounds.                                                                                                                                                                  |
| [ResetLocalBounds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.ResetLocalBounds.html)                     | Reset custom local space bounds.                                                                                                                                                                  |
| [SetMaterials](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.SetMaterials.html)                             | Assigns the shared materials of this renderer using the list of materials provided.                                                                                                               |
| [SetPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.SetPropertyBlock.html)                     | Lets you set or clear per-renderer or per-material parameter overrides.                                                                                                                           |
| [SetSharedMaterials](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.SetSharedMaterials.html)                 | Assigns the shared materials of this renderer using the list of materials provided.                                                                                                               |

### Messages

| Message                                                                                                            | Description                                                                     |
|--------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| [OnBecameInvisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.OnBecameInvisible.html) | OnBecameInvisible is called when the object is no longer visible by any camera. |
| [OnBecameVisible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.OnBecameVisible.html)     | OnBecameVisible is called when the object became visible by any camera.         |

### Inherited Members

### Properties

| Property                                                                                                        | Description                                                                                     |
|-----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| [gameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-gameObject.html)           | The game object this component is attached to. A component is always attached to a game object. |
| [tag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-tag.html)                         | The tag of this game object.                                                                    |
| [transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transform.html)             | The Transform attached to this GameObject.                                                      |
| [transformHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-transformHandle.html) | The TransformHandle of this GameObject.                                                         |
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html)                | Controls whether the object is hidden, saved with the scene, and editable by the user.          |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)                          | The name of the object.                                                                         |

### Public Methods

| Method                                                                                                                          | Description                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| [BroadcastMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.BroadcastMessage.html)               | Calls the method named methodName on every MonoBehaviour in this game object or any of its children.                             |
| [CompareTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.CompareTag.html)                           | Checks the GameObject's tag against the defined tag.                                                                             |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponent.html)                       | Gets a reference to a component of type T on the same GameObject as the component specified.                                     |
| [GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInChildren.html)   | Gets a reference to a component of type T on the same GameObject as the component specified, or any child of the GameObject.     |
| [GetComponentIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentIndex.html)             | Gets the index of the component on its parent GameObject.                                                                        |
| [GetComponentInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentInParent.html)       | Gets a reference to a component of type T on the same GameObject as the component specified, or any parent of the GameObject.    |
| [GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponents.html)                     | Gets references to all components of type T on the same GameObject as the component specified.                                   |
| [GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInChildren.html) | Gets references to all components of type T on the same GameObject as the component specified, and any child of the GameObject.  |
| [GetComponentsInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.GetComponentsInParent.html)     | Gets references to all components of type T on the same GameObject as the component specified, and any parent of the GameObject. |
| [SendMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessage.html)                         | Calls the method named methodName on every MonoBehaviour in this game object.                                                    |
| [SendMessageUpwards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.SendMessageUpwards.html)           | Calls the method named methodName on every MonoBehaviour in this game object and on every ancestor of the behaviour.             |
| [TryGetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.TryGetComponent.html)                 | Gets the component of the specified type, if it exists.                                                                          |
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)                            | Returns the hash code for the object.                                                                                            |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html)                        | Gets the instance ID of the object.                                                                                              |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)                                  | Returns the name of the object.                                                                                                  |

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
