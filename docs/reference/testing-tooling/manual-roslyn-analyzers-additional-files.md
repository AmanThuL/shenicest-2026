---
title: "Unity 6.3 Manual: Additional files for Roslyn analyzers and source generators"
page_title: "Unity - Manual: Additional files for Roslyn analyzers and source generators"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers-additional-files.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers-additional-files.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Additional files for Roslyn analyzers and source generators

You can add [additional files](https://github.com/dotnet/roslyn/blob/main/docs/analyzers/Using%20Additional%20Files.md) to your project for a Roslyn analyzer or source generator to consume. The Unity Editor recognizes files as additional files for Roslyn analyzers if they have the .additionalfile extension and are somewhere in the `Assets` folder or one of its subfolders.

## Naming additional files

To be passed to the compilation pipeline, files must be named according to the format `Filename.[Analyzer Name].additionalfile`. Files that lack the `[Analyzer Name]` component are imported but not passed to the compilation pipeline. The `[Analyzer Name]` component is case-sensitive and must match the name of the analyzer the additional file targets. The `Filename` component must not contain a period (`.`) character.

<span id="filtering"></span>

## Additional file filtering

Each compiled assembly receives a list of additional files based on the analyzers running for that [assembly definition](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-files.html), filtered by the `[Analyzer Name]`. For example, consider a project with the following assemblies and analyzers:

-   Assembly1 uses an analyzer named `Analyzer1`
-   Assembly2 uses an analyzer named `Analyzer2`
-   Assembly3 uses both `Analyzer1` and `Analyzer2`

If the project contains four additional files named `FileA.Analyzer1.additionalfile`, `FileB.Analyzer2.additionalfile`, `FileC.additionalfile`, and `FileD.Analyzer3.additionalfile`, then Unity passes the following list of additional files with the respective assemblies:

-   Assembly1: `FileA.Analyzer1.additionalfile`
-   Assembly2: `FileB.Analyzer2.additionalfile`
-   Assembly3: `FileA.Analyzer1.additionalfile`, `FileB.Analyzer2.additionalfile`

Since `FileC` has no `[Analyzer Name]` component and `FileD` references an analyzer that isn’t present in the project, Unity doesn’t pass either one to the compilation pipeline.

## Retrieving available additional files from code

Analyzers can retrieve the full list of additional files included in the compiled assembly from the analyzer context. This list comprises all additional files included in the assembly, not just the ones matching the name of the current analyzer. The following example demonstrates this:

``` lang-cs
using System.IO;
using System.Linq;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp.Syntax;

namespace SourceGeneratorTest1;

[Generator]
public class SG2 : ISourceGenerator

        var @namespace = context.Compilation.SyntaxTrees.First().GetRoot().DescendantNodes().OfType<NamespaceDeclarationSyntax>().FirstOrDefault()?.Name?.ToString() ?? "NoNamespace";

        // an additional file has been passed; read the type name from the file.
        string generatedTypeName = File.ReadAllText(pathOfFileWithTypeName.Path);

        context.AddSource(
            "SG2.generated.cs", 
            $$"""
            namespace {{@namespace}}
            {
                public partial class {{generatedTypeName}}
                
            }
            """);
    }

    public void Initialize(GeneratorInitializationContext context)
    
}
```

**Note**: This example is only intended to demonstrate using the analyzer context to check for additional files. A production-ready source generator requires more comprehensive code to handle errors and ensure correct function and performance.

In the previous [filtering example](https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers-additional-files.html#filtering), `Analyzer1` and `Analyzer2` can both retrieve additional files for Assembly3 that are named after either of them. Each analyzer is responsible for checking if there is any data it can use in the additional files.

You can also retrieve the list of additional files included for a given assembly by using the [ScriptCompilerOptions.RoslynAdditionalFilePaths](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Compilation.ScriptCompilerOptions.RoslynAdditionalFilePaths.html) property in Editor code.

## Additional resources

-   [ScriptCompilerOptions.RoslynAdditionalFilePaths](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Compilation.ScriptCompilerOptions.RoslynAdditionalFilePaths.html)
-   [Create and use a source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/create-source-generator.html)
-   [Install and use an existing analyzer or source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html)
