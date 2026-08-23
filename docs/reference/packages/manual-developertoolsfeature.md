---
title: "Engineering feature set"
page_title: "Unity - Manual: Engineering feature set"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DeveloperToolsFeature.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/DeveloperToolsFeature.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Engineering feature set

The Engineering feature set contains packages for integration of C# integrated development environments (IDEs), unit testing, code coverage and performance analysis.

## Getting started

For a list of IDEs Unity supports, refer to [Integrated development environment (IDE) support](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html).

To choose which IDE to use with the Unity Editor, open the [Preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/Preferences.html) window, then go to **External Tools** \> **External Script Editor**.

The Unity Test Framework (UTF) lets you test your code in both Edit mode and Play mode, and also on target platforms such as Standalone, Android, and iOS.

To access the Unity Test Framework (UTF) in the Unity Editor, go to **Window** \> **General** \> **Test Runner**.

The Profile Analyzer aggregates and visualizes frame and marker data from a set of Unity Profiler frames to help you understand their behavior. You can use the Profile Analyzer to compare two sets of data side-by-side, which complements the single frame analysis already available in the Unity Profiler.

To open the Profile Analyzer window, go to **Window** \> **Analysis** \> **Profile Analyzer**.

Use the Code Coverage package with the Test Runner to gather and present test coverage information. Run your tests with code coverage enabled to check which lines of code execute when the tests run, and whether the tests pass or fail.

To open the Code Coverage window in the Unity Editor, go to **Window** \> **Analysis** \> **Code Coverage**.

Use the Editor coroutines package to start the execution of [iterator methods](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/yield) within the Editor, similar to how Unity handles [coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines.html) inside [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) scripts during runtime.

## Packages

The Engineering feature set contains the following packages:

-   [Visual Studio Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ide.visualstudio.html)
-   [JetBrains Rider Integration](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ide.rider.html)
-   [Test Framework](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.test-framework.html)
-   [Profile Analyzer](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.performance.profile-analyzer.html)
-   [Code Coverage](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.testtools.codecoverage.html)
-   [Editor coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.editorcoroutines.html)

## Additional resources

-   [Integrated development environment (IDE) support](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html)
-   [Unity Test Framework overview](https://docs.unity3d.com/Packages/com.unity.test-framework@1.1/manual/index.html)
-   [Profile Analyzer overview](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@1.1/manual/index.html)
-   [Code Coverage overview](https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.1/manual/index.html)
-   [Editor coroutines overview](https://docs.unity3d.com/Packages/com.unity.editorcoroutines@0.0/manual/index.html)
-   [Unity Engine forum](https://discussions.unity.com/c/unity-engine/52) (Unity Discussions forum)
