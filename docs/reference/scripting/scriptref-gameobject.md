---
title: "Scripting API: GameObject"
page_title: "Unity - Scripting API: GameObject"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# GameObject

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html" class="switch-link gray-btn sbtn left show" title="Go to GameObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

Base class for all objects that can exist in a scene. Add components to a GameObject to control its appearance and behavior.

The `GameObject` is the fundamental object type in Unity. Use `GameObject` to represent everything in your project, including characters, props, and scenery. A `GameObject` acts as a container for functional [components](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) that determine how the GameObject looks and behaves.  
  
Any script that derives from [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) can be added to a `GameObject` as a component. Use the [Component.gameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component-gameObject.html) property from your `MonoBehaviour` code to access the `GameObject` the component is attached to.  
  
`MonoBehaviour` [event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html) such as the regular per-frame `MonoBehaviour.Update` allow you to make the object responsive to events. To receive these event callbacks the `GameObject` must be active in the scene, which means both the `activeSelf` and `activeInHierarchy` properties must be `true`.  
  
You can create an empty `GameObject` from code by invoking one of the [constructors](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-ctor.html). However, a more common method is to instantiate a `GameObject` in [Prefab](https://docs.unity3d.com/6000.3/Documentation/Manual/Prefabs.html) form, with preconfigured components, property values, and child objects. For more information, refer to [Instantiating Prefabs at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs.html) in the Manual.  
  
You can modify many of the properties of this class in the Editor using the Inspector window. For a more comprehensive guide to using the GameObject class, refer to [GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html) in the Manual.  
  
The following example creates a `GameObject` named "myExampleGO" and adds a component of type [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html):

``` codeExampleCS
  using UnityEngine;

  public class Example_GameObject : MonoBehaviour
  
  }
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html).

### Properties

| Property                                                                                                             | Description                                                                                               |
|----------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| [activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) | The active state of the GameObject in the Scene hierarchy. True if active, false if inactive. (Read Only) |
| [activeSelf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html)               | The local active state of the GameObject. True if active, false if inactive. (Read Only)                  |
| [isStatic](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-isStatic.html)                   | Whether there are any Static Editor Flags set for the GameObject.                                         |
| [layer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-layer.html)                         | Integer identifying the layer the GameObject is assigned to.                                              |
| [scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-scene.html)                         | The Scene that contains the GameObject.                                                                   |
| [sceneCullingMask](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-sceneCullingMask.html)   | The Scene culling mask defined for the GameObject. (Read Only)                                            |
| [tag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-tag.html)                             | The tag assigned to the GameObject.                                                                       |
| [transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-transform.html)                 | The Transform attached to the GameObject (Read Only).                                                     |
| [transformHandle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-transformHandle.html)     | The TransformHandle of the GameObject (Read Only).                                                        |

### Constructors

| Constructor                                                                                      | Description                                                                                           |
|--------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-ctor.html) | Creates a new GameObject, with optional parameters to specify a name and set of components to attach. |

### Public Methods

| Method                                                                                                                           | Description                                                                                                                            |
|----------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| [AddComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.AddComponent.html)                       | Adds a component of the specified type to the GameObject.                                                                              |
| [BroadcastMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.BroadcastMessage.html)               | Calls the specified method on every MonoBehaviour attached to the GameObject or any of its children.                                   |
| [CompareTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CompareTag.html)                           | Checks if the specified tag is attached to the GameObject.                                                                             |
| [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponent.html)                       | Retrieves a reference to a component of the specified type, by providing the component type as a type parameter to the generic method. |
| [GetComponentAtIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentAtIndex.html)         | Retrieves a reference to a component at a specified index of the GameObject's array of components.                                     |
| [GetComponentCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentCount.html)             | Retrieves the total number of components currently attached to the GameObject.                                                         |
| [GetComponentInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentInChildren.html)   | Retrieves a reference to a component of type T on the specified GameObject, or any child of the GameObject.                            |
| [GetComponentIndex](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentIndex.html)             | Retrieves the index of the specified component in the array of components attached to the GameObject.                                  |
| [GetComponentInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentInParent.html)       | Retrieves a reference to a component of type T on the specified GameObject, or any parent of the GameObject.                           |
| [GetComponents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponents.html)                     | Retrieves references to all components of type T on the specified GameObject.                                                          |
| [GetComponentsInChildren](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentsInChildren.html) | Retrieves references to all components of type T on the specified GameObject, and any child of the GameObject.                         |
| [GetComponentsInParent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetComponentsInParent.html)     | Retrieves references to all components of type T on the specified GameObject, and any parent of the GameObject.                        |
| [SendMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SendMessage.html)                         | Calls the specified method on every MonoBehaviour attached to the GameObject.                                                          |
| [SendMessageUpwards](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SendMessageUpwards.html)           | Calls the specified method on every MonoBehaviour attached to the GameObject and on every ancestor of the behaviour.                   |
| [SetActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html)                             | Activates or deactivates the GameObject locally, according to the value of the supplied parameter.                                     |
| [TryGetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.TryGetComponent.html)                 | Retrieves the component of the specified type, if it exists.                                                                           |

### Static Methods

| Method                                                                                                                         | Description                                                                                                                                                                                   |
|--------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [CreatePrimitive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.CreatePrimitive.html)               | Creates a GameObject of the specified PrimtiveType with a mesh renderer and appropriate collider.                                                                                             |
| [Find](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.Find.html)                                     | Finds and returns a GameObject with the specified name or hierarchy path.                                                                                                                     |
| [FindGameObjectsWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindGameObjectsWithTag.html) | Retrieves an array of all active GameObjects tagged with the specified tag. Returns an empty array if no GameObjects have the tag.                                                            |
| [FindWithTag](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.FindWithTag.html)                       | Retrieves the first active GameObject tagged with the specified tag. Returns null if no GameObject has the tag.                                                                               |
| [GetScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.GetScene.html)                             | Retrieves the Scene which contains the GameObject with the specified instance ID.                                                                                                             |
| [InstantiateGameObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.InstantiateGameObjects.html) | Creates a specified number of instances of a GameObject identified by its instance ID and populates NativeArrays with the instance IDs of the new GameObjects and their Transform components. |
| [SetGameObjectsActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetGameObjectsActive.html)     | Activates or deactivates multiple GameObjects identified by instance ID.                                                                                                                      |

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
