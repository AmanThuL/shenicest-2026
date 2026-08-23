---
title: "Assembly Definition Inspector window reference"
page_title: "Unity - Manual: Assembly Definition Inspector window reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Assembly Definition Inspector window reference

Click on an Assembly Definition Asset to set the properties for an assembly in the Inspector window.

![The Name and General sections of configurable properties in the Assembly Definition importer Inspector window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/name-and-general.png)

<span id="name"></span>

## Name

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Name</strong></td><td style="text-align: left;">The name for the assembly (without a file extension). Assembly names must be unique across the Project. Consider using a reverse-DNS naming style to reduce the chance of name conflicts, especially if you want to use the assembly in more than one Project. For more information on .NET requirements and recommendations for assembly naming, refer to <a href="https://learn.microsoft.com/en-us/dotnet/standard/assembly/names">Assembly names</a>.<br />
<br />
<strong>Note</strong>: Unity uses the name you assign to the Assembly Definition asset as the default value of the Name field, but you can change the name as needed. However, if you reference an Assembly Definition by its name rather than its GUID, changing the name breaks the reference.</td></tr></tbody></table>

<span id="general"></span>

## General Options

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Allow ‘unsafe’ Code</strong></td><td style="text-align: left;">Enable this option if you have used the C# <a href="https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/unsafe"><code>unsafe</code></a> keyword in a script within the assembly. When enabled, Unity passes the <code>/unsafe</code> option to the C# compiler when it compiles the assembly.</td></tr><tr class="even"><td style="text-align: left;"><strong>Auto Referenced</strong></td><td style="text-align: left;">Specify whether this assembly is automatically referenced by Unity’s <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html">predefined assemblies</a>. When disabled, Unity does not automatically reference the assembly during compilation. This has no effect on whether Unity includes the assembly in the build.</td></tr><tr class="odd"><td style="text-align: left;"><strong>No Engine References</strong></td><td style="text-align: left;">When enabled, Unity does not add references to <code>UnityEditor</code> or <code>UnityEngine</code> assemblies when it compiles the assembly.</td></tr><tr class="even"><td style="text-align: left;"><strong>Override References</strong></td><td style="text-align: left;">Enable this option to manually specify which precompiled assemblies this assembly depends upon. When enabled, the Inspector shows the Assembly References section, which you can use to specify the references.<br />
<br />
A precompiled assembly is a library compiled outside your project. By default, assemblies you define in your project reference all the precompiled assemblies you add to the project. When you enable Override References, this assembly only references the precompiled assemblies you add under <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#assembly-references">Assembly References</a>.<br />
<br />
<strong>Note</strong>: To prevent project assemblies from automatically referencing a precompiled assembly, you can disable the precompiled assembly’s Auto Referenced option. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html">Import and configure plug-ins</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Root Namespace</strong></td><td style="text-align: left;">The default namespace for scripts in this assembly definition. If you use either <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html#rider">Rider</a> or <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html#visual-studio">Visual Studio</a> as your code editor, they automatically add this namespace to any new scripts you create in this assembly definition.</td></tr></tbody></table>

