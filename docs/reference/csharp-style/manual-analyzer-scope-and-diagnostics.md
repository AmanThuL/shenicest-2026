---
title: "Unity 6.3 Manual: Analyzer scope and rule set files"
page_title: "Unity - Manual: Analyzer scope and rule set files"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/analyzer-scope-and-diagnostics.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/analyzer-scope-and-diagnostics.html"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Analyzer scope and rule set files

By default, analyzers in the root of the `Assets` folder apply to all the [predefined assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html) in your project: that is, to any scripts in the `Assets` folder or its subfolders that are not part of a custom assembly defined with an [assembly definition file](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html).

If an analyzer is in a folder that contains an [assembly definition file](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html), or one of its subfolders, the analyzer only applies to that assembly, and to any other assembly that references it.

By using assembly definitions, for example, a [package](https://docs.unity3d.com/6000.3/Documentation/Manual/PackagesList.html) can supply analyzers that only analyze code related to the package, which can help package users to use the package API correctly.

## Rule set files

You can further customize how code analyzer diagnostics are applied in different assemblies with a `.ruleset` file. Rule sets allow you to configure the interpretation of analyzer rules per-assembly. For example, you can promote warnings to errors for a specific assembly. For more information on how to create a custom rule set, refer to Microsoft’s Visual Studio documentation on [how to create a custom rule set](https://docs.microsoft.com/en-us/visualstudio/code-quality/how-to-create-a-custom-rule-set?view=vs-2019).

### Default rule set

You can create a rule set file named `Default.ruleset` in the `Assets` root folder. The rules defined in `Default.ruleset` apply to all [predefined assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html), and all assemblies that are built using [assembly definition files](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html).

#### Overriding the default rule set

You can create additional rule set files for specific assemblies to override the default rule set.

To override the rules in `Default.ruleset` for a predefined assembly, create a `.ruleset` file in the root of the `Assets` folder with the naming pattern `[PredefinedAssemblyName].ruleset`. For example, the rules in `Assembly-CSharp.ruleset` apply to the code in `Assembly-CSharp.dll`.

Only the following `.ruleset` files are allowed inside the root `Assets` folder:

-   `Default.ruleset`
-   `Assembly-CSharp.ruleset`
-   `Assembly-CSharp-firstpass.ruleset`
-   `Assembly-CSharp-Editor.ruleset`
-   `Assembly-CSharp-Editor-firstpass.ruleset`

To override the `Default.ruleset` for a custom assembly defined with an assembly definition (`.asmdef`) file, create a dedicated rule set file and place it alongside the `.asmdef` file. For example, `Assets/Scripts/Runtime/MyRuntimeAssembly.ruleset` might contain the rule set that overrides the default rule set for the assembly `Assets/Scripts/Runtime/MyRuntimeAssembly.asmdef`.

**Note**: The name of the `.ruleset` file for a custom assembly does not have to match the assembly name.

### Rule set scope and best practices

The `Default.ruleset` applies to all assemblies in the project, including predefined and custom assemblies, unless there are custom assembly-specific rule sets that override it. The `Default.ruleset` is the only single rule set file that can apply to more than one assembly.

Any additional custom `.ruleset` files have a one-to-one relationship with assemblies. A custom `.ruleset` file must be placed alongside the assembly definition (`.asmdef`) file for the assembly it applies to.

If you want the rule set to apply to all or most of the assemblies in your project, define your primary rule set in the `Default.ruleset` and create additional `.ruleset` files to exclude the other assemblies from it.

If you want the rule set to apply to a minority of the assemblies in your project, make copies of your rule set next to each of the assemblies you want it to apply to.

### Workflow: Test rule set files in Unity

To test rule set files in Unity, follow these steps:

#### Step 1: Set up the rule set file

1.  Create a subfolder named `Subfolder` inside your project’s `Assets` folder.
2.  Inside `Subfolder`:
    1.  Create a new assembly definition (`.asmdef`) file.
    2.  Save a duplicate copy of `RethrowError.cs` from the [Install and use an existing analyzer or source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html) page.
3.  Create a `Default.ruleset` file inside `Assets` with the following code:

``` lang-xml
<?xml version="1.0" encoding="utf-8"?>
<RuleSet Name="New Rule Set" Description=" " ToolsVersion="10.0">
  <Rules AnalyzerId="ErrorProne.NET.CodeAnalyzers" RuleNamespace="ErrorProne.NET.CodeAnalyzers">
    <Rule Id="ERP021" Action="Error" />
  <Rule Id="EPC12" Action="None" />
  </Rules>
</RuleSet>
```

The `Default.ruleset` file defines the following rules:

-   Suppress `EPC12`, the warning about suspicious exception handling.
-   Elevate `ERP021`, the warning about incorrect exception propagation, to an error.

#### Step 2: Reload the project

After you add the rule set files to your project, reimport any script that belongs to the assembly the rules apply to. This forces Unity to recompile the assembly using the new rule set files. After recompilation, two messages appear in the Console window:

`Assets\Subfolder\RethrowError.cs(15,19): error ERP021: Incorrect exception propagation. Use throw; instead.`

`Assets\RethrowError.cs(15,19): error ERP021: Incorrect exception propagation. Use throw; instead.`

Notice that Unity applies the rules defined in `Default.ruleset` to both `Assets/RethrowError.cs` and `Assets/Subfolder/RethrowError.cs`.

#### Step 3: Add a custom rule set

In `Assets/Subfolder`, create a `.ruleset` file, and give it any name you like (in this example `Hello.ruleset`):

``` lang-xml
<?xml version="1.0" encoding="utf-8"?>
<RuleSet Name="New Rule Set" Description=" " ToolsVersion="10.0">
  <Rules AnalyzerId="ErrorProne.NET.CodeAnalyzers" RuleNamespace="ErrorProne.NET.CodeAnalyzers">
    <Rule Id="ERP021" Action="Info" />
    <Rule Id="EPC12" Action="Info" />
  </Rules>
</RuleSet>
```

This new `Hello.ruleset` file tells Unity to print both `EPC12` and `ERP021` to the Console, without treating them as warnings or errors.

After Unity compiles the project again, the following messages appear in the Console window:

`Assets\Subfolder\RethrowError.cs(14,23): info EPC12: Suspicious exception handling: only e.Message is observed in exception block.`

`Assets\Subfolder\RethrowError.cs(15,19): info ERP021: Incorrect exception propagation. Use throw; instead.`

`Assets\RethrowError.cs(15,19): error ERP021: Incorrect exception propagation. Use throw; instead.`

The rules in `Default.ruleset` still apply to `Assets\RethrowError.cs`, but they no longer apply to `Assets\Subfolder\RethrowError.cs`, because the rules in `Hello.ruleset` override them.

For more information on all the allowed rule set action files, refer to the Visual Studio documentation on [Using the code analysis rule set editor](https://docs.microsoft.com/en-us/visualstudio/code-quality/working-in-the-code-analysis-rule-set-editor?view=vs-2019).

### Alternatives to rule set files

If you control the analyzer code, you can write the analyzer itself to behave differently based on particular locations or assemblies. For example, you might write the analyzer code to return without analyzing anything under `Assets/ThirdParty` to prevent it running on third party code.

For example, the following code snippet demonstrates how you might modify the example analyzer created in [Create and use a Roslyn analyzer](https://docs.unity3d.com/6000.3/Documentation/Manual/create-roslyn-analyzer.html) to return early if the code under analysis is in the `Assets/ThirdParty` or `Assets/Legacy` paths:

``` lang-cs
private static void AnalyzeInvocation(SyntaxNodeAnalysisContext context)

private static bool IsInExemptPath(string filePath)

```

Alternatively, you can use [editorconfig](https://learn.microsoft.com/en-us/visualstudio/ide/create-portable-custom-editor-options?view=visualstudio) file to centralize exclusions. For example, the following `.editorconfig` in the root of a project adjusts the `EX0001` warning created in the [Create and use a Roslyn analyzer](https://docs.unity3d.com/6000.3/Documentation/Manual/create-roslyn-analyzer.html) example to an error:

    root = true

    [*.cs]
    # Set EX0001 to error
    dotnet_diagnostic.EX0001.severity = error

## Additional resources

-   [Special folders and script compilation order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html)
-   [Organizing scripts into assemblies](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html)
