---
title: "Yield instructions for the Editor"
page_title: "Unity - Manual: Yield instructions for the Editor"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Yield instructions for the Editor

One of the key additions a `[UnityTest]` provides over regular NUnit `[Test]` is the ability to yield instructions for the Unity Editor. From Unity tests you can skip frames and instruct the Editor to enter or exit Play mode, recompile scripts, or wait for a scheduled [domain reload](https://docs.unity3d.com/6000.3/Documentation/Manual/domain-reloading.html) to finish.

The following commonly-used yield instructions are pre-defined:

-   [EnterPlayMode](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.EnterPlayMode.html)
-   [ExitPlayMode](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.ExitPlayMode.html)
-   [RecompileScripts](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.RecompileScripts.html)
-   [WaitForDomainReload](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.WaitForDomainReload.html)

You can also define additional custom yield instructions for the Unity Editor for use in your Edit mode tests. For more information on how to do this, including usage examples, refer to the [`IEditModeTestYieldInstruction`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IEditModeTestYieldInstruction.html) interface API description.

For more information on using the `yield` statement in C#, refer to [yield statement](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/yield).

For information on the use of `yield`-returned instructions for the Editor in Unity coroutines, refer to [Splitting tasks across frames](https://docs.unity3d.com/6000.3/Documentation/Manual/Coroutines.html).

## Yield a MonoBehaviour to test

[`MonoBehaviourTest`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.MonoBehaviourTest-1.html) is a [coroutine](https://docs.unity3d.com/ScriptReference/Coroutine.html) and a helper for writing [MonoBehaviour](https://docs.unity3d.com/ScriptReference/MonoBehaviour.html) tests.

Yield return a `MonoBehaviourTest` from a Unity test to instantiate the `MonoBehaviour` you want to test and wait for it to finish running. Implement the `IMonoBehaviourTest` interface on the `MonoBehaviour` to define when the test completes. The following example demonstrates this:

``` lang-cs
[UnityTest]
public IEnumerator MonoBehaviourTest_Works()

public class MyMonoBehaviourTest : MonoBehaviour, IMonoBehaviourTest

    }

     void Update()
     
}
```

## Additional resources

-   [Edit mode and Play mode tests](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/edit-mode-vs-play-mode-tests.html)
-   [Coroutine](https://docs.unity3d.com/ScriptReference/Coroutine.html)
-   [YieldInstruction](https://docs.unity3d.com/ScriptReference/YieldInstruction.html)
