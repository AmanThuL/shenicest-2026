---
title: "Predefined assemblies reference"
page_title: "Unity - Manual: Predefined assemblies reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Predefined assemblies reference

Unity compiles scripts in four separate phases, based on where the script file is located within the project folder structure. Unity creates a separate C# project file (.csproj) and a predefined assembly for each phase. If there are no scripts eligible for a compilation phase, Unity doesn’t create the corresponding project file or assembly.

Compilation order is significant when a script references a class compiled in a different phase and therefore located in a different assembly. The basic rule is that a script can reference anything compiled in its own compilation phase or an earlier one, but can’t reference anything compiled in a later phase.

The phases of compilation are as follows:

| **Phase** | **Assembly name**                  | **Script files**                                                                                       |
|:----------|:-----------------------------------|:-------------------------------------------------------------------------------------------------------|
| 1         | `Assembly-CSharp-firstpass`        | Runtime scripts in folders called `Plugins`.                                                           |
| 2         | `Assembly-CSharp-Editor-firstpass` | Editor scripts in folders called `Editor` that are anywhere inside top-level folders called `Plugins`. |
| 3         | `Assembly-CSharp`                  | All other scripts that are not inside a folder called `Editor`.                                        |
| 4         | `Assembly-CSharp-Editor`           | All remaining scripts that are inside a folder called `Editor`.                                        |

You can create assembly definition files to organize the scripts in your project with your own assemblies. Defining your own assemblies can reduce the amount of code that Unity needs to recompile when you make an unrelated code change, and can provide more control over dependencies to other assemblies. For more information, refer to [Organizing scripts into assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html).

Unity reserves some project folder names for specific types of assets. Some of these folders affect the order of script compilation. For more information about these folders, refer to [Reserved folder name reference](https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html)

## Additional resources

-   [Conditional compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/conditional-compilation.html)
-   [Assembly definitions](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html)
