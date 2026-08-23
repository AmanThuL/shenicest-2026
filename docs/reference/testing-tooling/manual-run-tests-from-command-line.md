---
title: "Run tests from the command line"
page_title: "Unity - Manual: Run tests from the command line"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/run-tests-from-command-line.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/run-tests-from-command-line.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Run tests from the command line

You can run a test project from the Unity Editor command line. The following example demonstrates this on Windows:

``` lang-bash
Unity.exe -runTests -batchmode -projectPath PATH_TO_YOUR_PROJECT -testResults C:\temp\results.xml -testPlatform PS4
```

**Note**: Use the `-batchmode` option when running tests on the command line to remove the need for manual user inputs. For more information, refer to [Unity Editor command-line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html).

For the full list of Editor command line arguments provided by Unity Test Framework, refer to [Command-line reference](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-command-line.html).

## Additional resources

-   [Command-line reference](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-command-line.html)
-   [Unity Editor command-line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html)
