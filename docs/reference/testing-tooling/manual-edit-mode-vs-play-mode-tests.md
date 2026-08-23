---
title: "Edit mode and Play mode tests"
page_title: "Unity - Manual: Edit mode and Play mode tests"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/edit-mode-vs-play-mode-tests.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/edit-mode-vs-play-mode-tests.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Edit mode and Play mode tests

Unity Test Framework identifies tests as either Edit mode tests or Play mode tests depending on the references of their parent assembly.

## Edit mode tests

Edit mode tests (also known as Editor tests) only run in the Unity Editor and have access to Editor code and runtime application code. As such, Edit mode test assemblies can reference code in both the `UnityEditor` and `UnityEngine` namespaces.

With Edit mode tests you can test any of your [Editor extensions](https://docs.unity3d.com/6000.3/Documentation/Manual/ExtendingTheEditor.html) using the [`[UnityTest]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTestAttribute.html) attribute. Edit mode tests run in the [EditorApplication.update](https://docs.unity3d.com/ScriptReference/EditorApplication-update.html) callback loop. You can’t run [coroutines](https://docs.unity3d.com/ScriptReference/Coroutine.html) in Edit mode tests.

You can also control entering and exiting Play mode from an Edit mode test, allowing your test to make changes before entering Play mode.

Edit mode tests must have an [assembly definition](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html) that references `nunit.framework.dll` and have the Editor as their only target platform:

``` lang-json
assembly
    "includePlatforms": [
        "Editor"
    ],
```

## Play mode tests

You can run Play mode tests [in a Player](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-playmode-test-standalone.html) or inside the Editor. Play mode tests allow you to test your runtime application code, and the tests run as [coroutines](https://docs.unity3d.com/ScriptReference/Coroutine.html) if marked with the `[UnityTest]` attribute.

Play mode tests must fulfill the following conditions:

-   Tests must have their own [assembly definition](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html) with a reference to `nunit.framework.dll`.
-   Test scripts must be in a folder alongside the .asmdef file.
-   The test assembly must reference any additional assemblies containing code you want to test.

``` lang-json
assembly
    "references": [
        "NewAssembly"
    ],
    "optionalUnityReferences": [
        "TestAssemblies"
   ],
    "includePlatforms": [],
```

**Note**: Your test assembly can’t reference the predefined `Assembly-Csharp.dll` assembly. You must move code you want to test into a custom assembly that your test assembly references. For more information, refer to [Creating assembly assets](https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html).

## Recommendations

Use the NUnit [`[Test]`](https://docs.nunit.org/articles/nunit/writing-tests/attributes/test.html) attribute instead of the [`[UnityTest]`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.UnityTestAttribute.html) unless:

-   You need to [yield instructions for the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html) in Edit mode tests
-   You need to skip a frame or wait for a certain amount of time in Play mode tests.

## Additional resources

-   [Create a test assembly](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html)
-   [Create a test](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test.html)
