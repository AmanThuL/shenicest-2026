---
title: "Avoid C# reflection overhead"
page_title: "Unity - Manual: Avoid C# reflection overhead"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-gc-avoid-reflection.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-gc-avoid-reflection.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Avoid C# reflection overhead

Both the [Mono](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-mono.html) and [IL2CPP](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-il2cpp.html) scripting backends internally cache all C# [`System.Reflection`](https://learn.microsoft.com/en-us/dotnet/api/system.reflection?view=net-9.0) objects and Unity doesn’t garbage collect them. This means the garbage collector continuously scans the cached C# reflection objects during the lifetime of your application, which causes unnecessary and potentially significant garbage collector overhead.

To minimize the garbage collector overhead, avoid using methods that create a lot of C# reflection objects at runtime, such as [`Assembly.GetTypes`](https://docs.microsoft.com/en-us/dotnet/api/system.reflection.assembly.gettypes) and [`Type.GetMethods`](https://docs.microsoft.com/en-us/dotnet/api/system.type.getmethods). Instead, scan assemblies in the Unity Editor for the required data and serialize it or use code generation to make the data available for use at runtime.

## Scan assemblies in the Editor

The following example shows how to scan assemblies in the Editor, serialize the data, and use it at runtime without reflection. Suppose you want to find all types that implement an interface called `IMyFeature` and use that information at runtime. You can write an Editor script that scans for all types implementing `IMyFeature` and saves their names to a `ScriptableObject` or a JSON file as follows:

``` lang-cs
using UnityEngine;
using UnityEditor;
using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

[CreateAssetMenu(menuName = "Feature/FeatureTypeList")]
public class FeatureTypeList : ScriptableObject

public static class FeatureTypeScanner
{
    [MenuItem("Tools/Scan IMyFeature Types")]
    public static void ScanTypes()
    {
        var featureType = typeof(IMyFeature);
        var types = AppDomain.CurrentDomain.GetAssemblies()
            .SelectMany(a => a.GetTypes())
            .Where(t => featureType.IsAssignableFrom(t) && !t.IsInterface && !t.IsAbstract)
            .Select(t => t.FullName)
            .ToList();

        // Create/overwrite the asset
        var asset = ScriptableObject.CreateInstance<FeatureTypeList>();
        asset.typeNames = types;
        AssetDatabase.CreateAsset(asset, "Assets/FeatureTypeList.asset");
        AssetDatabase.SaveAssets();

        Debug.Log($"Found {types.Count} types implementing IMyFeature. Saved to FeatureTypeList.asset");
    }
}
```

Run **Tools \> Scan IMyFeature Types** from the menu. This will create `Assets/FeatureTypeList.asset` containing the list of type names.

At runtime, you can load this asset and use the type names for instantiation via `Activator.CreateInstance`, or just for display. No reflection is needed if you use codegen, as follows:

``` lang-cs
public class FeatureTypeLoader : MonoBehaviour

    }
}
```

## Use code generation

Instead of storing type names, you can generate a C# file at Editor time that contains a static array of types or delegates, eliminating all runtime reflection. The following code example generates a file `Assets/GeneratedFeatureTypes.cs` with a static array of the discovered types, which you can use at runtime with no reflection:

``` lang-cs
using UnityEditor;
using System;
using System.Linq;
using System.Text;
using System.IO;

public static class FeatureTypeCodeGen
{
    [MenuItem("Tools/CodeGen IMyFeature Types")]
    public static void CodeGenTypes()
    {
        var featureType = typeof(IMyFeature);
        var types = AppDomain.CurrentDomain.GetAssemblies()
            .SelectMany(a => a.GetTypes())
            .Where(t => featureType.IsAssignableFrom(t) && !t.IsInterface && !t.IsAbstract)
            .ToList();

        StringBuilder sb = new StringBuilder();
        sb.AppendLine("public static class GeneratedFeatureTypes {");
        sb.AppendLine("    public static readonly System.Type[] Types = new System.Type[] {");
        foreach (var t in types)
        {
            sb.AppendLine($"        typeof({t.FullName}),");
        }
        sb.AppendLine("    };");
        sb.AppendLine("}");

        File.WriteAllText("Assets/GeneratedFeatureTypes.cs", sb.ToString());
        AssetDatabase.Refresh();
        Debug.Log("Generated FeatureTypes.cs with " + types.Count + " types.");
    }
}
```

## Additional resources

-   [Garbage collection modes](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-incremental-garbage-collection.html)
-   [Configuring garbage collection](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-disabling-garbage-collection.html)
-   [Optimizing your code for managed memory](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-code-managed-memory.html)
