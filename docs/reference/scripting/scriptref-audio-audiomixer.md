---
title: "Scripting API: Audio.AudioMixer"
page_title: "Unity - Scripting API: AudioMixer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AudioMixer

class in UnityEngine.Audio

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html" class="cl">Object</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.AudioModule.html" class="cl">UnityEngine.AudioModule</a>

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

AudioMixer asset.

This is a singleton representing a specific audio mixer asset in the project.

### Properties

| Property                                                                                                                           | Description                                                                     |
|------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| [outputAudioMixerGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer-outputAudioMixerGroup.html) | Routing target.                                                                 |
| [updateMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer-updateMode.html)                       | How time should progress for this AudioMixer. Used during Snapshot transitions. |

### Public Methods

| Method                                                                                                                             | Description                                                                                                                                                                                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [ClearFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.ClearFloat.html)                       | Resets an exposed parameter to its initial value.                                                                                                                                                                                                                                 |
| [FindMatchingGroups](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.FindMatchingGroups.html)       | Returns mixer groups whose path contains the specified substring.                                                                                                                                                                                                                 |
| [FindSnapshot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.FindSnapshot.html)                   | The name must be an exact match.                                                                                                                                                                                                                                                  |
| [GetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.GetFloat.html)                           | Returns the value of the exposed parameter specified. If the parameter doesn't exist the function returns false. Prior to calling SetFloat and after ClearFloat has been called on this parameter the value returned will be that of the current snapshot or snapshot transition. |
| [SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html)                           | AudioMixer.SetFloat sets the value of the exposed parameter specified. Once you call this function, mixer snapshots will no longer control the exposed parameter, and you can only modify the parameter using AudioMixer.SetFloat.                                                |
| [TransitionToSnapshots](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.TransitionToSnapshots.html) | Transitions to a weighted mixture of the snapshots specified. This can be used for games that specify the game state as a continuum between states or for interpolating snapshots from a triangulated map location.                                                               |

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
