---
title: "Fundamental Unity types (Unity 6.3 Manual)"
page_title: "Unity - Manual: Fundamental Unity types"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/fundamental-unity-types.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/fundamental-unity-types.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Fundamental Unity types

Unity has some fundamental built-in classes that are particularly important for scripting. These are classes which your own custom types can inherit from to integrate with Editor and Engine functionality. It’s helpful to understand these types, their behavior, and why you should inherit from or use them.

For a complete reference of all the built-in classes and every member available, refer to the [Script Reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/index.html).

| **Topic**                                                                                                | **Description**                                                                                                                           |
|:---------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------|
| **[Object](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html)**                     | `UnityEngine.Object` is the base class for all objects the Editor can reference from fields in the Inspector window.                      |
| **[MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html)**       | Inherit from `MonoBehaviour` to make your script a component and control the behaviour of GameObjects and make them responsive to events. |
| **[ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html)** | Inherit from `ScriptableObject` to store data that’s independent of GameObjects.                                                          |
| **[Unity attributes](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-attributes.html)**       | Use Unity-specific C# attributes to define special behavior for your code.                                                                |

## Additional resources

-   [Unity Scripting reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/index.html)
