---
title: "Organizing scripts into assemblies"
page_title: "Unity - Manual: Organizing scripts into assemblies"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Organizing scripts into assemblies

Assemblies are individual units of compiled code that group types and resources together. Organizing scripts into assemblies has important advantages, especially as your codebase grows.

Assemblies help you think clearly about the architecture of your code and about managing dependencies. By exercising fine-grained control over references, you can reduce unnecessary recompilation time and make your code easier to debug.

| **Topic**                                                                                                                                                       | **Description**                                                                                                                  |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------|
| [Introduction to assemblies in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-intro.html)                                     | Understand the fundamentals of how assemblies work in Unity and why using them to organize your scripts is beneficial.           |
| [Creating assembly assets](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html)                                             | Create various kinds of assembly assets to customize your assemblies.                                                            |
| [Referencing assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html)                                            | Set up references between assemblies, override the default references and understand the limitations Unity places on references. |
| [Conditionally including assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-includes.html)                                    | Use scripting symbols to conditionally include or exclude assemblies from compilation.                                           |
| [Assembly metadata and compilation details](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-metadata.html)                             | Define metadata for your assemblies.                                                                                             |
| [Assembly Definition Inspector window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html)                    | Inspector-editable properties of assembly defintion assets and their meaning.                                                    |
| [Assembly Definition Reference Inspector window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionReferenceImporter.html) | Inspector-editable properties of assembly defintion reference assets and their meaning.                                          |
| [Assembly Definition file format reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html)                          | Assembly definition file format reference.                                                                                       |
| [Predefined assemblies reference](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html)                                       | Unity’s predefined assemblies and the order in which Unity compiles them.                                                        |

## Additional resources

-   [Special folders and script compilation order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html)
-   [Scripting backends](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends.html)
