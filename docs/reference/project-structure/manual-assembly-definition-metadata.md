---
title: "Assembly metadata and compilation details"
page_title: "Unity - Manual: Assembly metadata and compilation details"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-metadata.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-metadata.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Assembly metadata and compilation details

You can define additional metadata for your assemblies and retrieve information on the assemblies included in a [project build](https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html).

<span id="set-assembly-attributes"></span>

## Setting assembly attributes

You can use assembly attributes to set metadata properties for your assemblies. Although not a requirement, it’s good practice to define these attributes in a separate file named `AssemblyInfo.cs` alongside your Assembly Defintion.

For example, the following assembly attributes specify several .NET assembly metadata values and the Unity-defined [`Preserve`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PreserveAttribute.html) attribute, which affects how unused code is removed from an assembly when you build your project:

``` lang-cs
[assembly: System.Reflection.AssemblyCompany("Bee Corp.")]
[assembly: System.Reflection.AssemblyTitle("Bee's Assembly")]
[assembly: System.Reflection.AssemblyCopyright("Copyright 2020.")]
[assembly: UnityEngine.Scripting.Preserve]
```

<span id="get-assembly-info"></span>

## Getting assembly information in build scripts

Use the [`CompilationPipeline`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Compilation.CompilationPipeline.html) class to retrieve information about all assemblies built by Unity for a project, including those created based on Assembly Definition assets.

For example, the following script uses the `CompilationPipeline` class to list all the current Player assemblies in a project:

``` lang-cs
using UnityEditor;
using UnityEditor.Compilation;
public static class AssemblyLister

    }
}
```

## Additional resources

-   [Creating assembly definitions](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html)
-   [Referencing assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html)
-   [Assembly Definition properties](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html)
-   [Assembly Definition Reference properties](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionReferenceImporter.html)
-   [Assembly Definition File Format](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html)
