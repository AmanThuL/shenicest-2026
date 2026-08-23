---
title: "ScriptableObject (Unity 6.3 Scripting API)"
page_title: "Unity - Scripting API: ScriptableObject"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ScriptableObject

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html" class="switch-link gray-btn sbtn left show" title="Go to ScriptableObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

### Description

A class you can derive from if you want to create objects that live independently of GameObjects.

Use ScriptableObjects to centralise data in a way that can be conveniently accessed from scenes and assets within a project.  
  
Instantiate ScriptableObject objects with [CreateInstance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html).  
  
You can save ScriptableObjects to asset files either from the Editor UI (see [CreateAssetMenuAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CreateAssetMenuAttribute.html)), or by calling [AssetDatabase.CreateAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.CreateAsset.html) from a script. You can also generate ScriptableObjects as an output from a [ScriptedImporter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetImporters.ScriptedImporter.html). See [AssetImportContext.AddObjectToAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetImporters.AssetImportContext.AddObjectToAsset.html).  
  
If a `ScriptableObject` has not been saved to an asset, and it's referenced from an object in a scene, Unity serializes it directly into the scene file. For ScriptableObjects that have only a single persistent instance within a project and are only used in Edit mode, you can use the [ScriptableSingleton\<T0>](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableSingleton_1.html) base class. For runtime singleton ScriptableObjects, you must implement your own singleton pattern and manage asset creation and loading manually.  
  
Access previously saved objects using [AssetDatabase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.html), for example [AssetDatabase.LoadAssetAtPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadAssetAtPath.html). When a ScriptableObject is referenced from a field on a [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html), the ScriptableObject is automatically loaded, so a script can simply use the value of the field to reach it.  
  
The C# fields of a `ScriptableObject` are serialized exactly like fields on a MonoBehaviour, refer to [Script Serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html) for details. Classes that include big arrays, or other potentially large data, should be declared with the [PreferBinarySerialization](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PreferBinarySerialization.html) attribute, because YAML is not an efficient representation for that sort of data.  
  
Calling `Destroy` on a `ScriptableObject` releases native resources associated with it but the object stays in memory until garbage collected. Objects in this detached state will appear to be null despite not really being so. However, this class doesn't support the [null-conditional operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/expressions#null-conditional-operator) (**?.**) and the [null-coalescing operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/expressions#the-null-coalescing-operator) (**??**).  
  
The following example demonstrates a typical use of a ScriptableObject: different types of vehicle parameters are represented in the fields of a VehicleTypeInfo class, derived from ScriptableObject. Each type of vehicle would have its own asset file, with the parameter values set appropriately for the type. Each instance of the vehicle in the game would have a reference to the asset corresponding to its type, rather than keeping its own redundant copy of each parameter. This design makes it convenient to tweak vehicle behaviour in a central location. It is also good for performance, especially in cases where the size of the shared data is substantial.  
  
The first script of the example implements a class derived from ScriptableObject.

``` codeExampleCS
using UnityEngine;

[CreateAssetMenu]
public class VehicleTypeInfo : ScriptableObject

```

The second script implements a MonoBehaviour that uses the ScriptableObject.

``` codeExampleCS
using UnityEngine;
using UnityEditor;

public class VehicleInstance : MonoBehaviour

    void Update()
    
}

public class ScriptableObjectVehicleExample

        VehicleTypeInfo cruiser = AssetDatabase.LoadAssetAtPath<VehicleTypeInfo>("Assets/VehicleTypeCruiser.asset");
        if (cruiser == null)
        
        // Step 2 - Create some example vehicles in the current scene
        
        
        
    }
}
```

### Static Methods

| Method                                                                                                               | Description                                 |
|----------------------------------------------------------------------------------------------------------------------|---------------------------------------------|
| [CreateInstance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html) | Creates an instance of a scriptable object. |

### Messages

| Message                                                                                                      | Description                                                                                          |
|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Awake.html)           | Called when an instance of ScriptableObject is created.                                              |
| [OnDestroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDestroy.html)   | This function is called when the scriptable object will be destroyed.                                |
| [OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDisable.html)   | This function is called when the scriptable object goes out of scope.                                |
| [OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnEnable.html)     | This function is called when the object is loaded.                                                   |
| [OnValidate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnValidate.html) | Editor-only function that Unity calls when the script is loaded or a value changes in the Inspector. |
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Reset.html)           | Reset to default values.                                                                             |

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
