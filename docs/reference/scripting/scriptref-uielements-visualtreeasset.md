---
title: "Scripting API: UIElements.VisualTreeAsset"
page_title: "Unity - Scripting API: VisualTreeAsset"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# VisualTreeAsset

class in UnityEngine.UIElements

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html" class="cl">ScriptableObject</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.UIElementsModule.html" class="cl">UnityEngine.UIElementsModule</a>

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

An instance of this class holds a tree of `VisualElementAsset's`, created from a UXML file. Each node in the file corresponds to a `VisualElementAsset`. You can clone a `VisualTreeAsset` to create a tree of `VisualElement's`.  
  
**Note**: You can't generate a `VisualTreeAsset` from raw UXML at runtime.

The following example loads a VisualTreeAsset from a UXML file in a custom Editor script.

``` codeExampleCS
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

public class VisualTreeAssetExample : EditorWindow

    public void CreateGUI()
    
        else
        
    }
}
```

### Properties

| Property                                                                                                                                   | Description                                                           |
|--------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [contentHash](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset-contentHash.html)                   | A hash value computed from the template content.                      |
| [importedWithErrors](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset-importedWithErrors.html)     | Whether there were errors encountered while importing the UXML File   |
| [importedWithWarnings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset-importedWithWarnings.html) | Whether there were warnings encountered while importing the UXML File |
| [stylesheets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset-stylesheets.html)                   | The stylesheets used by this VisualTreeAsset.                         |
| [templateDependencies](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset-templateDependencies.html) | The UXML templates used by this VisualTreeAsset.                      |

### Public Methods

| Method                                                                                                                   | Description                                    |
|--------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| [CloneTree](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.CloneTree.html)     | Build a tree of VisualElements from the asset. |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.Instantiate.html) | Build a tree of VisualElements from the asset. |

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
