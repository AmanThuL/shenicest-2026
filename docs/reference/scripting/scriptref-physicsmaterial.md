---
title: "Scripting API: PhysicsMaterial"
page_title: "Unity - Scripting API: PhysicsMaterial"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# PhysicsMaterial

class in UnityEngine

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html" class="cl">Object</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.PhysicsModule.html" class="cl">UnityEngine.PhysicsModule</a>

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PhysicsMaterial.html" class="switch-link gray-btn sbtn left show" title="Go to PhysicsMaterial Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Physics material describes how to handle colliding objects (friction, bounciness).

Additional resources: [Collider](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Collider.html).

### Properties

| Property                                                                                                              | Description                                                                                                   |
|-----------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| [bounceCombine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial-bounceCombine.html)     | Determines how the bounciness is combined.                                                                    |
| [bounciness](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial-bounciness.html)           | How bouncy is the surface? A value of 0 will not bounce. A value of 1 will bounce without any loss of energy. |
| [dynamicFriction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial-dynamicFriction.html) | The friction used when already moving. This value is usually between 0 and 1.                                 |
| [frictionCombine](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial-frictionCombine.html) | Determines how the friction is combined.                                                                      |
| [staticFriction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial-staticFriction.html)   | The friction coefficient used when an object is lying on a surface.                                           |

### Constructors

| Constructor                                                                                                | Description             |
|------------------------------------------------------------------------------------------------------------|-------------------------|
| [PhysicsMaterial](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PhysicsMaterial-ctor.html) | Creates a new material. |

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
