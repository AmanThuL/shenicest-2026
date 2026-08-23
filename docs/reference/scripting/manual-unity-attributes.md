---
title: "Unity attributes (Unity 6.3 Manual)"
page_title: "Unity - Manual: Unity attributes"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/unity-attributes.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/unity-attributes.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity attributes

[Attributes](https://learn.microsoft.com/en-us/dotnet/csharp/advanced-topics/reflection-and-attributes/) in C# are metadata markers that can be placed above a class, property, or method declaration to indicate special behaviour.

There are many attributes defined in the .NET libraries and Unity also provides a number of custom, Unity-specific attributes. For example, you can add the `HideInInspector` attribute above a property declaration to prevent the Inspector from showing the property, even if it is public. Attributes are specified in square brackets above the declaration as follows:

``` lang-cs
[HideInInspector]
public float strength;
```

For the full list of `UnityEngine` attributes, refer to the list under **UnityEngine \> Attributes** in the Scripting API reference, which begins with [AddComponentMenu](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AddComponentMenu.html).

For the full list of `UnityEditor` attributes, refer to the list under **UnityEditor \> Attributes** in the Scripting API reference, which begins with [AssetPostprocessorStaticVariableIgnoreAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetPostprocessorStaticVariableIgnoreAttribute.html).

**Note:** Do not use the .NET [ThreadStatic](http://msdn.microsoft.com/en-us/library/system.threadstaticattribute.aspx) attribute as this causes a crash if you add it to a Unity script.

## Additional resources

-   [Unity Learn: attributes](https://learn.unity.com/tutorial/attributes#)
-   [Inspecting scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html)
-   [Script serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html)
