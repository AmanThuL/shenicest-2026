---
title: "Performing actions before setup or after tear down (IOuterUnityTestAction)"
page_title: "Unity - Manual: Performing actions before setup or after tear down"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-outerunitytestaction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-outerunitytestaction.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Performing actions before setup or after tear down

[`OuterUnityTestAction`](https://docs.unity3d.com/Packages/com.unity.test-framework@latest/index.html?subfolder=/api/UnityEngine.TestTools.IOuterUnityTestAction.html) is a wrapper outside of the tests, which allows for any tests with this attribute to run code before and after the tests. This method allows for yielding commands in the same way as `UnityTest`. The attribute must inherit the `NUnit` attribute and implement `IOuterUnityTestAction`.

## OuterUnityTestAction example

``` lang-cs
using System.Collections;
using NUnit.Framework;
using NUnit.Framework.Interfaces;
using UnityEngine;
using UnityEngine.TestTools;

public class MyTestClass

}

public class MyOuterActionAttribute : NUnitAttribute, IOuterUnityTestAction

    public IEnumerator AfterTest(ITest test)
    
}
```

## Execution order

Unity outer test action is not rerun on domain reload but non-Unity action attributes are:

![The order of execution for outer test action callbacks, with those that re-run on domain reload differentiated from those that don’t.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/test-framework/execution-order-outerunitytestaction.png)

### Test actions with domain reload example

``` lang-cs
using NUnit.Framework.Interfaces;

public class TestActionOnSuiteAttribute : NUnitAttribute, ITestAction

    public void AfterTest(ITest test)
    
    public ActionTargets Targets { get { return ActionTargets.Suite; } }
}

public class TestActionOnTestAttribute : NUnitAttribute, ITestAction

    public void AfterTest(ITest test)
    
    public ActionTargets Targets { get { return ActionTargets.Test; } }
}

public class OuterTestAttribute : NUnitAttribute, IOuterUnityTestAction

    public IEnumerator AfterTest(ITest test)
    
}

[TestActionOnSuite]
public class ActionOrderTestBase

    [UnityTest, OuterTest, TestActionOnTest]
    public IEnumerator UnityTestWithDomainReload()
    
}
```

## Additional resources

-   [Setting up and cleaning up at build time](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-setup-and-cleanup.html)
-   [Execution order of test actions](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-actions-outside-tests.html)
