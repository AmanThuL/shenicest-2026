---
title: "Scripting API: AssetPostprocessor"
page_title: "Unity - Scripting API: AssetPostprocessor"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AssetPostprocessor

class in UnityEditor

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

AssetPostprocessor lets you hook into the import pipeline and run scripts before or after importing assets.

During model import the functions are called in the following order:

-   [OnPreprocessModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessModel.html) is called at the very beginning and you can override [ModelImporter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ModelImporter.html) settings that are used for the whole model import process.
-   After Meshes and Materials are imported, the GameObjects hierarchy is created from the imported nodes. Use [OnPostprocessMeshHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessMeshHierarchy.html) to change the hierarchy. Every GameObject that represents an imported node is given a corresponding MeshFilter, MeshRenderer, and MeshCollider component. Before assigning a Material to the MeshRenderer, the [OnAssignMaterialModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnAssignMaterialModel.html) function is invoked.
-   After GameObject has initialized MeshRenderers and user data exists [OnPostprocessGameObjectWithUserProperties](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessGameObjectWithUserProperties.html) is called. That happens before children GameObjects are generated.
-   If animation generation was not disabled at previous stages (see [ModelImporter.generateAnimations](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ModelImporter-generateAnimations.html)), then SkinnedMesh and Animations are generated. If possible, an Avatar is also created and the GameObject hierarchy is optimized. After that [OnPostprocessModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessModel.html) is called for the root GameObject.

[OnPreprocessSpeedTree](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessSpeedTree.html) and [OnPostprocessSpeedTree](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessSpeedTree.html) are called on SpeedTree assets (.spm file) the same way as [OnPreprocessModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessModel.html) and [OnPostprocessModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessModel.html), except that the [assetImporter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor-assetImporter.html) type is [SpeedTreeImporter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SpeedTreeImporter.html).  
  
**Important:** If you change the code of an AssetPostprocessor, you should default to incrementing its version number using [GetVersion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.GetVersion.html). For example, when there is a change to the output the AssetPostprocessor produces or the input dependencies it declares. For more information, refer to [Importer Consistency](https://docs.unity3d.com/6000.3/Documentation/Manual/ImporterConsistency.html).

### Properties

| Property                                                                                                             | Description                                |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
| [assetImporter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor-assetImporter.html) | Reference to the asset importer.           |
| [assetPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor-assetPath.html)         | The path name of the asset being imported. |
| [context](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor-context.html)             | The import context.                        |

### Public Methods

| Method                                                                                                                           | Description                                                        |
|----------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| [GetPostprocessOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.GetPostprocessOrder.html) | Returns the execution order priority for this asset postprocessor. |
| [GetVersion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.GetVersion.html)                   | Returns the version of the asset postprocessor.                    |

### Messages

| Message                                                                                                                                                                                      | Description                                                                                                                          |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| [OnAssignMaterialModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnAssignMaterialModel.html)                                                         | Feeds a source material.                                                                                                             |
| [OnPostprocessAllAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessAllAssets.html)                                                       | This is called after importing of any number of assets is complete (when the Assets progress bar has reached the end).               |
| [OnPostprocessAnimation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessAnimation.html)                                                       | This function is called when an AnimationClip has finished importing.                                                                |
| [OnPostprocessAssetbundleNameChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessAssetbundleNameChanged.html)                             | Handler called when asset is assigned to a different asset bundle.                                                                   |
| [OnPostprocessAudio](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessAudio.html)                                                               | Add this function to a subclass to get a notification when an audio clip has completed importing.                                    |
| [OnPostprocessCubemap](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessCubemap.html)                                                           | Add this function to a subclass to get a notification just before a cubemap texture has completed importing.                         |
| [OnPostprocessGameObjectWithAnimatedUserProperties](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessGameObjectWithAnimatedUserProperties.html) | Called when the animation curves for a custom property of type float are finished importing.                                         |
| [OnPostprocessGameObjectWithUserProperties](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessGameObjectWithUserProperties.html)                 | Gets called for each GameObject that had at least one user property attached to it in the imported file.                             |
| [OnPostprocessMaterial](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessMaterial.html)                                                         | Add this function to a subclass to get a notification when a new Material is created during an import of a ModelImporter.            |
| [OnPostprocessMeshHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessMeshHierarchy.html)                                               | This function is called when a new transform hierarchy has finished importing.                                                       |
| [OnPostprocessModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessModel.html)                                                               | Add this function to a subclass to get a notification when a model has completed importing.                                          |
| [OnPostprocessPrefab](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessPrefab.html)                                                             | Gets a notification when a Prefab completes importing.                                                                               |
| [OnPostprocessSpeedTree](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessSpeedTree.html)                                                       | Add this function to a subclass to get a notification when a SpeedTree asset has completed importing.                                |
| [OnPostprocessSprites](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessSprites.html)                                                           | Add this function to a subclass to get a notification when an texture of sprite(s) has completed importing.                          |
| [OnPostprocessTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessTexture.html)                                                           | Add this function to a subclass to get a notification when a texture2D has completed importing just before Unity compresses it.      |
| [OnPostprocessTexture2DArray](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessTexture2DArray.html)                                             | Add this function to a subclass to get a notification when a texture2DArray has completed importing just before Unity compresses it. |
| [OnPostprocessTexture3D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPostprocessTexture3D.html)                                                       | Add this function to a subclass to get a notification when a texture3D has completed importing just before Unity compresses it.      |
| [OnPreprocessAnimation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessAnimation.html)                                                         | Add this function to a subclass to get a notification just before animation from a model (.fbx, .mb file etc.) is imported.          |
| [OnPreprocessAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessAsset.html)                                                                 | Add this function to a subclass to get a notification just before any Asset is imported.                                             |
| [OnPreprocessAudio](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessAudio.html)                                                                 | Add this function to a subclass to get a notification just before an audio clip is being imported.                                   |
| [OnPreprocessCameraDescription](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessCameraDescription.html)                                         | Add this function to a subclass to receive a notification when a camera is imported from a Model Importer.                           |
| [OnPreprocessLightDescription](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessLightDescription.html)                                           | Add this function to a subclass to recieve a notification when a light is imported from a Model Importer.                            |
| [OnPreprocessMaterialDescription](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessMaterialDescription.html)                                     | Add this function to a subclass to recieve a notification when a new material is created during the import of a ModelImporter.       |
| [OnPreprocessModel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessModel.html)                                                                 | Add this function to a subclass to get a notification just before a model (.fbx, .mb file etc.) is imported.                         |
| [OnPreprocessSpeedTree](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessSpeedTree.html)                                                         | Add this function to a subclass to get a notification just before a SpeedTree asset (.spm file) is imported.                         |
| [OnPreprocessTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessor.OnPreprocessTexture.html)                                                             | Add this function to a subclass to get a notification just before the texture importer is run.                                       |
