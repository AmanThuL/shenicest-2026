---
title: "Unity 6.3 Manual: Code analysis and source generation"
page_title: "Unity - Manual: Code analysis and source generation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers.html"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Code analysis and source generation

A code analyzer examines your source code and reports diagnostics to help find errors or enforce rules. A source generator runs during compilation and creates additional source code that becomes part of your program.

In the C#/.NET ecosystem, source generators and analyzers are both built on the same Roslyn compiler platform, and analyzers are typically referred to as Roslyn analyzers.

Both analyzers and source generators are imported as managed plugins to your Unity project. You can either write your own analyzer or source generator or import existing third party libraries.

**Note**: Roslyn analyzers are only compatible with the [IDEs that Unity supports](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html).

For more information about how to write and use Roslyn analyzers, refer to [Analyzer Configuration](https://docs.microsoft.com/en-us/visualstudio/code-quality/use-roslyn-analyzers?view=vs-2019) and [Get started with Roslyn analyzers](https://docs.microsoft.com/en-us/visualstudio/extensibility/getting-started-with-roslyn-analyzers?view=vs-2019) in the Microsoft documentation.

| **Topic**                                                                                                                                                      | **Description**                                                                                                              |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------|
| **[Create and use a source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/create-source-generator.html)**                                     | Create a simple source generator and configure the Unity Editor to use it for your Unity project code.                       |
| **[Create and use a Roslyn analyzer](https://docs.unity3d.com/6000.3/Documentation/Manual/create-roslyn-analyzer.html)**                                       | Create a simple Roslyn analyzer and configure the Unity Editor to use it for your Unity project code.                        |
| **[Install and use an existing analyzer or source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html)**            | Download an existing code analyzer or source generator and configure the Unity Editor to use it for your Unity project code. |
| **[Additional files for Roslyn analyzers and source generators](https://docs.unity3d.com/6000.3/Documentation/Manual/roslyn-analyzers-additional-files.html)** | Define additional text files for Roslyn analyzers or source generators to use.                                               |
| **[Analyzer scope and rule set files](https://docs.unity3d.com/6000.3/Documentation/Manual/analyzer-scope-and-diagnostics.html)**                              | Control which parts of your code are subject to code analysis and customize diagnostic levels per-assembly.                  |

## Additional resources

-   [C# compiler](https://docs.unity3d.com/6000.3/Documentation/Manual/csharp-compiler.html)
-   [Debugging with Roslyn analyzers](https://unity.com/how-to/debugging-with-rosyln-analyzers)