For more information, refer to [Create an Assembly Definition asset](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html#create-asmdef).

<span id="asmdef-references"></span>

## Assembly Definition References

![The Assembly Definition References and Assembly References sections of the Assembly Definition importer Inspector window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/assembly-ref.png)

| **Property**                       | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                         |
|:-----------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Assembly Definition References** | A list of assemblies to reference from the current assembly. Click the **+** button to add a new reference. Click the **-** button to remove a reference. Unity uses these references to compile the assembly and define the dependencies between assemblies.                                                                                                                                                                           |
| **Use GUIDs**                      | This setting controls how Unity serializes references to other Assembly Definition assets. When you enable this property, Unity saves the reference as the asset’s GUID, instead of the Assembly Definition name. It’s good practice to use the GUID instead of the name, because it means you can make changes to the name of an Assembly Definition asset without having to update other Assembly Definition files that reference it. |

For more information, refer to [Create an Assembly Definition asset](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html#create-asmdef).

<span id="assembly-references"></span>

## Assembly References

| **Property**            | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|:------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Assembly References** | The Assembly References section only appears when you enable the **Override References** property in the [**General Options**](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionImporter.html#general) section. Use this section to specify any references to precompiled assemblies on which this assembly depends. For more information, refer to [Referencing a precompiled, plugin assembly](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html#reference-precompiled-assembly). |

<span id="platforms"></span>

## Platforms

![The Platforms section of the Assembly Definition importer Inspector window with Any Platform selected.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/platforms.png)

| **Property**  | **Description**                                                                                                                                                                                                                                                                                                                                                        |
|:--------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Platforms** | The **Platforms** list defines which target platforms the assembly compiles for. If you select **Any Platform**, then Unity compiles the assembly for all platforms and excludes any individual platforms you select. If you deselect **Any Platform**, then Unity compiles the assembly for no platforms by default and includes any individual platforms you select. |

For more information, refer to [Creating a platform-specific assembly](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html#create-platform-specific).

<span id="define-constraints"></span>

## Define Constraints

![A list of preprocessor symbols configured in the Define Constraints section of the Assembly Definition importer Inspector window, with one constraint highlighted as currently unmet.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/define-constraints.png)

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Define Constraints</strong></td><td style="text-align: left;">Define constraints specify the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-symbol-reference.html">scripting symbols</a> that must be defined in your project for Unity to compile or reference an assembly. All the listed symbols must be defined for the assembly to compile. Constraints work like the <code>#if</code> <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html">preprocessor directive</a> in C#, but on the assembly level instead of the script level.<br />
<br />
Prefix a symbol with an exclamation (<code>!</code>) to negate it. For example, <code>!ENABLE_IL2CPP</code> specifies that the symbol <code>ENABLE_IL2CPP</code> must not be defined for the assembly to compile. Use the <code>||</code> (OR) operator to specify that at least one of the constraints must be present in order for the constraints to be satisfied. For example, <code>UNITY_IOS || UNITY_EDITOR_OSX</code> compiles the assembly when either <code>UNITY_IOS</code> or <code>UNITY_EDITOR_OSX</code> is defined. If any constraint is currently not met, Unity marks the individual constraint and the Define Constraints section with red information icons.<br />
<br />
You can use any of Unity’s <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-symbol-reference.html">built-in scripting symbols</a> and any <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/custom-scripting-symbols.html">custom scripting symbols</a> you’ve defined. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html">Platform dependent compilation</a>.<br />
<br />
<strong>Note</strong>: The <strong>Define Constraints</strong> apply to the currently active platform in your project <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html">Build Profiles</a>. To define a symbol for multiple platforms, you must switch to each platform and modify the <strong>Define Constraints</strong> field individually.</td></tr></tbody></table>

For more information, refer to [Conditionally including an assembly](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-includes.html).

<span id="version-defines"></span>

## Version Defines

![The Version Defines section of the Assembly Definition importer Inspector window, with defines configured for specific versions of the Unity Test Framework and VS Code packages.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/version-defines.png)

Specify which symbols to define according to the versions of the packages and modules in a project.

| **Property**                   | **Description**                                                                                                                                                     |
|:-------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **If resource**                | A package or module.                                                                                                                                                |
| **version is**                 | An expression defining a version or range of versions.                                                                                                              |
| **set define**                 | The symbol to define when an applicable version of the resource is also present in this project.                                                                    |
| **Version expression outcome** | The expression evaluated as a logical statement, where `x` is the version checked. If the expression outcome displays **Invalid** then the expression is malformed. |

For more information on defining these properties and the correct syntax for version expressions, refer to [Defining symbols based on project packages](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-includes.html#define-symbols).

## Additional resources

-   [Creating assembly definitions](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html)
-   [Referencing assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-referencing.html)
-   [Assembly Definition Reference properties](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AssemblyDefinitionReferenceImporter.html)
-   [Assembly Definition file format reference](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html)
