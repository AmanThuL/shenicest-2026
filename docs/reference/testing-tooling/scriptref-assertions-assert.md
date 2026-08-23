---
title: "Scripting API: Assertions.Assert"
page_title: "Unity - Scripting API: Assert"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Assert

class in UnityEngine.Assertions

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

The Assert class contains assertion methods for setting invariants in the code.

All method calls will be conditionally included only in a development build, unless specified explicitly. See [BuildOptions.ForceEnableAssertions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.ForceEnableAssertions.html). The inclusion of an assertion is controlled by the `UNITY_ASSERTIONS` define.  
  
Assert throws exceptions whenever an assertion fails.  
  
If a debugger is attached to the project (System.Diagnostics.Debugger.IsAttached is true), [AssertionException](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.AssertionException.html) is thrown to pause the execution and invoke the debugger.

``` codeExampleCS
using UnityEngine;
using UnityEngine.Assertions;

public class AssertionExampleClass : MonoBehaviour

}
```

### Static Methods

| Method                                                                                                                                    | Description                                                      |
|-------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
| [AreApproximatelyEqual](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.AreApproximatelyEqual.html)       | Assert the values are approximately equal.                       |
| [AreEqual](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.AreEqual.html)                                 | Assert that the values are equal.                                |
| [AreNotApproximatelyEqual](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.AreNotApproximatelyEqual.html) | Asserts that the values are approximately not equal.             |
| [AreNotEqual](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.AreNotEqual.html)                           | Assert that the values are not equal.                            |
| [IsFalse](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.IsFalse.html)                                   | Return true when the condition is false. Otherwise return false. |
| [IsNotNull](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.IsNotNull.html)                               | Assert that the value is not null.                               |
| [IsNull](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.IsNull.html)                                     | Assert the value is null.                                        |
| [IsTrue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.IsTrue.html)                                     | Asserts that the condition is true.                              |
