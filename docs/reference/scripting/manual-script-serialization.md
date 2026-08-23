---
title: "Unity 6.3 Manual: Script serialization"
page_title: "Unity - Manual: Script serialization"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Script serialization

**Serialization** is the automatic process of transforming data structures or GameObject states into a format that Unity can store and reconstruct later.

How you organize data in your Unity project affects how Unity serializes that data, which can have a significant impact on the performance of your project. This page outlines serialization in Unity and how to optimize your project for it.

| **Topic**                                                                                                                     | **Description**                                                            |
|:------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------|
| [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html)                   | Conditions that determine whether fields in your scripts are serialized.   |
| [Custom serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-custom-serialization.html)   | How to serialize additional items not supported by Unity’s serializer.     |
| [How Unity uses serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-how-unity-uses.html) | More details about how serialization works in Unity.                       |
| [JSON Serialization](https://docs.unity3d.com/6000.3/Documentation/Manual/json-serialization.html)                            | Convert Unity objects to and from JSON format using the JsonUtility class. |
| [Serialization best practices](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-best-practices.html) | Best practices for serialization.                                          |

## Additional resources

-   [Script compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compilation.html)
-   [Scripting back ends](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html)
-   [Code reload in the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/code-reloading-editor.html)
