---
title: "Scripting API: Object"
page_title: "Unity - Scripting API: Object"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Object

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Base class for all objects Unity can reference.

`UnityEngine.Object` is the base class for all built-in Unity objects. Don't derive from or instantiate this class directly. Instead, use the appropriate subclass such as [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html), [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html), or [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html).  
  
Any public variable you make that derives from `UnityEngine.Object` is shown in the Inspector as a drop target, allowing you to set the value from the GUI.  
  
Some APIs are designed to work with any Unity Object, so Object appears as a type in their signatures. For example, [Resources.LoadAll](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.LoadAll.html), [EditorJsonUtility.ToJson](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorJsonUtility.ToJson.html) and [SerializedObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedObject.html).  
  
Each instance of a class that derives from `UnityEngine.Object` is linked to a counterpart native object. If the native counterpart is destroyed before the managed object is garbage collected, or if the instance references a missing asset or missing type, the managed instance can be in a detached state.  
  
Detached objects retain their InstanceID, but the object can't be used to call methods or access properties. Comparing objects in this state with `null` evaluates `true`, because of Unity's custom implementation of the equality (`==`) and inequality (`!=`) operators and [Object.bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html). However, because the managed object is not truly null, a call to `Object.ReferenceEquals(myobject, null)` returns `false`.  
  
The [null-conditional operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/expressions#null-conditional-operator) (`?.`) and the [null-coalescing operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/expressions#the-null-coalescing-operator) (`??`) are not supported with Unity Objects because they can't be overridden to treat detached objects the same as null. It's only safe to use those operators if the checked objects are guaranteed to never be in a detached state.  
  
Additional resources: [Object in the Unity manual](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html).

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
