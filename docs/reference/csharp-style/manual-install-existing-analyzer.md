---
title: "Unity 6.3 Manual: Install and use an existing analyzer or source generator"
page_title: "Unity - Manual: Install and use an existing analyzer or source generator"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Install and use an existing analyzer or source generator

This example uses the [ErrorProne.NET.CoreAnalyzers](https://www.nuget.org/packages/ErrorProne.NET.CoreAnalyzers/) library to demonstrate how to install code analyzers or source generators from NuGet:

1.  Download the library as a .zip file with the **Download package** button.
2.  Extract the contents of the .zip file.
3.  Inside the extracted folder, locate the .dll files that contain the analyzers. In this example, navigate to **`errorprone.net.coreanalyzers<version-number>\analyzers\dotnet\cs`**. The required files should be in this folder, named `ErrorProne.NET.Core.dll`, `ErrorProne.Net.CoreAnalyzers.dll`, and `RuntimeContracts.dll`.
4.  Move these files into the Assets folder, or any folder nested inside of the Assets folder, in your Unity project. To do this, either go to **Assets** > **Import new asset** and select the .dll for each of the three files, or copy them into your project’s `Assets` folder through your device’s file browser.
5.  Click on the .dll file inside the **Asset Browser** inside Unity to open the **[Plugin Inspector](https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html)** window.
6.  Inside the Plugin Inspector window:
    -   Under the **Select platforms for plugin** heading, disable **Any Platform**.
    -   Under the **Include Platforms** heading, disable **Editor** and **Standalone**.
7.  Under the **Asset Labels** heading in the Plugin Inspector window, click on the blue label icon to open the **Asset Labels** sub-menu.
8.  Create and assign a new label called `RoslynAnalyzer`. To do this, type `RoslynAnalyzer` into the text input window in the **Asset Labels** sub-menu and press **Return**. This label must exactly match the example and is case sensitive. After you create the label for the first analyzer, it appears on the list of available labels in the **Asset Labels** sub-menu. You can click on the name of the label in the menu to assign it to other analyzers.

Unity recognizes the `RoslynAnalyzer` label and treats assets with this label as Roslyn analyzers or source generators. When you assign the label to an analyzer, Unity recompiles scripts within the scope of the analyzer and analyzes the code in those scripts according to the rules in the analyzer.

Any scripts that are within the same assembly definition as an analyzer are in that analyzer’s scope. For analyzers in the root level of the `Assets` folder, Unity considers all files in the project to be in scope. For more information about scope, refer to [Analyzer scope and rule set files](https://docs.unity3d.com/6000.3/Documentation/Manual/analyzer-scope-and-diagnostics.html).

To test that your analyzers work correctly, follow the example below. If you have installed the analyzers correctly, the ErrorProne.NET analyzer raises warnings when it analyzes the code in the example.

Create a new script file named `RethrowError.cs`. Copy the following code into this script and save the file:

``` lang-cs
using System;
using UnityEngine;

public class RethrowError : MonoBehaviour

        catch (Exception e)
        
    }

    private void DoSomethingInteresting()
    
}
```

When you save the file, Unity recompiles the script and runs any applicable analyzers on the script’s code. When the ErrorProne.NET analyzer is correctly installed, it raises the following warnings in the Console window about the above code:

`Assets\RethrowError.cs(14,23): warning EPC12: Suspicious exception handling: only e.Message is observed in exception block.`

`Assets\RethrowError.cs(15,19): warning ERP021: Incorrect exception propagation. Use throw; instead.`

## Additional resources

-   [Create and use a source generator](https://docs.unity3d.com/6000.3/Documentation/Manual/create-source-generator.html)
-   [Analyzer scope and rule set files](https://docs.unity3d.com/6000.3/Documentation/Manual/analyzer-scope-and-diagnostics.html)
