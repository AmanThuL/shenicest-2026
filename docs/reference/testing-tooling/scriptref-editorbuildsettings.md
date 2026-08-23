---
title: "Scripting API: EditorBuildSettings"
page_title: "Unity - Scripting API: EditorBuildSettings"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# EditorBuildSettings

class in UnityEditor

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html" class="cl">Object</a>

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

This class allows you to modify the Editor [Build Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/BuildSettings.html) via script.

EditorBuildSettings is stored in `ProjectSettings/EditorBuildSettings.asset`. Typically this file should be included in source control.  
  
**Scene List**  
  
The `ProjectSettings/EditorBuildSettings.asset` file contains the global scene list, which defines scenes to be included in the Player build. This list can be overridden by the active [BuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html). For more information see [Override settings with build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html).  
  
**Config Objects**  
  
EditorBuildSettings can be used to persist references to configuration objects.  
  
In this context a config object is an asset, typically a [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html), that contains configuration settings. The objects listed in EditorBuildSettings are not automatically included in the build, making them ideal for editor-only settings. These assets could be accessed by custom build scripts, build callbacks, or any other script running in the editor.  
  
API for working with config objects:

-   [EditorBuildSettings.AddConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.AddConfigObject.html)
-   [EditorBuildSettings.RemoveConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.RemoveConfigObject.html)
-   [EditorBuildSettings.TryGetConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.TryGetConfigObject.html)
-   [EditorBuildSettings.GetConfigObjectNames](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.GetConfigObjectNames.html)

**Config Object Example**  
  
Consider a package with a ScriptableObject-derived class for quality settings. You can customize these settings and create multiple assets, with different values for various contexts. Use [EditorBuildSettings.AddConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.AddConfigObject.html) to track which asset should be considered as the "active" setting, marked by a distinctive name. Then a build callback reads settings for the active quality settings by calling [EditorBuildSettings.TryGetConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.TryGetConfigObject.html) with the designated name.  
  
Note: A similar feature is available for config objects that need to be included in the Player build, making them accessible to scripts running in the Player. See [PlayerSettings.SetPreloadedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.SetPreloadedAssets.html) and [PlayerSettings.GetPreloadedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.GetPreloadedAssets.html).  
  
Additional resources: [EditorBuildSettingsScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettingsScene.html), [EditorUserBuildSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorUserBuildSettings.html), [BuildPlayerOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html), [SceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html), [IPreprocessBuildWithContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithContext.html).

### Static Properties

| Property                                                                                                            | Description                                                                                             |
|---------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| [globalScenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings-globalScenes.html) | The list of scenes used by all platform profiles and build profiles that do not override global scenes. |
| [scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings-scenes.html)             | The list of scenes in the active platform profile or build profile to be included in the build.         |

### Static Methods

| Method                                                                                                                              | Description                                                                        |
|-------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
| [AddConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.AddConfigObject.html)           | Store a reference to a config object by name.                                      |
| [GetConfigObjectNames](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.GetConfigObjectNames.html) | Return a string array containing the names of all stored config object references. |
| [RemoveConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.RemoveConfigObject.html)     | Remove a config object reference by name.                                          |
| [TryGetConfigObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.TryGetConfigObject.html)     | Retrieve a config object reference by name.                                        |

### Events

| Event                                                                                                                       | Description                                                   |
|-----------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| [sceneListChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings-sceneListChanged.html) | A delegate called whenever EditorBuildSettings.scenes is set. |

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
