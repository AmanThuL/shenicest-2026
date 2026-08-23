---
title: "Modifying a Player build for tests (TestPlayerBuildModifier)"
page_title: "Unity - Manual: Modifying a Player build for tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-attribute-testplayerbuildmodifier.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-attribute-testplayerbuildmodifier.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Modifying a Player build for tests

You can run Play mode tests in a Platform-specific standalone Player. The [`[TestPlayerBuildModifier]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEditor.TestTools.TestPlayerBuildModifierAttribute.html) attribute provides a number of configurable options to control the properties of the Player built to run your tests.

## Modify Player build options for Play mode tests

You can change the [BuildPlayerOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html) for the test Player, to achieve custom behavior when running Play mode tests. Modifying the build options allows for changing the target location of the build as well as changing [BuildOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html).

To modify the `BuildPlayerOptions`, do the following:

-   Implement the `ITestPlayerBuildModifier`
-   Reference the implementation type in a `TestPlayerBuildModifier` attribute on an assembly level.

The following example demonstrates this:

``` lang-cs
using UnityEditor;
using UnityEditor.TestTools;

[assembly:TestPlayerBuildModifier(typeof(BuildModifier))]
public class BuildModifier : ITestPlayerBuildModifier

        playerOptions.options |= BuildOptions.AllowDebugging; // Enable allow Debugging flag on the test Player.
        return playerOptions;
    }
}
```

**Note:** When building the Player, it includes all `TestPlayerBuildModifier` attributes across all loaded assemblies, independent of the currently used test filter. As the implementation references the `UnityEditor` namespace, the code is typically implemented in an Editor only assembly, as the `UnityEditor` namespace is not available otherwise.

## Build a Player without running tests

It’s possible to use the Unity Editor to build the Player with tests but without [running the tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-playmode-test-standalone.html). This allows for running the Player on another machine, for example. In this case, it is necessary to modify the Player to build and implement a custom handling of the test result.

You can use `[TestPlayerBuildModifier]` to set the `BuildOptions` to build the Player to a specific location but not run it. Combined with [PostBuildCleanup](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-setup-and-cleanup.html#prebuildsetup-and-postbuildcleanup), you can automatically exit the Editor on completion of the build. The following example demonstrates this:

``` lang-cs
using System;
using System.IO;
using System.Linq;
using Tests;
using UnityEditor;
using UnityEditor.TestTools;
using UnityEngine;
using UnityEngine.TestTools;

[assembly:TestPlayerBuildModifier(typeof(HeadlessPlayModeSetup))]
[assembly:PostBuildCleanup(typeof(HeadlessPlayModeSetup))]

namespace Tests

            playerOptions.locationPathName = headlessBuildLocation;

            // Instruct the cleanup to exit the Editor if the run came from the command line. 
            // The variable is static because the cleanup is being invoked in a new instance of the class.
            s_RunningPlayerTests = true;
            return playerOptions;
        }

        public void Cleanup()
        {
            if (s_RunningPlayerTests && IsRunningTestsFromCommandLine())
            {
                // Exit the Editor on the next update, allowing for other PostBuildCleanup steps to run.
                EditorApplication.update += () => { EditorApplication.Exit(0); };
            }
        }

        private static bool IsRunningTestsFromCommandLine()
        
    }
}
```

If the Editor is still running after the Play Mode tests have run, the Player tries to report the results back, using [PlayerConnection](https://docs.unity3d.com/ScriptReference/Networking.PlayerConnection.PlayerConnection.html), which has a reference to the IP address of the Editor machine, when built.

To implement a custom way of reporting the results of the test run, let one of the assemblies in the Player include a [`TestRunCallback`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestRunner.TestRunCallbackAttribute.html). At `RunFinished`, it is possible to get the full test report as XML from the [NUnit](http://www.nunit.org/) test result by calling `result.ToXml(true)`. You can save the result and then save it on the device or send it to another machine as needed.

## Additional resources

-   [Run Play mode tests in a Player](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-playmode-test-standalone.html)
