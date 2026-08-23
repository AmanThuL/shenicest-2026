---
title: "Scripting API: BuildProfile"
page_title: "Unity - Scripting API: BuildProfile"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# BuildProfile

class in UnityEditor.Build.Profile

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html" class="cl">ScriptableObject</a>

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

Provides a set of configuration settings you can use to build your application on a particular platform.

Additional resources: [BuildPlayerWithProfileOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerWithProfileOptions.html).

### Properties

| Property                                                                                                                                   | Description                                                               |
|--------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| [overrideGlobalScenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile-overrideGlobalScenes.html) | Overrides the global scene list.                                          |
| [scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile-scenes.html)                             | The list of scenes specified in the build profile.                        |
| [scriptingDefines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile-scriptingDefines.html)         | Lists the user-specified script compilation defines in the build profile. |

### Public Methods

| Method                                                                                                                               | Description                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [AddComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.AddComponent.html)           | Adds a ScriptableObject to the build profile as a sub-asset. Only one instance per type can be embedded within a build profile.                                         |
| [CreateComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.CreateComponent.html)     | Creates a new instance of a given scriptable object and adds it as a sub-asset to the build profile. Only one instance per type can be embedded within a build profile. |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.GetComponent.html)           | Returns a component of type T. For PlayerSettings, returns the global fallback if no PlayerSettings component is found. Returns null if the component isn't available.  |
| [GetScenesForBuild](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.GetScenesForBuild.html) | Obtains the list of scenes used when building with the build profile.                                                                                                   |
| [RemoveComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.RemoveComponent.html)     | Removes a component of type T from a given build profile.                                                                                                               |

### Static Methods

| Method                                                                                                                                       | Description                                                                                                                                                                                          |
|----------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GetActiveBuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.GetActiveBuildProfile.html) | Gets the active build profile.                                                                                                                                                                       |
| [GetActiveComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.GetActiveComponent.html)       | Returns a component of type T from the active build profile. For PlayerSettings, returns the global fallback if no PlayerSettings component is found. Returns null if the component isn't available. |
| [SetActiveBuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.SetActiveBuildProfile.html) | Sets the active build profile.                                                                                                                                                                       |

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
| [CreateInstance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html)     | Creates an instance of a scriptable object.                                                                                                                 |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |

### Messages

| Message                                                                                                      | Description                                                                                          |
|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Awake.html)           | Called when an instance of ScriptableObject is created.                                              |
| [OnDestroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDestroy.html)   | This function is called when the scriptable object will be destroyed.                                |
| [OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDisable.html)   | This function is called when the scriptable object goes out of scope.                                |
| [OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnEnable.html)     | This function is called when the object is loaded.                                                   |
| [OnValidate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnValidate.html) | Editor-only function that Unity calls when the script is loaded or a value changes in the Inspector. |
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Reset.html)           | Reset to default values.                                                                             |
