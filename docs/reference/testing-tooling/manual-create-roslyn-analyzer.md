---
title: "Unity 6.3 Manual: Create and use a Roslyn analyzer"
page_title: "Unity - Manual: Create and use a Roslyn analyzer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/create-roslyn-analyzer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/create-roslyn-analyzer.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create and use a Roslyn analyzer

You can use code analyzers to inspect your code for errors, rule violations, and coding style issues. As with source generators, you can use existing analyzers or create your own.

To create a Roslyn analyzer in your IDE and then apply it for use in your Unity project:

1.  In your IDE, create a C# class library project that targets .NET Standard 2.0 and name the project `ExampleAnalyzer`.

2.  Install the `Microsoft.CodeAnalysis.Csharp` NuGet package for the project. Your analyzer must use [Microsoft.CodeAnalysis.Csharp 4.3](https://www.nuget.org/packages/Microsoft.CodeAnalysis.CSharp/4.3.0) to work with Unity.

3.  In your IDE project, create a new C# file and add the following code:

    ``` lang-cs
    using System.Collections.Immutable;
    using Microsoft.CodeAnalysis;
    using Microsoft.CodeAnalysis.CSharp;
    using Microsoft.CodeAnalysis.CSharp.Syntax;
    using Microsoft.CodeAnalysis.Diagnostics;

    namespace ExampleAnalyzer
    
        private static void AnalyzeInvocation(SyntaxNodeAnalysisContext context)
        
    }
       }
    ```

4.  Build your analyzer with a **release** build configuration.

5.  In your analyzer’s project folder, find the `bin/Release/netstandard2.0/ExampleAnalyzer.dll` file.

6.  Copy this file into your Unity project, inside the `Assets` folder.

7.  Inside the Asset Browser, click on the .dll file to open the [Plugin Inspector](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html) window.

8.  Under **Select platforms for plugin**, uncheck **Any Platform**.

9.  Under **Include Platforms**, uncheck **Editor** and **Standalone** and any other checked platforms.

10. Under **Asset Labels**, click on the label icon to open the Asset labels sub-menu.

11. Create and assign a new label called **RoslynAnalyzer**. To do this, type `RoslynAnalyzer` in the text input field of the Asset labels sub-menu and press Enter. This label must match exactly and is case sensitive. Once created, the label appears in the Asset labels sub-menu from then on. You can click on the name of the label in the menu to assign it to other analyzers.

12. To test the analyzer is working, [create a new MonoBehaviour script](https://docs.unity3d.com/6000.3/Documentation/Manual/creating-scripts.html) in the Editor with the following code:

    ``` lang-cs
    using UnityEngine;

    public class TestScript : MonoBehaviour
    
    }
    ```

After Unity recompiles scripts, the following warning appears in the Console:

    TestScript.cs(8,9): warning EX0001: Debug.Log call detected - consider removing it before shipping

For more information on creating Roslyn analyzers, refer to [Tutorial: Write your first analyzer and code fix](https://learn.microsoft.com/en-us/dotnet/csharp/roslyn-sdk/tutorials/how-to-write-csharp-analyzer-code-fix) in the Microsoft documentation.

## Report analyzer diagnostics

To view information such as the total execution time of your analyzers and source generators or the relative execution times of each analyzer or source generator, go to **Edit** \> **Preferences** (macOS: **Unity** \> **Settings**) \> **Editor Diagnostics** \> **Core** and enable **EnableDomainReloadTimings**. When enabled, the information is displayed in the console window.

## Additional resources

-   [Install and use an existing analyzer or source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html)
-   [Create and use a source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/create-source-generator.html)
