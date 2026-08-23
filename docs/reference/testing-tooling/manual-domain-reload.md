---
title: "Course 13. Domain reload"
page_title: "Unity - Manual: 13. Domain reload"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/domain-reload.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/domain-reload.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 13. Domain reload

## Learning objectives

In this section, you will learn how to invoke and wait for Domain Reloads.

## Intro and motivation

When performing actions that affect the scripts in a project, Unity performs a domain reload. Since a domain reload restarts all scripts, then it’s necessary to mark any expected domain reload by yielding a [`WaitForDomainReload`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.WaitForDomainReload.html). The command stops any further code execution and then resumes after the domain reload is done.

It’s also possible to yield a [`RecompileScripts`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.RecompileScripts.html) command. This does the same as `WaitForDomainReload` except that it performs an `AssetDatabase.Reload()` call. Both calls can be configured to expect whether a script compilation is expected to succeed.

If a domain reload happens while a test is running without yielding one of these commands, then the test will fail with an error about an unexpected domain reload.

## Exercise

The [sample](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/test-framework-general-introduction.html#import-samples) `13_DomainReload_Solution` is set up with a test class called `ScriptAddingTests`.

The test has two helper methods already implemented:

-   `CreateScript` creates a C# script with a class called `MyTempScript`. That has a method called `Verify`.

-   `VerifyScript` instantiates an instance of `MyTempScript` using reflection and returns the value from the `Verify` method. The expected return value is the string “OK”.

After running `CreateScript` Unity now has a new C# file in the project and thus needs to recompile. The task is to create a test that calls `CreateScript`, handles the domain reload and then verifies the output from `VerifyScript`.

Remember that your script should also clean up after itself, by deleting the file and recompiling the script again. This is recommended to do in a `TearDown` or `UnityTearDown`, which will run even if the test fails.

> **Important**: After importing, you should **move the sample test folder** `Tests_13` into the `Assets` folder for this exercise to work.

## Hints

-   If `RecompileScripts` is unavailable to you due to it being internal, then you need to upgrade the Unity Test Framework package to version 1.1.0 or higher.
-   If you are on a non-Windows machine you might want to change paths inside **k_fileName** or use C# [Path.Combine](https://docs.microsoft.com/en-us/dotnet/api/system.io.path.combine?view=net-6.0) for more cross-platform safe code.

## Solution

A full solution is available in the sample `13_DomainReload_Solution`.

The test can be implemented as follows:

``` lang-cs
internal class ScriptAddingTests

 [UnityTearDown]
 public IEnumerator Teardown()
 
  File.Delete(k_fileName);
  yield return new RecompileScripts();
 }
 
 private void CreateScript()
 
  }");
 }

 private string VerifyScript()
 
}
```

## Additional resources

[API reference for `RecompileScripts`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.RecompileScripts.html)  
[API reference for `WaitForDomainReload`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.WaitForDomainReload.html)
